metadata :name        => "shellcmd",
         :description => "Run arbitrary shell commands and get their output.",
         :author      => "Joe Miller, updates by Joe McGonagh and slivarez",
         :license     => "GPLv2",
         :version     => "1.2",
         :url         => "https://github.com/slivarez/mcollective-shellcmd-agent/",
         :timeout     => 300

action 'runcmd', :description => "Execute a shell command" do
  input :cmd,
         :prompt => "Command",
         :description => "Shell command to execute",
         :type => :string,
         :validation => '^.+$',
         :optional => false,
         :maxlength => 500

  output :output,
         :description => "Output from #{:cmd}",
         :display_as  => "Output"

  output :status,
         :description => "Return status of #{:cmd}",
         :display_as  => "Return Status"
end

