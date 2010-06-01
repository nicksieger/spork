class Spork::TestFramework::Cucumber < Spork::TestFramework
  DEFAULT_PORT = 8990
  HELPER_FILE = File.join(Dir.pwd, "features/support/env.rb")

  def preload
    require 'cucumber'
    step_mother
    super
  end

  def step_mother
    @step_mother ||= ::Cucumber::StepMother.new.tap do |sm|
      def sm.reset_steps_and_scenarios
        @steps = []
        @scenarios = []
      end
      sm.load_programming_language('rb')
    end
    @step_mother.reset_steps_and_scenarios
    @step_mother
  end

  def run_tests(argv, stderr, stdout)
    ::Cucumber::Cli::Main.new(argv, stdout, stderr).execute!(step_mother)
  end
end
