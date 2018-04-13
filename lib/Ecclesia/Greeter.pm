package Ecclesia::Greeter 0.1;

use Dancer2;

use autodie;

get '/' => sub { send_file '/index.html' };

get '/config' => sub {
    content_type 'application/json';
    return encode_json({
        name => config->{name} // 'Ecclesia',
    });
};

get '/ping' => sub {
    if (session 'user') {
        content_type 'application/json';
        return encode_json({ status => 'ok', });
    } else {
        status 'forbidden';
        content_type 'application/json';
        return encode_json({ status => 'forbidden', errors => [ 'notloggedon', ], });
    }
};

get '/src.tar.gz' => sub {
    require Ecclesia::Greeter::Stores::Source;

    my $tar_gz = Ecclesia::Greeter::Stores::Source->new(appdir => config->{appdir}, appversion => our $VERSION);
    send_file($tar_gz->tar_gz_fh, content_type => 'application/gzip');
};

true;
