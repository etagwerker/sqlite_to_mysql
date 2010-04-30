#!/usr/bin/env ruby

# Util methods

def usage
  puts "Usage: ruby sqlite3_to_mysql.converter.rb path/to/source/file.sqlite3 path/to/result/file.mysql"
end

def replace_sqlite_dialect(line)
  if line.include? "sqlite"
    ""
  else
    result = line.gsub(/"/,'')
    result = result.gsub(/AUTOINCREMENT/,'AUTO_INCREMENT')
    result = result.gsub(/boolean DEFAULT 'f'/,'boolean DEFAULT FALSE')
    result = result.gsub(/boolean DEFAULT 't'/,'boolean DEFAULT TRUE')
    result
  end	
end


# Main

if ARGV.size != 2
  usage
  exit
end

source_file = ARGV[0]
target_file = ARGV[1]

source = File.new(source_file,"r")
target = File.new(target_file,"w")

puts "Starting conversion"

source.each_line do |line|
  target.write replace_sqlite_dialect(line)
end

puts "Finished conversion" 

source.close
target.close
