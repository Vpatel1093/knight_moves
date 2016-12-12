class Knight
	attr_accessor :position, :path
	def initialize(position, path)
		@position = position
		@path = path
	end
end

def knight_moves(start, finish)
	return "Invalid starting position." unless valid_position?(start)
	return "Invalid end position." unless valid_position?(finish)
	return "No moves necessary" if start == finish
	
	queue = [Knight.new(start,[start])]
	visited_squares = [start]
	
	until queue.empty?
		current = queue.shift
		
		possible_moves = possible_moves(current.position).select {|move| !visited_squares.include?(move) }
		
		if possible_moves.include?(finish)
			current.path << finish
			if current.path.size-1 == 1
				puts "You made it in #{current.path.size-1} move! Here's your path:"
			elsif current.path.size-1 > 1
				puts "You made it in #{current.path.size-1} moves! Here's your path:"
			end
			current.path.each {|position| p position}
			return
		end
		
		possible_moves.each do |move|
			queue << Knight.new(move, (current.path + [move]))
			visited_squares << [move]
		end
	end
end
		
def possible_moves(position)
	changes = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
	moves = []
	changes.each {|change| moves << [position[0]+change[0], position[1]+change[1]] }
	moves.select { |move| valid_position?(move)}
end

def valid_position?(position)
	return (position[0] > -1 && position[0] < 8) && (position[1] >-1 && position[1] < 8) ? true : false
end
