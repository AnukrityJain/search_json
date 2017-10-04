How to Install:
-----------------

1) Install JSON (gem intall json)
2) Install RSpec (gem install rspec)


How to Run via command line:
----------------------------

1) ruby search_data_cli.rb -e entity_type -k key_name -s search_string

The above command should print the object containing the search_string on the console in human readable format


How to Run Tests:
-----------------

1) rspec search_data_spec.rb

The above command will automatically invoke all the tests in the search_data_spec.rb file.   Currently there are 3 success cases which should all pass


High-level Algo steps:
----------------------

1) Read th command line argumets into an options array
2) Identify the JSON file to search in for, based on the entity_type in options array
3) Parse the JSOn and return convert it into a hash
4) Search for the required value in the hash objects and return the matching obj
5) Convert the returned object to a display string
6) Format the String and print it on the console

Please refer the source file search_data.rb for detailed code and supporting comments for more information about the above steps.
