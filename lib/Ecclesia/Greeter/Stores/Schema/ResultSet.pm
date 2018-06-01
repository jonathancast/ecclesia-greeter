use Moops;

class Ecclesia::Greeter::Stores::Schema::ResultSet extends DBIx::Class::ResultSet {
    method BUILDARGS { $_[1] }

    __PACKAGE__->load_components(qw/ Helper::ResultSet::Shortcut /);
}

1;
