set :application, 'canseidovermelho'
set :repo_url, 'git@github.com:paulourgal/canseidovermelho'
set :deploy_to, '/canseidovermelho/app'
set :keep_releases, 5
set :ping_url, "canseidovermelho.com"
set :sprockets_asset_host, "localhost"
set :deploy_via, :remote_cache

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :ping do
    system "curl #{fetch(:ping_url)} > /dev/null"
  end

  task :configure do
    on roles(:app) do
      execute :cp, "/canseidovermelho/app/config/database.yml", release_path.join('config/')
      # execute :cp, "/canseidovermelho/app/config/newrelic.yml", release_path.join('config/')
    end
  end
end

before "deploy:compile_assets", "deploy:configure"
after "deploy:finished", "deploy:restart"
after "deploy:restart", "deploy:ping"

def _get_branch
  print "\n  * ", "-" * 50, "\n"
  puts "    Deploy: Type branch name, tag name or SHA1. Default: [ master ]"
  branch_name = $stdin.gets.chomp
  branch_name = 'master' if branch_name == ''
  puts "    Deploying: [ #{branch_name} ]\n"
  print "  * ", "-" * 50, "\n"

  branch_name
end

set :branch, ENV['BRANCH'] || _get_branch