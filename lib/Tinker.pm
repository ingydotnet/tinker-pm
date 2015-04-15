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

1;
