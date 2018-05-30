use Moops;

class Ecclesia::Greeter::Stores::Schema::Result::Visitor extends DBIx::Class::Core, DBIx::Class::InflateColumn::DateTime {
    use DBIx::Class::Candy -autotable => v1;

    primary_column id => { data_type => 'int', is_auto_increment => 1, };

    column date => { data_type => 'timestamptz',  inflate_datetime => 1, is_nullable => false, };
    column name => { data_type => 'text', length => '1024', is_nullable => false, };
    column phone => { data_type => 'text', length => '1024', is_nullable => true, };
    column email => { data_type => 'text', length => '1024', is_nullable => true, };
    column address => { data_type => 'text', length => '1024', is_nullable => true, };
    column address2 => { data_type => 'text', length => '1024', is_nullable => true, };
    column city => { data_type => 'text', length => '1024', is_nullable => true, };
    column state => { data_type => 'text', length => '1024', is_nullable => true, };
    column number => { data_type => 'int', is_nullable => false, };
    column num_children => { data_type => 'int', is_nullable => false, };
}

1;
