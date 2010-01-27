require File.dirname(__FILE__) + '/single_process_looping.rb'
class Spork::RunStrategy::SingleProcessExits < Spork::RunStrategy::SingleProcessLooping
  
    def run(argv, stderr, stdout)
      puts "SingleProcessExits running " + argv.inspect
      super(argv, stderr, stdout)
      Thread.main.raise 'exit please' # seems to be the only way to exit easily...
    end
end
