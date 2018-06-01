use Moops;

class Ecclesia::Greeter::Stores::Schema::Result::Member extends DBIx::Class::Core {
    use DBIx::Class::Candy -autotable => v1;
    use DBIx::Class::Relationship::Abbreviate qw/ result /;

    __PACKAGE__->load_components(qw/ Helper::Row::SelfResultSet /);

    primary_column id => { data_type => 'int', is_auto_increment => 1, };

    column full_name => { data_type => 'text', length => '1024', null => false, };
    column family_id => { data_type => 'int', null => false, };

    belongs_to family => result('Family'), { 'foreign.id' => 'self.family_id', };
    has_many phone => result('Phone'), { 'foreign.member_id' => 'self.id', };

    has_many checkins => result('Checkin'), { 'foreign.member_id' => 'self.id', };

    method as_hash {
        return { id => $self->id, full_name => $self->full_name, phone => [ map { $_->number } $self->phone->all(), ], };
    }
}

1;
