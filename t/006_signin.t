use strict;
use warnings;

no indirect 'fatal';

use autodie;

use v5.26;
use feature 'signatures';
no warnings 'experimental::signatures';

use FindBin;
use lib $FindBin::RealBin.'/lib';

use Try::Tiny;

use Test::More;
use Plack::Test;

use HTTP::Request::Common;

use JSON::MaybeXS qw/ decode_json encode_json /;

use T::TestDB;
use T::TestLogin;

with_login(sub($sut) {
    my $visitor = {
        name => 'John Smith',
        phone => '111-555-3333',
        email => 'john@smith.com',
        address => '1234 Some Street',
        address2 => 'Apt 3',
        city => 'North South',
        state => 'TX',
        number => 3,
        num_children => 1,
    };

    subtest 'No visitor' => sub {
        my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({}));
        is $res->code, 400, 'Trying to check in without a visitor object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'novisitor', msg => 'You must supply a visitor hash', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'No name' => sub {
        delete local $visitor->{name};
        my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'noname', msg => 'You must supply a visitor name', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'No number' => sub {
        delete local $visitor->{number};
        my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'nonumber', msg => 'You must supply a number of visitors', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'Wrong number' => sub {
        local $visitor->{number} = 0;
        my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'nonumber', msg => 'You must supply a number of visitors', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'No num_children' => sub {
        delete local $visitor->{num_children};
        my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'nonum_children', msg => 'You must supply a number of children', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'Wrong num_children' => sub {
        local $visitor->{num_children} = -1;
        my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'nonum_children', msg => 'You must supply a number of children', }, '. . . and it returns the right errors' or diag explain $json;
    };

    my @rt_fields = qw/ name phone email address address2 city state number num_children /;

    subtest 'Valid use case' => sub {
        try {
            my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
            is $res->code, 200, 'Trying to sign in with valid visitor information succeeds';
            my $json = try { decode_json($res->decoded_content) };
            isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
            is_deeply $json, { status => 'ok', }, '. . . and it returns the right result' or diag explain $json;

            my $db = schema->resultset('Visitor')->single();
            for my $field (@rt_fields) {
                is $db->$field, $visitor->{$field}, ". . . and it places $field in the database";
            }
            cmp_ok $db->date, '<=', DateTime->now(time_zone => 'America/Chicago'), '. . . and it places a correct time-stamp in the database';
            cmp_ok $db->date, '>=', DateTime->now(time_zone => 'America/Chicago')->subtract(seconds => 5), '. . . and it places a correct time-stamp in the database';
        } catch { die $_ } finally {
            schema->resultset('Visitor')->delete();
        };
    };

    for my $optional_field (qw/ phone email address address2 city state /) {
        subtest "You can omit $optional_field" => sub {
            try {
                delete local $visitor->{$optional_field};
                my $res = $sut->request(POST '/api/visitor/signin', ContentType => 'application/json', Content => encode_json({ visitor => $visitor, }));
                is $res->code, 200, 'Trying to sign in with valid visitor information succeeds';
                my $json = try { decode_json($res->decoded_content) };
                isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
                is_deeply $json, { status => 'ok', }, '. . . and it returns the right result' or diag explain $json;

                my $db = schema->resultset('Visitor')->single();
                for my $field (@rt_fields) {
                    is $db->$field, $visitor->{$field}, ". . . and it places $field in the database";
                }
            } catch { die $_ } finally {
                schema->resultset('Visitor')->delete();
            };
        };
    }
});

done_testing();
