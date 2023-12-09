require 'date'
require 'erb'

# Select and validate day number
day = Date.today.strftime("%d").to_i
if ARGV.length > 0
	day = ARGV[0].to_i
end
if day < 1 or day > 25
	puts "Usage: #{File.basename($0)} [day_number]"
	exit
end

puts "Generating files for day #{day}..."

str_day = "%02d" % day
base_dir = File.join(File.expand_path("."))

# Check if the files for this day already exists, do not overwrite!
day_path = File.join(base_dir, "days", "day#{str_day}.rb")
if File.exist?(day_path)
	puts "The files for this day already exist"
	exit
end

# Generate solution file from template
tpl_file = File.read(File.join(base_dir, "tools", "day_template.erb"))
tpl = ERB.new(tpl_file)
File.write(day_path, tpl.result(binding))
puts "Created solution file"

# Generate test_input file
test_path = File.join(base_dir, "inputs", "test", "test_input#{str_day}")
File.write(test_path, "")
puts "Created empty test file"

puts "Done"
