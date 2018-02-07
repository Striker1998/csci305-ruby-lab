
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Kyle Webster
# kyle1234webster@gmail.com
#
###############################################################

$bigrams = Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = 0}} # The Bigram data structure
$name = "Kyle Webster"

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "
	#begin
		IO.foreach(file_name) do |line|
				#cleans up song title
			line = cleanup_title(line)
			if line != nil
				bigramArray = line.split.each_cons(2) do |e|
					first_word = e[0]
					second_word = e[1]
					if second_word && first_word != nil
						count = $bigrams[first_word][second_word]
						count += 1
						$bigrams[first_word][second_word] = count
					end
				end
			end

			# do something for each line
		end

		puts "Finished. Bigram model built.\n"
		rescue
		STDERR.puts "Could not open file"
		exit 4
	end

def cleanup_title(line)
	#deletes everything but the song title
	line.gsub!(/%.+>/, '')
	#deletes superfluous text
	line.gsub!(/(\(|\[|\{|\\|\/|\_|\-|\:|\"|\`|\+|\=|\*|feat\.).+$/,'')
	#deletes punctuation
		line.gsub!(/(\?|\¿|\!|\¡|\.|\;|\&|\@|\%|\#|\|)*/,'')
		#determines if a word uses english characters or not
		if line =~ /^[\w\s']+$/
			line = line.downcase
		else
			line = nil
		end
		return line
end

#determines the most common word from a given word
def mcw(word)
	p $bigrams[word]
	return mostCommonWord
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

	# Get user input
end

if __FILE__==$0
	main_loop()
end
