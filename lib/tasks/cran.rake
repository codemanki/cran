namespace :cran do
  desc "Synchonize package index file"
  task :update => :environment do
  end

  desc "Get information about certain package"
  task :info => :environment, :package_name do |package_name|
  end

end
