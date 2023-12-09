
days_dir = File.join(File.expand_path("."), 'days', '')

total_time = 0

Dir["#{days_dir}day*.rb"].each do |file|
	day = file.match(/day(\d\d)\.rb/)
	next unless day

	day = day[1].to_i
	if day > 0 and day < 26
		start = Time.now
		require file
		total_time += (Time.now-start)
	end
end

puts "\nTotal runtime:\t#{total_time}s"
