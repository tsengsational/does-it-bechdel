$:.unshift '.'
require 'config/environment'


set :static, true
# set :public, 'public'

use Rack::MethodOverride
use InterfaceController
use MovieController
use ActorController
use DirectorController
run ApplicationController
