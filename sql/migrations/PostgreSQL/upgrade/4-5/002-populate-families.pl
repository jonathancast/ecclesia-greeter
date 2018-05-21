use strict;
use warnings;

use autodie;

use DBIx::Class::Migration::RunScript;

migrate {
    my $schema = shift->schema;
    my @members = $schema
        ->resultset('Member')
        ->search_rs({ family_id => undef, })
        ->all()
    ;

    for my $member (@members) {
        my $family = $schema->resultset('Family')->create({});
        $member->update({ family_id => $family->id, });
    }
};
