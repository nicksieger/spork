class Spork::RunStrategy::Forking < Spork::RunStrategy
 
  def self.available?
   if ENV['OS'] == 'Windows_NT' || (RUBY_PLATFORM =~ /java/)
     false
   else
     true
   end
  end

  def run(argv, stderr, stdout)
    abort if running?

    @child = ::Spork::Forker.new do
      $stdout, $stderr = stdout, stderr
      load test_framework.helper_file
      Spork.exec_each_run
      result = test_framework.run_tests(argv, stderr, stdout)
      Spork.exec_after_each_run
      result
    end
    @child.result
  end

  def abort
    @child && @child.abort
  end

  def preload
    test_framework.preload
  end

  def running?
    @child && @child.running?
  end

end
