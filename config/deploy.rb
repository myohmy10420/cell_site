# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "js-cell"
set :repo_url, "git@github.com:myohmy10420/cell_site.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, "/home/app/cell_site"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :linked_files, [
  "config/database.yml",
  "config/aws_s3.yml",
  "config/master.key",
  "config/email.yml"
]

# Default value for linked_dirs is []
set :linked_dirs, [
  "log",
  "tmp/sockets",
  "tmp/pids",
  "tmp/cache",
  "tmp/export",
  "public/system",
  "public/assets"
]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
