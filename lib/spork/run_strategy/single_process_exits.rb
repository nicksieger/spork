require File.dirname(__FILE__) + '/single_process_looping.rb'
class Spork::RunStrategy::SingleProcessExits < Spork::RunStrategy::SingleProcessLooping
  
    def run(argv, stderr, stdout)
      puts "SingleProcessExits running " + argv.inspect if $VERBOSE
      super(argv, stderr, stdout)
    end
end
