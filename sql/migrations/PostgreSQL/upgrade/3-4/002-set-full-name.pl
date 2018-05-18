use strict;
use warnings;

use autodie;

use DBIx::Class::Migration::RunScript;

migrate {
    open my $fh, '+<', '/dev/tty';
    $fh->autoflush(1);

    my @members = shift->schema
        ->resultset('Member')
        ->search_rs({ full_name => undef, })
        ->all()
    ;

    for my $member (@members) {
        if (my $number = $member->phones->get_column('number')->first()) {
            print $fh qq{Full name of member with phone #$number? };
        } else {
            my $id = $member->id;
            print $fh qq{Full name of member #$id? };
        }
        chomp(my $name = <$fh>);
        $member->update({ full_name => $name, });
    }
};
