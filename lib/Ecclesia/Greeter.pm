package Ecclesia::Greeter 0.1;

use Dancer2;

use autodie;

set serializer => 'JSON';

get '/' => sub { send_file '/index.html' };

get '/config' => sub {
    return {
        name => config->{name} // 'Ecclesia',
    };
};

get '/ping' => sub {
    if (session 'user') {
        return { status => 'ok', };
    } else {
        status 'forbidden';
        return { code => 'notloggedon', status => 'forbidden', errors => [ 'notloggedon', ], };
    }
};

get '/src.tar.gz' => sub {
    require Ecclesia::Greeter::Stores::Source;

    my $tar_gz = Ecclesia::Greeter::Stores::Source->new(appdir => config->{appdir}, appversion => our $VERSION);
    send_file($tar_gz->tar_gz_fh, content_type => 'application/gzip');
};

true;
