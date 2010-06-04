class Spork::TestFramework::RSpec < Spork::TestFramework
  DEFAULT_PORT = 8989
  HELPER_FILE = File.join(Dir.pwd, "spec/spec_helper.rb")

  def run_tests(argv, stderr, stdout)
    if defined?(::RSpec)    # RSpec 2
      begin
        prevout, preverr, $stdout, $stderr = $stdout, $stderr, stdout, stderr
        runner = ::RSpec::Core::Runner
        def runner.installed_at_exit?; true; end # no autorun
        ::RSpec::Core::Runner.new.run(argv)
      ensure
        ::RSpec.world.example_groups.clear
        ::RSpec.world.filtered_examples.clear
        ::RSpec.world.shared_example_groups.clear
        $stdout, $stderr = prevout, preverr
      end
    else
      ::Spec::Runner::CommandLine.run(
        ::Spec::Runner::OptionParser.parse(
          argv,
          stderr,
          stdout
        )
      )
    end
  end
end
