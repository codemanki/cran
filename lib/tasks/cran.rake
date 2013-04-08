namespace :cran do
  desc "Synchonize package index file"
  task :update => :environment do
    puts "Updating...."
    CranApi::Cran.new.update_packages
    puts "Done!"
  end
  
  desc "Clean package list"
  task :clean => :environment do
    packages = Package.all
    puts "I have #{packages.count} packages. Destroying them"
    Package.destroy_all
  end
  
  desc "List all packages"
  task :list => :environment do
    puts "Getting index..."
    packages = Package.all
    
    packages.each do |package|
      print_info(package)
    end
  end
  
  desc "Get information about certain package"
  task :info => :environment do |t, args|
    package_name = ENV["name"] || ENV["n"]
    
    if !package_name || package_name.blank?
      puts "Define package name i.e : rake cran:info [name|n]=PACKAGE_NAME"
      next
    end
    
    puts "Running, getting info for '#{package_name}'"
    
    package = Package.find_by_name(package_name)
    print_info(package)
  end

end

def print_info(package)
  puts "Package #{package[:name]}"
  package.versions.includes(:authors).includes(:maintainers).each do |version|
      puts "  Title: #{version[:title]}"
      puts "  Version: #{version[:version]}"
      version.authors.each do |auth|
        puts "  Author: #{auth[:name]}" 
      end
      version.maintainers.each do |mntr|
        puts "  Maintainer: #{mntr[:name]}" 
      end
  end
end
