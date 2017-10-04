require "./search_data.rb"

describe SearchData do
  it 'searches for data' do
  	search_data = SearchData.new
  	args = [ '-e', 'project', '-k', 'name', '-s', 'Project with HP' ]
    filename = search_data.identify_json(args[1])
    expect(filename).to eq "projects.json"
    data_hash = search_data.parse_json(filename)
    expect(data_hash != nil).to eq true
    expected_obj = eval('{"_id"=> 102,"url"=> "http://example.com/projects-2","external_id"=> "7cd6b8d4-2999-4ff2-8cfd-44d05b449226","name"=> "Project with HP","location"=> ["Melbourne","Singapore"],"created_at"=> "2016-04-07T08:21:44 -10:00","details"=> "Non profit","published"=> false,"tags"=> ["Trevino"]}')
    matching_obj = search_data.find_match(data_hash, args[3], args[5])
    expect(matching_obj).to eq expected_obj
    formatted_result = search_data.format_result(matching_obj)
    puts formatted_result
    expect(formatted_result).to eq "\n\nSearch Results: \n\nUrl: http://example.com/projects-2\nExternal_id: 7cd6b8d4-2999-4ff2-8cfd-44d05b449226\nName: Project with HP\nLocation: Melbourne,Singapore\nCreated_at: 2016-04-07T08:21:44 -10:00\nDetails: Non profit\nPublished: false\nTags: Trevino\n"

  end
end