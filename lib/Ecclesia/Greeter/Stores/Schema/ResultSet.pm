use Moops;

class Ecclesia::Greeter::Stores::Schema::ResultSet extends DBIx::Class::ResultSet, DBIx::Class::Helper::ResultSet::Shortcut {
    method BUILDARGS { $_[1] }
}

1;
