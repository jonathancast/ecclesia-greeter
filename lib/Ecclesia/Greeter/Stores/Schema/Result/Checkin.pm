use Moops;

class Ecclesia::Greeter::Stores::Schema::Result::Checkin extends DBIx::Class::Core {
    use DBIx::Class::Candy -autotable => v1;
    use DBIx::Class::Relationship::Abbreviate qw/ result /;

    primary_column id => { data_type => 'int', is_auto_increment => 1, };

    column date => { data_type => 'timestamptz',  inflate_datetime => 1, };
    column member_id => { data_type => 'int', null => false, };

    belongs_to member => result('Member'), { 'foreign.id' => 'self.member_id', };
}

1;

