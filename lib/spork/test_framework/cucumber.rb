class Spork::TestFramework::Cucumber < Spork::TestFramework
  DEFAULT_PORT = 8990
  HELPER_FILE = File.join(Dir.pwd, "features/support/env.rb")

  def preload
    require 'cucumber'
    step_mother
    super
  end

  def step_mother
    @step_mother ||= ::Cucumber::StepMother.new.tap {|sm| sm.load_programming_language('rb')}
  end

  def run_tests(argv, stderr, stdout)
    ::Cucumber::Cli::Main.new(argv, stdout, stderr).execute!(step_mother)
  end
end
