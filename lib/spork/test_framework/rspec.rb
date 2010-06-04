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
        reset_rspec2_state
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

  def reset_rspec2_state
    ::RSpec.world.example_groups.clear
    ::RSpec.world.filtered_examples.clear
    ::RSpec.world.shared_example_groups.clear
    config = ::RSpec.configuration
    def config.reset_state
      @formatter = nil
    end
    config.reset_state
    example_group = ::RSpec::Core::ExampleGroup
    def example_group.reset_state
      examples.clear
      children.clear
      constants.each do |c|
        if c =~ /^Nested_/
          puts "#{self}: removing #{c}"
          remove_const(c)
        end
      end
    end
    example_group.reset_state
  end
end
