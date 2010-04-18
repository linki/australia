namespace :bundle do
  task :album => :environment do
    album = Album.find(ENV['ID'])
    puts "Now Bundling Album #{album.id}."
    album.bundle
    puts "Finished Bundling Album #{album.id}."
  end
end