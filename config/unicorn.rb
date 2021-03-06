root = "/home/deployer/apps/chat_front/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_chat_front.log"
stdout_path "#{root}/log/unicorn_chat_front.log"

listen "/tmp/unicorn.chat_front.sock"
listen 7000
worker_processes 2
timeout 30