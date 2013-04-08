namespace :cran do
  desc "Synchonize package index file"
  task :update => :environment do
  end

  desc "Get information about certain package"
  task :info => :environment do |t, args|
    gem_name = ENV["name"] || ENV["n"]
    
    if !gem_name || gem_name.blank?
      puts "Define package name i.e : rake cran:info [name|n]=PACKAGE_NAME"
      next
    end
    
    puts "Running, getting info for '#{gem_name}'"
  end

end
