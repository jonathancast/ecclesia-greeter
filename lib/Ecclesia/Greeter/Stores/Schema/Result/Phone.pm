use Moops;

class Ecclesia::Greeter::Stores::Schema::Result::Phone extends DBIx::Class::Core {
    use DBIx::Class::Candy -autotable => v1;
    use DBIx::Class::Relationship::Abbreviate qw/ result /;

    primary_column id => { data_type => 'int', is_auto_increment => 1, };

    unique_column number => { data_type => 'text', length => 10, };
    column member_id => { data_type => 'int', nullable => 0, };

    belongs_to member => result('Member'), 'member_id';

    method as_hash {
        return { member_id => $self->member_id, number => $self->number };
    }
}

1;
