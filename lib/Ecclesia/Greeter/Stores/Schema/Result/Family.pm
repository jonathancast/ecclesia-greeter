use Moops;

class Ecclesia::Greeter::Stores::Schema::Result::Family extends DBIx::Class::Core {
    use DBIx::Class::Candy -autotable => v1;
    use DBIx::Class::Relationship::Abbreviate qw/ result /;

    primary_column id => { data_type => 'int', is_auto_increment => 1, };

    has_many members => result('Member'), { 'foreign.family_id' => 'self.id', };

    method as_hash {
        return { id => $self->id, members => [ sort { $a->{id} <=> $b->{id} } map { $_->as_hash } $self->members->all() ], };
    }
}

1;
