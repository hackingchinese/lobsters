set :output, "/apps/hackingchinese/prod/lobster/shared/log/cron.log"
job_type :runner, "cd :path && bin/rails runner -e :environment ':task' :output"

# every 60.minutes do
  # rake "ts:rebuild"
# end

