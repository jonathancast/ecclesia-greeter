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
    subtest 'Missing phone number' => sub {
        my $res = $sut->request(GET '/api/member');
        is $res->code, 400, 'Omitting the phone number yields a 400';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'nophone', msg => 'Missing phone number in /api/member', }, '. . . and it returns the right error mesage';
    };

    subtest 'Too-short phone number' => sub {
        my $res = $sut->request(GET '/api/member?phone=555-111-222');
        is $res->code, 400, 'Too-short phone numbers yield 400s';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'badphone', msg => q{The phone number '555111222' is not a 10-digit string}, need => { phone => 'phone-number', }, }, '. . . and it returns the right error mesage';
    };

    subtest 'Too-long phone number' => sub {
        my $res = $sut->request(GET '/api/member?phone=555-111-22222');
        is $res->code, 400, 'Too-long phone numbers yield 400s';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'badphone', msg => q{The phone number '55511122222' is not a 10-digit string}, need => { phone => 'phone-number', }, }, '. . . and it returns the right error mesage';
    };

    subtest 'Non-existent member' => sub {
        my $res = $sut->request(GET '/api/member?phone=555-111-2222');
        is $res->code, 404, 'Finding a non-existent member returns a 404';
    };

    subtest 'Member in the database' => sub {
        my $family = schema->resultset('Family')->create({});
        my $ward = $family->create_related(members => {
            full_name => 'Ward Cleaver',
        });
        my $phone = $ward->create_related(phone => {
            number => '5551112222',
        });
        my $june = $family->create_related(members => {
            full_name => 'June Cleaver',
        });
        my $beaver = $family->create_related(members => {
            full_name => 'Beaver Cleaver',
        });

        my $res = $sut->request(GET '/api/member?phone=555-111-2222');
        is $res->code, 200, 'Finding an existing member returns a 200';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
        my $expected = {
            id => $ward->id,
            full_name => 'Ward Cleaver',
            phone => [ '5551112222', ],
            family => {
                id => $family->id,
                members => [
                    {
                        id => $ward->id,
                        full_name => 'Ward Cleaver',
                        phone => [ '5551112222', ],
                    },
                    {
                        id => $june->id,
                        full_name => 'June Cleaver',
                        phone => [],
                    },
                    {
                        id => $beaver->id,
                        full_name => 'Beaver Cleaver',
                        phone => [],
                    },
                ],
            },
        };
        is_deeply $json, $expected, '. . . and it returns the right results' or diag explain $json;
    };
});

done_testing;
