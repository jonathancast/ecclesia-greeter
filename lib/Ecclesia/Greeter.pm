package Ecclesia::Greeter 0.1;

use Dancer2;

use autodie;

use File::Temp;

use File::pushd qw/ tempd /;

get '/src.tar.gz' => sub {
    my $dir = tempd();
    our $VERSION;
    my $versioned_dir = "ecclesia-greeter-$VERSION";
    system 'cp', '-R', config->{appdir}, $versioned_dir and die "Couldn't copy files to temp directory";
    system 'rm', '-rf', "$versioned_dir/.git", "$versioned_dir/.vagrant";
    my $fh = File::Temp->new();
    system 'tar', 'czf', $fh->filename, $versioned_dir and die "Couldn't create source tarball";
    send_file($fh, content_type => 'application/gzip');
};

true;
