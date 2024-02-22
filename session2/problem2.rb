module FileSystemUtils
  def initialize(file_system)
    @file_system = file_system
  end

  def total_number_of_files
    @file_system.flatten.count { |i| i.include? "." }
  end

  def search_file(file_name)
    case @file_system
    in [*, ^file_name, *]
      "/#{file_name}"
    in [*, [*, ^file_name, *] => directory, *]
      "/" + directory.select { |i| !i.include? "." }.join("/") + "/" + file_name
    else
      "File not found"
    end
  end

  def filter_by_extension(extension)
    files = []
    @file_system.each do |i|
      case i
      in String => f if f.end_with? extension
        files << "/#{f}"
      in Array => d if d.map { |f| f.include? extension }
        d_path = d.select { |i| !i.include? "." }.join("/")
        d.each do |f|
          files << "/" + d_path + "/" + f if f.include? extension
        end
      else
      end
    end

    files
  end

  def empty?
    @file_system.empty?
  end
end

class FileSystem
  include FileSystemUtils

  attr_accessor :file_system
end

file_system = [
  "README.txt",
  ["images", "photo.jpg", "logo.png"],
  "main.rb",
  ["src", "modules", "user.rb", "helper.rb"],
  "data.json"
]

fs = FileSystem.new(file_system)
puts "Total number of files: #{fs.total_number_of_files}"

puts "\nSearch 'README.txt': #{fs.search_file("README.txt")}"
puts "Search 'logo.png': #{fs.search_file("logo.png")}"
puts "Search 'user.rb': #{fs.search_file("user.rb")}"
puts "Search 'nothing.rb': #{fs.search_file("nothing.rb")}"

puts "\nFilter '.rb' files:"
puts fs.filter_by_extension(".rb")
