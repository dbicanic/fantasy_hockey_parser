class Goalie

	attr_reader :name, :points

 def initialize(args)
 	@name = args.fetch(:name)
 	@wins = args.fetch(:wins, 0)
 	@ga = args.fetch(:ga, 0)
 	@sv = args.fetch(:sv, 0)
 	@so = args.fetch(:so, 0)
 	@otl = args.fetch(:otl, 0)
 	@points = point_maker
 end

 def point_maker
 	@points = (@wins * 5) + (@ga * -1) + (@sv * 0.1) + (@so * 3) + (@otl + 2)
 	@points.round
 end
end