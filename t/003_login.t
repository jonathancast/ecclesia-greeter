use strict;
use warnings;

no indirect;

use autodie;

use Test::More;
use Plack::Test;

use Try::Tiny;

use HTTP::Cookies;
use HTTP::Request::Common;

use JSON::MaybeXS qw/ decode_json encode_json /;

BEGIN {
    use DBICx::Sugar qw/ schema /;
    use Ecclesia::Greeter::Stores::Schema;

    $ENV{DANCER_ENVIRONMENT} = 'test';

    system qw/ dropdb --if-exists unittest /;
    system qw/ createdb unittest /;

    my $dsn = 'dbi:Pg:dbname=unittest';
    Ecclesia::Greeter::Stores::Schema->connect($dsn)->deploy();
    DBICx::Sugar::config({ default => { dsn => $dsn, schema_class => 'Ecclesia::Greeter::Stores::Schema', } });
}

use Ecclesia::Greeter;

my $sut = Plack::Test->create(Ecclesia::Greeter->to_app);

my $host = 'https://greeter.localdomain:8080';

my $dev_login = {
    login_id => 'dev',
    password => 'devdev',
};

schema->resultset('User')->create($dev_login);

subtest 'Login' => sub {
    my $params = $dev_login;

    subtest 'No login id' => sub {
        delete local $params->{login_id};

        my $res = $sut->request(POST '/login', ContentType => 'application/json', Content => encode_json($params));
        is $res->code, 400, 'Trying to login without a login_id fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { code => 'badparams', missing => [ 'login_id', ], msg => 'You must supply a login_id', }, '. . . and it returns the right errors';
    };

    subtest 'No password' => sub {
        delete local $params->{password};

        my $res = $sut->request(POST '/login', ContentType => 'application/json', Content => encode_json($params));
        is $res->code, 400, 'Trying to login without a password fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { code => 'badparams', missing => [ 'password', ], msg => 'You must supply a password', }, '. . . and it returns the right errors';
    };

    subtest 'Invalid user' => sub {
        local $params->{login_id} = 'george';

        my $res = $sut->request(POST '/login', ContentType => 'application/json', Content => encode_json($params));
        is $res->code, 403, 'Trying to login with the wrong user fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { code => 'invalid_login', status => 'forbidden', msg => 'The username or password you supplied is incorrect', }, '. . . and it returns the right errors';
    };

    subtest 'Invalid password' => sub {
        local $params->{password} = 'george';

        my $res = $sut->request(POST '/login', ContentType => 'application/json', Content => encode_json($params));
        is $res->code, 403, 'Trying to login with the wrong password fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { code => 'invalid_login', status => 'forbidden', msg => 'The username or password you supplied is incorrect', }, '. . . and it returns the right errors';
    };

    subtest 'Valid login' => sub {
        my $jar = HTTP::Cookies->new();

        my $res = $sut->request(POST "$host/login", ContentType => 'application/json', Content => encode_json($params));
        is $res->code, 200, 'Trying to login with correct credentials succeeds';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { login_id => 'dev', }, '. . . and it returns the right user information';

        $jar->extract_cookies($res);

        my $req = GET "$host/ping";
        $jar->add_cookie_header($req);
        $res = $sut->request($req);
        is $res->code, 200, 'Checking for a valid session after logging in succeeds';
        $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'ok', }, '. . . and it returns the right value' or diag explain $json;
    };
};

done_testing;
