use Moops;

class Ecclesia::Greeter::Stores::Schema 5 extends DBIx::Class::Schema {
    __PACKAGE__->load_namespaces(
        default_resultset_class => 'ResultSet',
    );
}

1;
