require 'csv'
Rake::Task["name_and_image:creates_or_updates"].invoke(['brands', 'telecommunications'])
Rake::Task["variants:creates_or_updates"].invoke
