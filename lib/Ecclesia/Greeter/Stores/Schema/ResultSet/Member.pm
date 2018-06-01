use Moops;

class Ecclesia::Greeter::Stores::Schema::ResultSet::Member extends Ecclesia::Greeter::Stores::Schema::ResultSet {
    method present_on($date) {
        $self->related_results_exist(checkins => method { $self->search({ date => $date, }) })
    }

    method absent_on($date) {
        $self->not_related_results_exist(checkins => method { $self->search({ date => $date, }) })
    }
}

1;
