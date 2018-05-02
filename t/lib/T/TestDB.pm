package T::TestDB;

use strict;
use warnings;

no indirect;

use autodie;

use Import::Into;

use DBICx::Sugar ();
use Ecclesia::Greeter::Stores::Schema;

sub import {
    my ($class) = @_;

    $ENV{DANCER_ENVIRONMENT} = 'test';

    system qw/ dropdb --if-exists unittest /;
    system qw/ createdb unittest /;

    my $dsn = 'dbi:Pg:dbname=unittest';
    Ecclesia::Greeter::Stores::Schema->connect($dsn)->deploy();
    DBICx::Sugar::config({ default => { dsn => $dsn, schema_class => 'Ecclesia::Greeter::Stores::Schema', } });

    DBICx::Sugar->import::into(scalar caller, qw/ schema /);
}

1;
