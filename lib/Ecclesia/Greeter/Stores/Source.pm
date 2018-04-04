use Moops;

use File::Temp;

class Ecclesia::Greeter::Stores::Source {
    use File::Basename qw/ dirname /;
    use File::pushd qw/ tempd /;

    has appdir => is => 'ro', required => 1;
    has appversion => is => 'ro', required => 1;

    has tar_gz_fh => is => 'lazy', builder => method {
        my $appdir = $self->appdir;
        my $dir = tempd();
        my $versioned_dir = 'ecclesia-greeter-'.$self->appversion;
        for my $file (qx{find $appdir}) {
            chomp($file);
            if (-f $file && !$self->_hidden_file($file)) {
                my $dest = $file =~ s{^\Q$appdir\E}{$versioned_dir/}r;
                system 'mkdir', '-p', dirname($dest);
                system 'cp', $file, $dest and die "Couldn't copy $file to temp directory $dest";
            }
        }
        my $fh = File::Temp->new();
        system 'tar', 'czf', $fh->filename, $versioned_dir and die "Couldn't create source tarball";
        return $fh;
    };

    method _hidden_file($file) {
        $file =~ m{\Q/node_modules/}
        || $file =~ m{\Q/.git/}
        || $file =~ m{\Q/.vagrant/}
        || $file =~ m{\Q/public/}
    }
}

true;
