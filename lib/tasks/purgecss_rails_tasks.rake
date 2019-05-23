# desc "Explaining what the task does"
# task :purgecss_rails do
#   # Task goes here
# end

task :purge_css do
  PurgecssRails.run_now!
end