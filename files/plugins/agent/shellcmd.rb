# GPLv2 license
# https://github.com/thesilentpenguin/shellcmd-agent/blob/master/COPYING
module MCollective
 module Agent
  class Shellcmd<RPC::Agent

    metadata :name => "Run shell commands, get output",
                :description => "Run arbitrary shell commands and get their output.",
                :author => "Joe Miller, updates by Joe McDonagh",
                :license => "GPLv2",
                :version => "1.1",
                :url => "http://github.com/joemiller/shellcmd-agent",
                :timeout => 300

    action "runcmd" do
      validate :cmd, String
      require 'open4'

      # Set empty strings for stdout and stderr reply so << will dtrt
      reply[:stdout] = ""
      reply[:stderr] = ""

      exitcode = Open4.popen4("#{request[:cmd]}") do |pid, stdin, stdout, stderr|
         # Just in case we execute a program that waits for stdin by accident
         stdin.reopen(File::open('/dev/null', 'r'))

         reply[:stdout] << stdout.gets until stdout.eof?
         reply[:stderr] << stderr.gets until stderr.eof?
      end

      reply[:exitcode] = exitcode
    end
  end
 end
end

