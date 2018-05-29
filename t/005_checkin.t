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
    subtest 'No members' => sub {
        my $res = $sut->request(POST '/api/checkin', ContentType => 'application/json', Content => encode_json({}));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'noids', msg => 'You must supply an array of member ids', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'No ids' => sub {
        my $res = $sut->request(POST '/api/checkin', ContentType => 'application/json', Content => encode_json({ members => {}, }));
        is $res->code, 400, 'Trying to check in with an object fails';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'bad_request', code => 'noids', msg => 'You must supply an array of member ids', }, '. . . and it returns the right errors' or diag explain $json;
    };

    subtest 'Valid checkin' => sub {
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

        my $res = $sut->request(POST '/api/checkin', ContentType => 'application/json', Content => encode_json({ members => { ids => [ $ward->id, $beaver->id, ], }, }));
        is $res->code, 200, 'Trying to check in with valid parameters succeeds';
        my $json = try { decode_json($res->decoded_content) };
        isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
        is_deeply $json, { status => 'ok', }, '. . . and it returns the correct JSON' or diag explain $json;

        my @checkins = schema->resultset('Checkin')->all();
        my %checked_in = map { $_->member_id => 1, } @checkins;
        is_deeply { %checked_in, }, { $ward->id => 1, $beaver->id => 1, }, '. . . and it creates records for the right members';
    };
});

done_testing();
