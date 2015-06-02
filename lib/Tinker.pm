package Tinker;
our $VERSION = '0.0.1';

#------------------------------------------------------------------------------
# Alias packages:
#------------------------------------------------------------------------------
package Test::Tinker;
package Tinker::Test;

#------------------------------------------------------------------------------
# App subclass:
#------------------------------------------------------------------------------
package Tinker::App;
use Mo;
extends 'Cog::App';

use constant Name => 'Tinker';
use constant command_script => 'tinker';
use constant webapp_class => 'Tinker::WebApp';
use constant config_file => 'tinker.yaml';

#------------------------------------------------------------------------------
# WebApp subclass:
#------------------------------------------------------------------------------
package Tinker::WebApp;
use Mo;
extends 'Cog::WebApp';

use IO::All;
use YAML();
use YAML::Tiny();
use YAML::XS();
use YAML::Syck();
use Data::Dumper();
$Data::Dumper::Indent = 1;
$Data::Dumper::Terse = 0;
$Data::Dumper::Sortkeys = 1;

use constant css_files => [qw<
    ()
    reset.css
    layout-table.css
    tinker.css
>];

use constant js_files => [qw(
    colResizable.js
)];
#     tinker-resize.js

use constant coffee_files => [qw(
    tinker.coffee
)];

use constant url_map => [
    ['/' => 'tinker'],
];
use constant post_map => [
    ['/test/' => 'handle_test'],
    ['/save/' => 'handle_save'],
];

sub handle_post {
    my ($self, $env) = @_;
    $self->env($env);
    my $path = $env->{PATH_INFO};
    return
        ($path eq '/test/') ? $self->handle_test :
        ($path eq '/save/') ? $self->handle_save :
        ();
}

sub handle_test {
    my ($self) = @_;
    $self->read_json;
    my $yaml = $self->{env}{post_data}{yaml};
    my ($sec,$min,$hour,$mday,$mon,$year) = gmtime(time);
    my $result = {
        pm => $self->yaml_pm($yaml),
        tiny => $self->yaml_tiny($yaml),
        xs => $self->yaml_xs($yaml),
        syck => $self->yaml_syck($yaml),
        stamp => sprintf(
            "%4d-%02d-%02d-%02d:%02d:%02d",
            $year+1900, $mon+1, $mday, $hour, $min, $sec,
        ),
    };
    $self->response_json($result);
}

sub handle_save {
    my ($self) = @_;
    $self->read_json;
    my $yaml = $self->{env}{post_data}{yaml};
    my $stamp = $self->{env}{post_data}{stamp};
    io->file("data/$stamp.yaml")->assert->print($yaml);
    $self->response_json({stamp => $stamp});
}

sub yaml_pm {
    my ($self, $yaml) = @_;
    return eval {
        Data::Dumper::Dumper(YAML::Load($yaml));
        # YAML::Dump($self->{env});
    } || "$@";
}

sub yaml_tiny {
    my ($self, $yaml) = @_;
    return eval {
        Data::Dumper::Dumper(YAML::Tiny::Load($yaml));
    } || "$@";
}

sub yaml_xs {
    my ($self, $yaml) = @_;
    return eval {
        Data::Dumper::Dumper(YAML::XS::Load($yaml));
    } || "$@";
}

sub yaml_syck {
    my ($self, $yaml) = @_;
    return eval {
        Data::Dumper::Dumper(YAML::Syck::Load($yaml));
    } || "$@";
}

1;
