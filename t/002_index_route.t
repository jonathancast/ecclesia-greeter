use strict;
use warnings;

use Test::More;

use Ecclesia::Greeter;

use Plack::Test;
use HTTP::Request::Common;

use Ref::Util qw/ is_coderef /;

my $app = Ecclesia::Greeter->to_app;
ok( is_coderef($app), 'Got app' );

done_testing;
