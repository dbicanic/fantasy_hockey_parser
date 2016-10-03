require "roo-xls"
require "csv"
require_relative "goalie"
require_relative "skating"


goalies = []
skaters = []

goalie_book = Roo::Excel.new("NHLGoalies2015-16.xls")
skater_book = Roo::Excel.new("NHL_2015-16.xls")

goalie_default_sheet = goalie_book.sheets[0]
skater_default_sheet = skater_book.sheets[0]

goalie_headers = Hash.new
goalie_book.row(1).each_with_index {|header, i|
goalie_headers[header] = i 
}

((goalie_book.first_row + 1)..goalie_book.last_row).each do |row|
	first_name = goalie_book.row(row)[goalie_headers["First Name"]]
	last_name = goalie_book.row(row)[goalie_headers["Last Name"]]
	wins = goalie_book.row(row)[goalie_headers["W"]]
	ga = goalie_book.row(row)[goalie_headers["StGA"]]
	sv = goalie_book.row(row)[goalie_headers["Sv"]]
	so = goalie_book.row(row)[goalie_headers["SO"]]
	otl = goalie_book.row(row)[goalie_headers["OT"]]
	gs = goalie_book.row(row)[goalie_headers["GS"]]

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

skater_header = Hash.new
skater_book.row(1).each_with_index {|header, i|
skater_header[header] = i 
}

((skater_book.first_row + 1)..skater_book.last_row).each do |row|
	first_name = 	skater_book.row(row)[skater_header["First Name"]]
	last_name = 	skater_book.row(row)[skater_header["Last Name"]]
	plus_minus = 	skater_book.row(row)[skater_header["plus_minus"]]
	goals = 			skater_book.row(row)[skater_header["G"]]
	assists = 		skater_book.row(row)[skater_header["A"]]
	fow = 				skater_book.row(row)[skater_header["FOW"]]
	fol = 				skater_book.row(row)[skater_header["FOL"]]
	sh = 					skater_book.row(row)[skater_header["Sh"]]
	miss = 				skater_book.row(row)[skater_header["Misses"]]
	blocked = 		skater_book.row(row)[skater_header["Blocked"]]
	hit = 				skater_book.row(row)[skater_header["HitF"]]
	blk = 				skater_book.row(row)[skater_header["BkS"]]
	gp = 					skater_book.row(row)[skater_header["GP"]]
	pos = 				skater_book.row(row)[skater_header["Pos"]]

	if gp >= 25
		name = first_name + " " + last_name
		sog = sh - miss - blocked
		skater_data = {
			:name => name,
			:plus_minus => plus_minus,
			:goals => goals,
			:assists => assists, 
			:fow => fow,
			:fol => fol,
			:sog => sog,
			:hit => hit,
			:blk => blk,
			:pos => pos
			}
		skaters << Skater.new(skater_data)
	end
end

CSV.open("fantasy_hockey.csv", "wb") do |row|
	row << ["Points", "Name", "Position"]
	skaters.each do |skater|
		row << [skater.points, skater.name, skater.pos]
	end
	goalies.each do |goalie|
		row << [goalie.points, goalie.name, goalie.pos]
	end
end

