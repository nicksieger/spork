class Spork::RunStrategy::Forking < Spork::RunStrategy
  def self.available?
    begin
      Process.wait(fork {})
      true
    rescue NotImplementedError
      false
    end
  end

  def run(argv, stderr, stdout)
    abort if running?

    @child = ::Spork::Forker.new do
      Spork.instance_exec { @drb_service.stop_service } # stop listening locally
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