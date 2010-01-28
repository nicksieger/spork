require File.dirname(__FILE__) + '/single_process_looping_spec'

describe Spork::RunStrategy::SingleProcessExits do
  
  before(:each) do
    @fake_framework = FakeFramework.new
    @run_strategy = Spork::RunStrategy::SingleProcessExits.new(@fake_framework)
  end
  
  it_should_behave_like "Spork::RunStrategy::NonForking"
  
end