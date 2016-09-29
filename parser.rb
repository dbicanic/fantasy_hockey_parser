require "nokogiri"

hockey_goalie = File.open("NHLGoalies2015-16.xls") {|f| Nokogiri::XML(f)}

hockey_goalie.xpath('//first_name')