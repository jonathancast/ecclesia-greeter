use Moops;

class Ecclesia::Greeter::Stores::Schema::Result::Member extends DBIx::Class::Core {
    use DBIx::Class::Candy -autotable => v1;

    primary_column id => { data_type => 'int', is_auto_increment => 1, };

    unique_column phone => { data_type => 'text', length => 10, };

    method as_hash {
        return { id => $self->id, phone => [ $self->phone, ], };
    }
}

1;
