module MCollective
 module Agent
  class Shellcmd<RPC::Agent

    action "runcmd" do
      validate :cmd, String
      require 'open4'

      # Set empty strings for stdout and stderr reply so << will dtrt
      reply[:stdout] = ""
      reply[:stderr] = ""

      begin
         exitcode = Open4.popen4("#{request[:cmd]}") do |pid, stdin, stdout, stderr|
            # Just in case we execute a program that waits for stdin by accident
            stdin.reopen(File::open('/dev/null', 'r'))
   
            reply[:stdout] << stdout.gets until stdout.eof?
            reply[:stderr] << stderr.gets until stderr.eof?
         end
      rescue Exception => e
         reply[:stderr] << e.to_s
         exitcode = 1
      end
      reply[:exitcode] = exitcode
    end
  end
 end
end

