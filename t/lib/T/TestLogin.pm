use Moops;

namespace T::TestLogin {
    no indirect;

    use autodie;

    use Carp qw/ croak /;

    use Plack::Test;

    use HTTP::Cookies;
    use HTTP::Request::Common;

    use JSON::MaybeXS qw/ encode_json /;

    use Exporter qw/ import /;

    push our @EXPORT, qw/ with_login /;

    use T::TestDB;

    use Ecclesia::Greeter;

    my $host = 'greeter.localdomain';

    my $dev_login = {
        login_id => 'dev',
        password => 'devdev',
    };

    schema->resultset('User')->create($dev_login);

    fun with_login($k) {
        my $sut = Plack::Test->create(Ecclesia::Greeter->to_app);

        my $jar = HTTP::Cookies->new();

        my $res = $sut->request(POST "https://$host/login", ContentType => 'application/json', Content => encode_json($dev_login));
        croak "Couldn't log in with ".Dumper($dev_login).'  ' unless $res->code == 200;
        $jar->extract_cookies($res);

        $k->(T::TestLogin::WrappedSUT->new({ host => $host, sut => $sut, jar => $jar, }));
    }
}

class T::TestLogin::WrappedSUT {
    has sut => is => 'ro', required => 1;
    has host => is => 'ro', required => 1;
    has jar => is => 'ro', required => 1;

    method request($req) {
        $req->uri->scheme('https');
        $req->uri->host($self->host);
        $self->jar->add_cookie_header($req);
        return $self->sut->request($req);
    }
}

1;
