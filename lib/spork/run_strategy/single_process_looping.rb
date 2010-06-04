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
    saved_features = $LOADED_FEATURES.dup
    Spork.exec_each_run
    result = test_framework.run_tests(argv, stderr, stdout)
    Spork.exec_after_each_run
    result
  ensure
    # Remove project paths from $LOADED_FEATURES that were loaded during the run
    ($LOADED_FEATURES - saved_features).each do |f|
      $LOADED_FEATURES.delete(f) if File.exist?(File.expand_path(f))
    end
    Spork.already_ran.clear
    @running = false
  end

  def abort
    # Don't need to do anything
  end

  def preload
    test_framework.preload
  end

  def running?
    @running
  end
end
