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
    load test_framework.helper_file
    Spork.exec_each_run
    result = test_framework.run_tests(argv, stderr, stdout)
    Spork.exec_after_each_run
    result
  ensure
    @running = false
  end

  def preload
    test_framework.preload
  end

  def running?
    @running
  end
end
