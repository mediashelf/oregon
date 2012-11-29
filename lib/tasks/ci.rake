desc 'Run ci build'
task :ci do
  require 'jettywrapper'
  jetty_params = Jettywrapper.load_config
  puts "Starting jetty #{Time.now}"
  error = Jettywrapper.wrap(jetty_params) do
    $stderr.puts "jetty started #{Time.now}"
    Rake::Task['spec'].invoke
  end
  raise "test failures: #{error}" if error
end

