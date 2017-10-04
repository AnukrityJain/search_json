#!/usr/bin/env ruby

require 'optparse'
require 'json'

class SearchData
  # Parse_args will parse the command line options and save them in a hash
  # Returns the options hash
  def parse_args(args)
	options = {}

	opt_parser = args.options  do |parser|
  	  parser.banner = "Usage: search -e [user | project] -k KEY_NAME -s SEARCH_TERM"
	  parser.on("-e", "--entity ENTITY_TYPE", "Type of entity to search for.  Valid values: user | project") do |v|
	    options[:entity_type] = v
	  end
	  parser.on("-k", "--key KEY_NAME", "Name of key to search for.") do |v|
	    options[:key] = v
	  end
	  parser.on("-s", "--search SEARCH_TERM", "Search term.") do |v|
	    options[:search_term] = v
      end
	end.parse!

    if (!options.key?(:entity_type) || !options.key?(:key) || !options.key?(:search_term))
	  puts "Missing arguments.  Type search -h for usage information."
	  exit 1
    end
    options
  end


  # Identify_json will identify the JSON file to be used for searching
  # based on the entity_type passed to the function
  def identify_json(entity_type)
    if (entity_type == "user")
	  filename = "users.json"
    elsif (entity_type == "project")
	  filename = "projects.json"
    else
	  filename = nil
    end
    filename
  end


  # Parse_json will read the given JSON file into a hash and return it
  def parse_json(filename)
	file = File.read(filename)
	begin
  		data_hash = JSON.parse(file)
	rescue JSON::ParserError
		file = nil
	end
	data_hash
  end


  # find_match will compare and check if the search string is in the given |key, value| pair
  # and return true or false
  def find_match(key, value, key_str, search_str)
  	if value.kind_of?(Array)
  		value.each do |element_value|
  			#puts "key: " + key + ", element_value: " + element_value
  			if (find_match(key, element_value, key_str, search_str))
  				return true
  			end
  		end
	elsif value.kind_of?(Hash)
		value.each do |element_key, element_value|
			if (find_match(element_key, element_value, key_str, search_str))
				return true
			end
		end
	else
		if (key == key_str && value.to_s == search_str)
			return true
		end
	end
	return false
  end

  # find_match_in_file will read through the file hash and search for the required search string
  # in each key, value pair
  # If it finds a match it returns the associated object
  def find_match_in_file(data_hash, key_str, search_str)
  	matching_obj = {}
  	data_hash.each do |key, value|
  		key.each do |innerkey, innervalue|
			if (find_match(innerkey, innervalue, key_str, search_str))
				return key
			end

  		end
	end
	nil
  end

  # format_result will convert and return the given object into a Human Readable String format
  def format_result(obj)
    formatted_str = "\n\nSearch Results: \n\n"
    obj.each do |key, value|
      unless key == "_id"
	    key_str = key.capitalize
	    if value.kind_of?(Array)
		  	formatted_str << key_str << ": "
		 	value.each do |var|
		  		formatted_str << var.to_s << ((var == value.last) ? "" : ",")
		  	end
		  	formatted_str << "\n"
	    elsif value.is_a?(Hash)
		  formatted_str << key_str << ": " << "\n"
		  value.each do |var_key, var_value|
		    formatted_str << "\t" << var_key << ":" << var_value << "\n"
		  end
	    else
		  formatted_str << key_str << ": " << value.to_s << "\n"
	    end
	  end
    end
    formatted_str
  end

  # Prints the given string to console
  def print_result(formatted_result)
   puts formatted_result
  end

  #Entry point of the program
  def search_data(args)
    options = parse_args(args)
    if (options)
	  filename = identify_json(options[:entity_type])
	  if (!filename)
	    puts "Invalid Entity: '" + entity_type + "'"
	    exit 1
	  end
	  data_hash = parse_json(filename)
	  if (!data_hash)
	    puts "Failed to parse JSON file: '" + filename + "'"
	    exit 1
	  end
	  matching_obj = find_match_in_file(data_hash, options[:key], options[:search_term])
	  if (!matching_obj)
	    puts "No match found."
	    exit 0
	  end
	  formatted_result = format_result(matching_obj)
	  print_result(formatted_result)
    end
  end
end

