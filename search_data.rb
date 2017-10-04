#!/usr/bin/env ruby

require 'optparse'
require 'json'

# 1. parse command line args and store in options. Method parse_args
# 2. Identify JSON file to search based on the -e entity_type (users.json or projects.json) Method identify_json
# 3. parse json and return a hash
# 4. return the matching obj by parsing over the hash objects
# 5. format results. Convert the matching obj to a string for output
# 6. output result. Format the output and display the formatted result

class SearchData
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

  def parse_json(filename)
	file = File.read(filename)
	begin
  		data_hash = JSON.parse(file)
	rescue JSON::ParserError
		file = nil
	end
	data_hash
	#returns hash
  end

  def find_match(data_hash, key_name, search_str)
	matching_obj = data_hash.find {|obj| obj[key_name] == search_str}
  end

  def format_result(obj)
    formatted_str = "\n\nSearch Results: \n\n"
    obj.each do |key, value|
      unless key == "_id"
	    key_str = key.capitalize
	    if value.kind_of?(Array)
		  formatted_str << key_str << ": "
		  value.each do |var|
		    if var == value.last
			  formatted_str << var
		    else
			  formatted_str << var << ","
		    end
		  end
	    formatted_str << "\n"
	    elsif value.is_a?(Hash)
		  formatted_str << key_str << ": " << "\n"
		  value.each do |var_key, var_value|
		    formatted_str << "\t" << var_key << ":" << var_value << "\n"
		  end
	    else
		  value_str = ""
		  if value.is_a?(Integer)
		    value_str = value.to_s
		  elsif !!value == value
		    value_str = value ? "true" : "false"
		  else
		    value_str = value
		  end
		  formatted_str << key_str << ": " << value_str << "\n"
	    end
	  end
    end
    formatted_str
  end

  def print_result(formatted_result)
    puts formatted_result
  end

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
	  matching_obj = find_match(data_hash, options[:key], options[:search_term])
	  if (!matching_obj)
	    puts "No match found."
	    exit 0
	  end
	  formatted_result = format_result(matching_obj)
	  print_result(formatted_result)
    end
  end
end

