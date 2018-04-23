#! /usr/bin/perl

my ($ip) = @ARGV;

system qw/ apt-get install -y postgresql / and die "Can't install postgres";

my @ls = do { open my $fh, '<', q{/etc/postgresql/9.4/main/postgresql.conf}; <$fh> };
@ls = map {
        m/listen_addresses/
            ? qq{listen_addresses = 'localhost,${ip}'         # what IP address(es) to listen on;\n}
            : $_
    } @ls
;
{
    open my $fh, '>', q{/etc/postgresql/9.4/main/postgresql.conf};
    print $fh @ls;
}

{
    open my $fh, '>>', q{/etc/postgresql/9.4/main/pg_hba.conf};
    print $fh qq{host    all             all             ${ip}/24            md5\n};
}

system qw/ service postgresql restart / and die "Can't restart postgres";

system qw/ su postgres -c /, q{createuser vagrant} and die "Can't add vagrant user to postgres";

{
    open my $fh, '|-', qw/ su postgres -c psql /;
    print $fh qq{ALTER USER vagrant WITH PASSWORD 'vagrdbpass';};
    close $fh or die "Can't reset password on user vagrant";
}
