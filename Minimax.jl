player = 1
opponent = 2

function isMovesLeft(board)
	for i in 1:3
		for j in 1:3
			if (board[i,j] == 0) 
				return true
            end
        end
    end
    return false
end

function evaluate(board) 

	# Checking for Rows for X or O victory.
	for row in 1:3	
		if (board[row,1] == board[row,2] && board[row,2] == board[row,3])	
			if (board[row,1] == player) 
				return 10
            elseif (board[row,1] == opponent) 
				return -10
            end
        end
    end

	# Checking for Columns for X or O victory.
	for col in 1:3
		if (board[1,col] == board[2,col] && board[2,col] == board[3,col])
			if (board[1,col] == player) 
				return 10
            elseif (board[1,col] == opponent) 
				return -10
            end
        end
    end

	# Checking for Diagonals for X or O victory.
	if (board[1,1] == board[2,2] && board[3,3] == board[2,2])
		if (board[1,1] == player)
			return 10
        elseif (board[1,1] == opponent)
			return -10
        end
    end
	
    if (board[1,3] == board[2,2] && board[2,2] == board[3,1])
		if (board[1,3] == player)
			return 10
        elseif (board[1,3] == opponent)
			return -10
        end
    end

	# Else if none of them have won then return 0
	return 0
end

# This is the minimax function. It considers all
# the possible ways the game can go and returns
# the value of the board
function minimax(board, depth, isMax)
	score = evaluate(board)
    #board = deepcopy(boards)


	# If Maximizer has won the game return his/her
	# evaluated score
	if (score == 10)
		return score
    end

	# If Minimizer has won the game return his/her
	# evaluated score
	if (score == -10)
		return score
    end

	# If there are no more moves and no winner then
	# it is a tie
	if (isMovesLeft(board) == false) 
		return 0
    end

	# If this maximizer's move
	if (isMax)
		best = -1000
		# Traverse all cells
		for i in 1:3	
			for j in 1:3
				# Check if cell is empty
				if (board[i,j] == 0)
				
					# Make the move
					board[i,j] = player

					# Call minimax recursively and choose
					# the maximum value
					best = max(best, minimax(board, depth + 1, !isMax))

					# Undo the move
					board[i,j] = 0
                end
            end
        end
	    return best

	# If this minimizer's move
	else
		best = 1000

		# Traverse all cells
		for i in 1:3	
			for j in 1:3
			
				# Check if cell is empty
				if (board[i,j] == 0)
				
					# Make the move
					board[i,j] = opponent

					# Call minimax recursively and choose
					# the minimum value
					best = min(best, minimax(board, depth + 1, !isMax))

					# Undo the move
					board[i,j] = 0
                end
            end
        end
		return best
    end
end

# This will return the best possible move for the player
function findBestMove(board)
	bestVal = -1000
	bestMove = (-1, -1)


	# Traverse all cells, evaluate minimax function for
	# all empty cells. And return the cell with optimal
	# value.
	for i in 1:3	
		for j in 1:3
		
			# Check if cell is empty
			if (board[i,j] == 0) 
			
				# Make the move
				board[i,j] = player

				# compute evaluation function for this
				# move.
				moveVal = minimax(board, 0, false)

				# Undo the move
				board[i,j] = 0

				# If the value of the current move is
				# more than the best value, then update
				# best/
				if (moveVal > bestVal)			
					bestMove = (i, j)
					bestVal = moveVal
                end
            end
        end
    end
	return bestMove
end
