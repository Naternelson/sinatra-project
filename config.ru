require './config/environment'

use Rack::MethodOverride
use UsersController
use ProductsController
use OrdersController
use ItemsController
run ApplicationController