
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Kyle Webster
# kyle1234webster@gmail.com
#
###############################################################

# The Bigram data structure with a set default value as found on dotnetperls.com to prevent a nil class error
$bigrams = Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = 0}}
$name = "Kyle Webster"

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "
	#begin
	#processes file at each line
		IO.foreach(file_name) do |line|
			#cleans up song title
			line = cleanup_title(line)
			#prevents a nil error with a cleaned up song
			if line != nil
				#creates an array of bigrams as found on stackoverflow.com
				bigramArray = line.split.each_cons(2) do |e|
					#checks if the bigram exists
					if e[0] && e[1] != nil
						#makes a count from the existing bigram hash value
						count = $bigrams[e[0]][e[1]]
						count += 1
						#sets bigram hash value to updated count
						$bigrams[e[0]][e[1]] = count
					end
				end
			end
		end
		puts "Finished. Bigram model built.\n"
		rescue
		STDERR.puts "Could not open file"
		exit 4
	end

#seperates and cleans up song title
def cleanup_title(line)
	#deletes everything but the song title
	line.gsub!(/.+>/, '')
	#deletes superfluous text
	line.gsub!(/(\(|\[|\{|\\|\/|\_|\-|\:|\"|\`|\+|\=|\*|feat\.).+$/,'')
	#deletes punctuation
		line.gsub!(/(\?|\¿|\!|\¡|\.|\;|\&|\@|\%|\#|\|)*/,'')
		#determines if a word uses english characters or not
		if line =~ /^[\w\s']+$/
			line = line.downcase
		#if not english, sets line to nil
		else
			line = nil
		end
		return line
end

#determines the most common word from a given word
def mcw(word)
	mostCommonWord = ''
	value = 0
	#determines if a word in a hash happens the most
	$bigrams[word].each do |x|
		if x[1] > value
			mostCommonWord = x[0]
			value = x[1]
		end
	end
	return mostCommonWord
end

def create_title(word)
	songTitle = ''
	songTitle = songTitle + word
	inWord = ''
	inWord = word
	(0..18).each do
		inWord = mcw(inWord)
		if inWord == ''
			return songTitle
		else
		songTitle = songTitle + " " + inWord
	end
	end
	return songTitle
end
# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	begin
		# Get user input
		print "Enter a word [Enter 'q' to quit]:"
		word = gets
		if word != 'q'
			create_title(word)
		end
	end until input == 'q'

if __FILE__==$0
	main_loop()
end
end
