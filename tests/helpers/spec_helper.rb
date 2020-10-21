require 'json_expressions/rspec'
require 'json'
require 'rest-client'
require 'faker'
require 'require_all'
require_rel './objects/*.rb'

BASE_URL = 'http://localhost:3001/' 
auth_confif = YAML::load_file(File.join(File.dirname(__FILE__),  "/../config/user_authentication.yml"))
AUTH_TOKEN = auth_confif['token']