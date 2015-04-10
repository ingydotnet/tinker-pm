package Tinker::App;
use Mo;
extends 'Cog::App';

use constant Name => 'Tinker';
use constant command_script => 'tinker';
use constant webapp_class => 'Tinker::WebApp';
use constant config_file => 'tinker.yaml';

package Tinker::WebApp;
use Mo;
extends 'Cog::WebApp';

1;
