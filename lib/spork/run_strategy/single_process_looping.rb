# this class' goal:
# to boldly just run test after test
# as they come in
class Spork::RunStrategy::SingleProcessLooping < Spork::RunStrategy
  def self.available?
    true
  end

  def run(argv, stderr, stdout)
    return if @running # ignore later tests
    @running = true
    $stdout, $stderr = stdout, stderr
    Spork.exec_each_run # TODO preload this [?]
    load test_framework.helper_file
    @running = false
    return test_framework.run_tests(argv, stderr, stdout)
  end

  def abort
    raise 'not supported yet'
  end

  def preload
    test_framework.preload    
  end

  def running?
    @running
  end

end