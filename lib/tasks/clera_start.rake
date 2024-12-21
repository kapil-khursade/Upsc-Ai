namespace :server do
  desc "Clear Rails logs and restart the server"
  task :clear_start do
    puts "Clearing logs..."
    puts "Restarting the Rails server..."
    exec("clear && rails s")
  end
end
