use strict;
use warnings;

no indirect;

use autodie;

use v5.26;
use feature 'signatures';
no warnings 'experimental::signatures';

use FindBin;
use lib $FindBin::RealBin.'/lib';

use Test::More;
use Plack::Test;

use HTTP::Request::Common;

use JSON::MaybeXS qw/ decode_json encode_json /;

use T::TestDB;
use T::TestLogin;

with_login(sub($sut) {
    subtest 'Non-existent member' => sub {
        my $res = $sut->request(GET '/api/member', { phone => '555-111-2222', });
        is $res->code, 404, 'Finding a non-existent member returns a 404';
    };
});

done_testing;
