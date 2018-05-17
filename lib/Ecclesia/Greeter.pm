package Ecclesia::Greeter 0.1;

use Dancer2;
use Dancer2::Plugin::DBIC;

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
        return { code => 'notloggedon', status => 'unauthorized', };
    }
};

post '/login' => sub {
    my $login_id = body_parameters->get('login_id') or return missing_param('login_id');

    my $password = body_parameters->get('password') or return missing_param('password');

    my $user = schema->resultset('User')->find({ login_id => $login_id, });

    unless ($user && $user->check_password($password)) {
        status 'forbidden';
        return { code => 'invalid_login', status => 'forbidden', msg => 'The username or password you supplied is incorrect', };
    }

    session user => { id => $user->id, };

    return $user->as_hash;
};

prefix '/api' => sub {
    any '/**' => sub {
        if (session 'user') {
            pass();
        }

        status 'forbidden';
        return { code => 'notloggedon', status => 'unauthorized', };
    };

    get '/member' => sub {
        my $phone = query_parameters->get('phone');

        unless ($phone) {
            status 'bad_request';
            return { status => 'bad_request', code => 'nophone', msg => 'Missing phone number in /api/member', };
        }

        # Phone numbers are stored internally as 10-digit strings
        $phone =~ s/\D//g;

        unless (length $phone == 10) {
            status 'bad_request';
            return { status => 'bad_request', code => 'badphone', msg => qq{The phone number '$phone' is not a 10-digit string}, need => { phone => 'phone-number', }, };
        }

        my $member = schema->resultset('Member')->find({ phone => $phone, });
        if ($member) {
            return $member->as_hash;
        } else {
            status 'not_found';
            return { status => 'not_found', code => 'notfound', msg => qq{No member found with phone number $phone}, };
        }
    };
};

sub missing_param {
    my ($param) = @_;

    status 'Bad Request';
    return { code => 'badparams', missing => [$param], msg => qq{You must supply a $param}, };
};

get '/src.tar.gz' => sub {
    require Ecclesia::Greeter::Stores::Source;

    my $tar_gz = Ecclesia::Greeter::Stores::Source->new(appdir => config->{appdir}, appversion => our $VERSION);
    send_file($tar_gz->tar_gz_fh, content_type => 'application/gzip');
};

true;
