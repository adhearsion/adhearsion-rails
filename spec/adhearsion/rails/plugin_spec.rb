require 'spec_helper'

describe Adhearsion::Rails::Plugin do

  describe "while accessing the plugin configuration" do

    it "should retrieve a valid configuration instance" do
      Adhearsion.config.adhearsion_rails.should be_instance_of Loquacious::Configuration
    end

    it "should configure properly the path" do
      Adhearsion.config.adhearsion_rails.path.should == ""
    end

    it "should configure properly the environment" do
      Adhearsion.config.adhearsion_rails.environment.should == :development
    end
  end

  describe "while configuring a specific config value" do
    before do
      @path        = Adhearsion.config[:adhearsion_rails].path
      @environment = Adhearsion.config[:adhearsion_rails].environment
    end

    after do
      Adhearsion.config[:adhearsion_rails].path        = @path
      Adhearsion.config[:adhearsion_rails].environment = @environment
    end

    it "ovewrites properly the path value" do
      Adhearsion.config[:adhearsion_rails].path = "/foo/bar"
      Adhearsion.config[:adhearsion_rails].path.should == "/foo/bar"
    end

    it "ovewrites properly the environment value" do
      Adhearsion.config[:adhearsion_rails].environment = :production
      Adhearsion.config[:adhearsion_rails].environment.should == :production
    end
  end
end
