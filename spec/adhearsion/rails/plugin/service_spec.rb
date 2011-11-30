require 'spec_helper'

describe Adhearsion::Rails::Plugin::Service do

  describe "while initializing" do
    before do
      Adhearsion.config.adhearsion_rails.path = "/path/to/rails/app"
      stub_file_checking_methods!
    end

    after do
      defined?(Activerecord) and Object.send(:remove_const, :"ActiveRecord")
      Adhearsion.config.adhearsion_rails.path = ""
      Adhearsion.config.adhearsion_rails.environment = :development
    end

    let :environment_rb do
      "#{Adhearsion.config.adhearsion_rails.path}/config/environment.rb"
    end

    it "should load the config/environment.rb file within the rails_root path" do
      Adhearsion::Rails::Plugin::Service.should_receive(:load_env_file).once.with(environment_rb).and_return true
      Adhearsion::Plugin.load
    end

    it "should set the RAILS_ENV to be the argument passed in" do
      Adhearsion::Rails::Plugin::Service.should_receive(:load_env_file).once.with(environment_rb).and_return true
      Adhearsion::Plugin.load
      ENV['RAILS_ENV'].should == "development"
    end

    it "should create a BeforeCall hook (presumably to verify the active connections) when ActiveRecord is loaded" do
      ActiveRecord = Class.new
      Adhearsion::Rails::Plugin::Service.should_receive(:load_env_file).once.with(environment_rb).and_return true
      Adhearsion::Events.should_receive(:register_callback).once.with(:before_call)
      Adhearsion::Plugin.load
    end

    it "should raise an exception if environment is nil" do
      Adhearsion.config.adhearsion_rails.environment = nil
      lambda { Adhearsion::Plugin.load }.should raise_error "Unable to load Rails. Unexpected nil environment."
    end
  end

  describe "while initializing with invalid rails path" do
    after do
      Adhearsion.config.adhearsion_rails.path = ""
    end

    it "should raise an exception" do
      Adhearsion.config.adhearsion_rails.path = "/path/to/rails/app"
      lambda { Adhearsion::Plugin.load }.should raise_error "Unable to load Rails. Invalid rails root path: #{Adhearsion.config.adhearsion_rails.path.inspect}."
    end
  end

end
