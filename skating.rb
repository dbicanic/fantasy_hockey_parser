class Skater

	attr_reader :name, :points, :pos

 def initialize(args)
 	@name = args.fetch(:name)
 	@goals = args.fetch(:goals, 0)
 	@assists = args.fetch(:assists, 0)
 	@plus_minus = args.fetch(:plus_minus, 0)
 	@fow = args.fetch(:fow, 0)
 	@fol = args.fetch(:fol, 0)
 	@sog = args.fetch(:sog, 0)
 	@hit = args.fetch(:hit, 0)
 	@blk = args.fetch(:blk, 0)
 	@points = point_maker
 	@pos = args.fetch(:pos, "")
 end

 def point_maker
 	@points = (@goals * 2) + (@assists) + (@plus_minus * 0.5) + (@fow * 0.1) + (@fol * -0.1) + (@sog * 0.2) + (@hit * 0.2) + (@blk * 0.3)
 	@points.round
 end
end