require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

end

Spork.each_run do
  # This code will be run each time you run your specs.

end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "app/models")
SUPPORT = File.join(File.dirname(__FILE__), "support")
$LOAD_PATH.unshift(MODELS)
$LOAD_PATH.unshift(SUPPORT)

require 'postler'
require 'mongoid'
require 'rspec'
require 'database_cleaner'

LOGGER = Logger.new($stdout)
DATABASE_ID = Process.pid

DatabaseCleaner.strategy = :truncation

Mongoid.configure do |config|
  database = Mongo::Connection.new.db("postler_test")
  database.add_user("postler", "test")
  config.master = database
  config.logger = nil
end

Dir[ File.join(MODELS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end

Dir[ File.join(SUPPORT, "*.rb") ].each do |file|
  require File.basename(file)
end

RSpec.configure do |config|
  config.include RSpec::Matchers
  config.include Mongoid::Matchers
  config.mock_with :rspec

  config.before(:each) do
    DatabaseCleaner.start
    Mongoid::IdentityMap.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after :suite do
    Mongoid.master.connection.drop_database("postler_test")
  end

end
