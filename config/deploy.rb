set :application, 'links.hackingchinese.com'
set :repo_url, 'https://github.com/zealot128/lobsters.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/apps/hackingchinese/prod/lobster'
set :scm, :git

set :format, :pretty
set :pty, true
# set :log_level, :info

set :linked_files, %w{config/database.yml .env config/email.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads db/sphinx}

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  after :finishing, 'deploy:cleanup'
  # after 'restart', :ping_restart
end

desc 'ping server for passenger restart'
task :ping_restart do
  run_locally do
    execute 'curl --silent http://www.podfilter.de'
  end
end
