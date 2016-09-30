require "roo-xls"
require_relative "goalie"

goalies = []

goalie_book = Roo::Excel.new("NHLGoalies2015-16.xls")

goalie_default_sheet = goalie_book.sheets[0]

headers = Hash.new
goalie_book.row(1).each_with_index {|header, i|
headers[header] = i 
}

((goalie_book.first_row + 1)..goalie_book.last_row).each do |row|
	first_name = goalie_book.row(row)[headers["First Name"]]
	last_name = goalie_book.row(row)[headers["Last Name"]]
	wins = goalie_book.row(row)[headers["W"]]
	ga = goalie_book.row(row)[headers["StGA"]]
	sv = goalie_book.row(row)[headers["Sv"]]
	so = goalie_book.row(row)[headers["SO"]]
	otl = goalie_book.row(row)[headers["OT"]]
	gs = goalie_book.row(row)[headers["GS"]]

	if gs >= 25
		name = first_name + " " + last_name
		goalie_data = {
			:name => name,
			:wins => wins,
			:ga => ga,
			:sv => sv, 
			:so => so,
			:otl => otl
			}
		goalies << Goalie.new(goalie_data)
	end
end

p goalies
