require_relative "search_data.rb"

describe SearchData do
  it 'searches for string data' do
  	search_data = SearchData.new
  	args = [ '-e', 'project', '-k', 'name', '-s', 'Project with HP' ]
    filename = search_data.identify_json(args[1])
    expect(filename).to eq "projects.json"
    data_hash = search_data.parse_json(filename)
    expect(data_hash != nil).to eq true
    expected_obj = eval('{"_id"=> 102,"url"=> "http://example.com/projects-2","external_id"=> "7cd6b8d4-2999-4ff2-8cfd-44d05b449226","name"=> "Project with HP","location"=> ["Melbourne","Singapore"],"created_at"=> "2016-04-07T08:21:44 -10:00","details"=> "Non profit","published"=> false,"tags"=> ["Trevino"]}')
    matching_obj = search_data.find_match_in_file(data_hash, args[3], args[5])
    expect(matching_obj).to eq expected_obj
    formatted_result = search_data.format_result(matching_obj)
    puts formatted_result
    expect(formatted_result).to eq "\n\nSearch Results: \n\nUrl: http://example.com/projects-2\nExternal_id: 7cd6b8d4-2999-4ff2-8cfd-44d05b449226\nName: Project with HP\nLocation: Melbourne,Singapore\nCreated_at: 2016-04-07T08:21:44 -10:00\nDetails: Non profit\nPublished: false\nTags: Trevino\n"
  end

  it 'searches for integer data' do
    search_data = SearchData.new
    args = [ '-e', 'user', '-k', 'organization_id', '-s', '119' ]
    filename = search_data.identify_json(args[1])
    expect(filename).to eq "users.json"
    data_hash = search_data.parse_json(filename)
    expect(data_hash != nil).to eq true
    expected_obj = eval('{"_id"=> 1,"external_id"=> "74341f74-9c79-49d5-9611-87ef9b6eb75f","name"=> "Raylan Givens","created_at"=> "2016-04-15T05:19:46 -10:00","active"=> true,"verified"=> true,"shared"=> false,"locale"=> "en-AU","timezone"=> "Sri Lanka","last_login_at"=> "2013-08-04T01:03:27 -10:00","email"=> "test@example.com","phone"=> "8335-422-718","organization_id"=> 119,"tags"=> ["Springville","Sutton","Hartsville/Hartley","Diaperville"],"suspended"=> true,"role"=> "admin"}')
    matching_obj = search_data.find_match_in_file(data_hash, args[3], args[5])
    expect(matching_obj).to eq expected_obj
    formatted_result = search_data.format_result(matching_obj)
    puts formatted_result
    expect(formatted_result).to eq "\n\nSearch Results: \n\nExternal_id: 74341f74-9c79-49d5-9611-87ef9b6eb75f\nName: Raylan Givens\nCreated_at: 2016-04-15T05:19:46 -10:00\nActive: true\nVerified: true\nShared: false\nLocale: en-AU\nTimezone: Sri Lanka\nLast_login_at: 2013-08-04T01:03:27 -10:00\nEmail: test@example.com\nPhone: 8335-422-718\nOrganization_id: 119\nTags: Springville,Sutton,Hartsville/Hartley,Diaperville\nSuspended: true\nRole: admin\n"
  end

    it 'searches for boolean data' do
    search_data = SearchData.new
    args = [ '-e', 'user', '-k', 'active', '-s', 'true' ]
    filename = search_data.identify_json(args[1])
    expect(filename).to eq "users.json"
    data_hash = search_data.parse_json(filename)
    expect(data_hash != nil).to eq true
    expected_obj = eval('{"_id"=> 1,"external_id"=> "74341f74-9c79-49d5-9611-87ef9b6eb75f","name"=> "Raylan Givens","created_at"=> "2016-04-15T05:19:46 -10:00","active"=> true,"verified"=> true,"shared"=> false,"locale"=> "en-AU","timezone"=> "Sri Lanka","last_login_at"=> "2013-08-04T01:03:27 -10:00","email"=> "test@example.com","phone"=> "8335-422-718","organization_id"=> 119,"tags"=> ["Springville","Sutton","Hartsville/Hartley","Diaperville"],"suspended"=> true,"role"=> "admin"}')
    matching_obj = search_data.find_match_in_file(data_hash, args[3], args[5])
    expect(matching_obj).to eq expected_obj
    formatted_result = search_data.format_result(matching_obj)
    puts formatted_result
    expect(formatted_result).to eq "\n\nSearch Results: \n\nExternal_id: 74341f74-9c79-49d5-9611-87ef9b6eb75f\nName: Raylan Givens\nCreated_at: 2016-04-15T05:19:46 -10:00\nActive: true\nVerified: true\nShared: false\nLocale: en-AU\nTimezone: Sri Lanka\nLast_login_at: 2013-08-04T01:03:27 -10:00\nEmail: test@example.com\nPhone: 8335-422-718\nOrganization_id: 119\nTags: Springville,Sutton,Hartsville/Hartley,Diaperville\nSuspended: true\nRole: admin\n"
  end

  it 'searches for array value' do
    search_data = SearchData.new
    args = [ '-e', 'user', '-k', 'tags', '-s', 'Sutton' ]
    filename = search_data.identify_json(args[1])
    expect(filename).to eq "users.json"
    data_hash = search_data.parse_json(filename)
    expect(data_hash != nil).to eq true
    expected_obj = eval('{"_id"=> 1,"external_id"=> "74341f74-9c79-49d5-9611-87ef9b6eb75f","name"=> "Raylan Givens","created_at"=> "2016-04-15T05:19:46 -10:00","active"=> true,"verified"=> true,"shared"=> false,"locale"=> "en-AU","timezone"=> "Sri Lanka","last_login_at"=> "2013-08-04T01:03:27 -10:00","email"=> "test@example.com","phone"=> "8335-422-718","organization_id"=> 119,"tags"=> ["Springville","Sutton","Hartsville/Hartley","Diaperville"],"suspended"=> true,"role"=> "admin"}')
    matching_obj = search_data.find_match_in_file(data_hash, args[3], args[5])
    expect(matching_obj).to eq expected_obj
    formatted_result = search_data.format_result(matching_obj)
    puts formatted_result
    expect(formatted_result).to eq "\n\nSearch Results: \n\nExternal_id: 74341f74-9c79-49d5-9611-87ef9b6eb75f\nName: Raylan Givens\nCreated_at: 2016-04-15T05:19:46 -10:00\nActive: true\nVerified: true\nShared: false\nLocale: en-AU\nTimezone: Sri Lanka\nLast_login_at: 2013-08-04T01:03:27 -10:00\nEmail: test@example.com\nPhone: 8335-422-718\nOrganization_id: 119\nTags: Springville,Sutton,Hartsville/Hartley,Diaperville\nSuspended: true\nRole: admin\n"
  end

  it 'searches for hash value' do
    search_data = SearchData.new
    args = [ '-e', 'user', '-k', 'city', '-s', 'Melbourne' ]
    filename = search_data.identify_json(args[1])
    expect(filename).to eq "users.json"
    data_hash = search_data.parse_json(filename)
    expect(data_hash != nil).to eq true
    expected_obj = eval('{"_id"=> 2,"external_id"=> "c9995ea4-ff72-46e0-ab77-dfe0ae1ef6c2","name"=> "Joni Mitchell","organization_id" => 106,"alias"=> "Miss Joni","created_at"=> "2016-06-23T10:31:39 -10:00","active"=> true,"verified"=> true,"shared"=> false,"locale"=> "zh-CN","timezone"=> "Armenia","last_login_at"=> "2012-04-12T04:03:28 -10:00","email"=> "test2@example.com","phone"=> "9575-552-585","signature"=> "Don\'t Worry Be Happy!","tags"=> ["Foxworth","Woodlands","Herlong","Henrietta"],"suspended"=> false,"role"=> "member","location"=> {  "city"=> "Melbourne"}}')
    #expected_obj = eval('{"_id"=> 1,"external_id"=> "74341f74-9c79-49d5-9611-87ef9b6eb75f","name"=> "Raylan Givens","created_at"=> "2016-04-15T05:19:46 -10:00","active"=> true,"verified"=> true,"shared"=> false,"locale"=> "en-AU","timezone"=> "Sri Lanka","last_login_at"=> "2013-08-04T01:03:27 -10:00","email"=> "test@example.com","phone"=> "8335-422-718","organization_id"=> 119,"tags"=> ["Springville","Sutton","Hartsville/Hartley","Diaperville"],"suspended"=> true,"role"=> "admin"}')
    matching_obj = search_data.find_match_in_file(data_hash, args[3], args[5])
    expect(matching_obj).to eq expected_obj
    formatted_result = search_data.format_result(matching_obj)
    puts formatted_result
    expect(formatted_result).to eq "\n\nSearch Results: \n\nExternal_id: c9995ea4-ff72-46e0-ab77-dfe0ae1ef6c2\nName: Joni Mitchell\nAlias: Miss Joni\nCreated_at: 2016-06-23T10:31:39 -10:00\nActive: true\nVerified: true\nShared: false\nLocale: zh-CN\nTimezone: Armenia\nLast_login_at: 2012-04-12T04:03:28 -10:00\nEmail: test2@example.com\nPhone: 9575-552-585\nSignature: Don't Worry Be Happy!\nOrganization_id: 106\nTags: Foxworth,Woodlands,Herlong,Henrietta\nSuspended: false\nRole: member\nLocation: \n\tcity:Melbourne\n"
  end
end