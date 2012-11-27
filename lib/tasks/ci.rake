desc 'Run ci build'
task :ci do
  require 'jettywrapper'
  jetty_params = Jettywrapper.load_config
  jetty_params[:startup_wait]= 60
  error = Jettywrapper.wrap(jetty_params) do
    Rake::Task['spec'].invoke
  end
  raise "test failures: #{error}" if error
end

