package Tinker;
our $VERSION = '0.0.2';

#------------------------------------------------------------------------------
# App subclass:
#------------------------------------------------------------------------------
package Tinker::App;
use Mo;
extends 'Cog::App';

use constant webapp_class => 'Tinker::WebApp';

#------------------------------------------------------------------------------
# WebApp subclass:
#------------------------------------------------------------------------------
package Tinker::WebApp;
use Mo;
extends 'Cog::WebApp';

use IO::All;

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

use constant url_map => [
    ['/' => 'tinker'],
];

1;
