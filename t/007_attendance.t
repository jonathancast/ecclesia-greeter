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

use DateTime;

use JSON::MaybeXS qw/ decode_json encode_json /;

use T::TestDB;
use T::TestLogin;

with_login(sub($sut) {
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

    $ward->create_related(checkins => { date => DateTime->new(year => 2018, month => 1, day => 6), });
    $ward->create_related(checkins => { date => DateTime->new(year => 2018, month => 1, day => 13), });
    $beaver->create_related(checkins => { date => DateTime->new(year => 2018, month => 1, day => 13), });
    $ward->create_related(checkins => { date => DateTime->new(year => 2018, month => 1, day => 20), });
    $beaver->create_related(checkins => { date => DateTime->new(year => 2018, month => 1, day => 27), });

    my $res = $sut->request(GET '/api/attendance/dates');
    is $res->code, 200, 'You can get the attendance dates';
    my $json = try { decode_json($res->decoded_content) };
    isnt $json, undef, '. . . and it returns valid JSON' or diag $res->decoded_content;
    is_deeply $json, [ '2018-01-27', '2018-01-20', '2018-01-13', '2018-01-06', ], '. . . and it returns the right results' or diag explain $json;
});

done_testing();
