set :stage, :production
set :rvm_type, :system
set :rvm_ruby_version, '2.2.4@canseidovermelho'

server "canseidovermelho.com", user: "canseidovermelho", roles: %w{web app db}
