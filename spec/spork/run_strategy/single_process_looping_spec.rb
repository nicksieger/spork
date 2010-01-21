require 'spec/autorun'
require File.dirname(__FILE__) + '/../../spec_helper'

describe Spork::RunStrategy::SingleProcessLooping do
  
  before(:each) do
    @fake_framework = FakeFramework.new
    @run_strategy = Spork::RunStrategy::SingleProcessLooping.new(@fake_framework)
  end

  it "returns the result of the run_tests method from the forked child" do
    create_helper_file
    @fake_framework.stub!(:run_tests).and_return("tests were ran")
    @run_strategy.run("test", STDOUT, STDIN).should == "tests were ran"
  end

end
