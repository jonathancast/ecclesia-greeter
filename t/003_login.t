use strict;
use warnings;

no indirect;

use autodie;

use v5.26;
use feature 'signatures';
no warnings 'experimental::signatures';

use FindBin;
use lib $FindBin::RealBin.'/lib';

use Carp qw/ croak /;

use Test::More;
use Plack::Test;

use Try::Tiny;

use HTTP::Cookies;
use HTTP::Request::Common;

use JSON::MaybeXS qw/ decode_json encode_json /;

use T::TestDB;

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

        my $res = $sut->request(GET "$host/ping");
        is $res->code, 403, 'Checking for a valid session before logging in fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'unauthorized', code => 'notloggedon', }, '. . . and it returns the right value' or diag explain $json;

        $res = $sut->request(POST "$host/login", ContentType => 'application/json', Content => encode_json($params));
        is $res->code, 200, 'Trying to login with correct credentials succeeds';
        $json = try { decode_json($res->decoded_content) };
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

    subtest 'API requires login' => sub {
        my $res = $sut->request(GET "$host/api/nosuchpath");
        is $res->code, 403, 'Requesting an API path without a login fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'unauthorized', code => 'notloggedon', }, '. . . and it returns the right value' or diag explain $json;

        my $jar = HTTP::Cookies->new();
        $res = $sut->request(POST "$host/login", ContentType => 'application/json', Content => encode_json($params));
        croak "Couldn't log in with ".Dumper($params).'  ' unless $res->code == 200;
        $jar->extract_cookies($res);
        my $req = GET "$host/api/nosuchpath";
        $jar->add_cookie_header($req);
        $res = $sut->request($req);
        is $res->code, 404, 'Requesting an API path with a login does not return a 403';
    };
};

done_testing;
