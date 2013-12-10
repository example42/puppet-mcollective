module MCollective
  class Application::Shellcmd < Application
    description "Run shell commands"

    usage <<-END_OF_USAGE
mco shellcmd [OPTIONS] [FILTERS] 'command'

Remember to put the command in single quotes, also be very, VERY careful
using this agent.
END_OF_USAGE

    def post_option_parser(configuration)
      if ARGV.size == 0
         raise "You must pass a command!"
      end

      if ARGV.size > 1
        raise "Please specify the command as one argument in single quotes."
      else
        command = ARGV.shift

        configuration[:command] = command
      end
    end

    def validate_configuration(configuration)
      if MCollective::Util.empty_filter?(options[:filter])
        print "Do you really want to run the command #{configuration[:command]} unfiltered? (y/n): "

        STDOUT.flush

        # Only match letter "y" or complete word "yes" ...
        exit! unless STDIN.gets.strip.match(/^(?:y|yes)$/i)
        puts "\n"
      end
    end

    def main
      $0 = "mco"

      command = configuration[:command]

      mc = rpcclient("shellcmd", :options => options)

      mc.runcmd(:cmd => command) do |resp|
        if (resp[:body][:data][:stdout].empty? and resp[:body][:data][:stderr].empty?)
          puts "HOST:#{resp[:senderid]} EXITCODE:#{resp[:body][:data][:exitcode]}"
        end

        if !(resp[:body][:data][:stdout].empty?)
          puts "==============================================================="
          puts "HOST:#{resp[:senderid]} EXITCODE:#{resp[:body][:data][:exitcode]} STDOUT:"
          puts "==============================================================="
          puts resp[:body][:data][:stdout]
          puts "==============================================================="
        end

        if !(resp[:body][:data][:stderr].empty?)
          puts "==============================================================="
          puts "HOST:#{resp[:senderid]} EXITCODE:#{resp[:body][:data][:exitcode]} STDERR:"
          puts "==============================================================="
          puts resp[:body][:data][:stderr]
          puts "==============================================================="
        end
      end

      printrpcstats
    end
  end
end

