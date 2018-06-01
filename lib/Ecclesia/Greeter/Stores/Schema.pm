use Moops;

class Ecclesia::Greeter::Stores::Schema 8 extends DBIx::Class::Schema {
    __PACKAGE__->load_namespaces(
        default_resultset_class => 'ResultSet',
    );
}

1;
