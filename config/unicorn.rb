working_directory "/vagrant/services/chat"
pid "/vagrant/services/chat/tmp/pids/unicorn.pid"
stderr_path "/vagrant/services/chat/unicorn/unicorn.log"
stdout_path "/vagrant/services/chat/unicorn/unicorn.log"

listen "/tmp/unicorn.chat.sock"
worker_processes 2
timeout 30