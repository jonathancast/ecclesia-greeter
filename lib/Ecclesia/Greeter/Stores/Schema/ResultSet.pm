use Moops;

class Ecclesia::Greeter::Stores::Schema::ResultSet extends DBIx::Class::ResultSet {
    method BUILDARGS { $_[1] }

    __PACKAGE__->load_components(qw/
        Helper::ResultSet::CorrelateRelationship
        Helper::ResultSet::Shortcut
    /);

    method related_results_exist($rel, $k) {
        $self->search({
            -exists => $self->correlate($rel)->$k->search(undef, { select => [ \1, ], })->as_query,
        })
    }

    method not_related_results_exist($rel, $k) {
        $self->search({
            -not_exists => $self->correlate($rel)->$k->search(undef, { select => [ \1, ], })->as_query,
        })
    }
}

1;
