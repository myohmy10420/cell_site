require 'csv'
Rake::Task["name_and_image:creates_or_updates"].invoke(['telecommunications'])

Rake::Task["stores:creates_or_updates"].invoke

Rake::Task["variants:creates_or_updates"].invoke
Rake::Task["recoveries:creates_or_updates"].invoke
Rake::Task["products:creates_or_updates"].invoke
