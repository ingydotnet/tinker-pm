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

sub handle_post {
    my ($self, $env) = @_;
    $self->env($env);
    $self->read_json;
    my $yaml = $env->{post_data}{input};
    my $result = {
        pm => $self->yaml_pm($yaml),
        tiny => $self->yaml_tiny($yaml),
    };
    return [
        200,
        [ 'Content-Type' => 'application/json' ],
        [ $self->json->encode($result) ]
    ];
}

use YAML();
use YAML::Tiny();
use Data::Dumper();
$Data::Dumper::Indent = 1;
$Data::Dumper::Terse = 0;
$Data::Dumper::Sortkeys = 1;

sub yaml_pm {
    my ($self, $yaml) = @_;
    return eval {
        Data::Dumper::Dumper(YAML::Load($yaml));
    } || "$@";
}

sub yaml_tiny {
    my ($self, $yaml) = @_;
    return eval {
        Data::Dumper::Dumper(YAML::Tiny::Load($yaml));
    } || "$@";
}

1;
