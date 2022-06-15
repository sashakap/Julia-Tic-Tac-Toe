function printBoard(GameBoard::Array{Int})
    s = ""
    for i in 1:3
        for j in 1:3
            if GameBoard[i,j] == 0
                s = string(s, " _ ")
            elseif GameBoard[i,j] == 1
                s = string(s, " X ")
            elseif GameBoard[i,j] == 2
                s = string(s, " O ")
            end
        end
        s = string(s, "\n\n")
    end
    s = string(s, "\n")
    return s
end

#=

function playerMove(GameBoard::Array{Int}, space)
    while(true)
        if GameBoard[space] == 0
          GameBoard[space] = 1
          playerCooridantes = [space]
          return playerCooridantes
          break
        else
            println("Invalid Space, try again\n")
            println(printBoard(GameBoard))
            println()
        end
    end
end
=#

function computerMove(GameBoard::Array{Int})
    while(true)
        row = rand(1:3)
        column = rand(1:3)
        
        aiCoordinants = [0,0]

        if GameBoard[row,column] == 0
            aiCoordinants = [row, column]
            return aiCoordinants
            break
        end
    end

    return GameBoard
end

function checkPlot(Plot::Array{Int}, identifier)
    if Plot[1] == 0 && Plot[2] == 0 && Plot[3] == 0 
        return false
    end
    
    if Plot[1] == identifier && Plot[2] == identifier && Plot[3] == identifier
        return true
    else
        return false
    end
end

function checkWin(GameBoard::Array{Int}, identifier)
    #Check Vertical Line
    plot = [0,0,0]
    
    for i in 1:3
        for j in 1:3
                plot[j] = GameBoard[i,j]
        end
        if checkPlot(plot, identifier) == true
            return 1
        end
    end
   
    #Check Horizontal
    for i in 1:3
        for j in 1:3
                plot[j] = GameBoard[j,i]
        end
        if checkPlot(plot, identifier) == true
            return 1
        end
    end
    
    #Check Diagonal 1
    plot = [GameBoard[1,1], GameBoard[2,2], GameBoard[3,3]]
    checkPlot(plot, identifier)

    if checkPlot(plot, identifier) == true
        return 1
    end

    #Check Diagonal 2
    plot = [GameBoard[3,1], GameBoard[2,2], GameBoard[1,3]]
    checkPlot(plot, identifier)

    if checkPlot(plot, identifier) == true
        return 1
    end

    #Tie
    if !(0 in GameBoard)
        return 0
    end
end
#=
function score(GameBoard::Array{Int}, depth, identifier)
    player = 0
    opponent = 0

    if identifier = 1
        player = 1
        opponent = 2
    else
        player = 2
        opponent = 1 
    end

    if checkWin(GameBoard, player)
        return 10 - depth
    elseif checkWin(GameBoard, opponent)
        return depth - 10
    else
        return 0
    end
end

function minimax(GameBoard::Array{I}, depth)
    return score(game) if game.over?
    depth += 1
    scores = [] # an array of scores
    moves = []  # an array of moves

    # Populate the scores array, recursing as needed
    game.get_available_moves.each do |move|
        possible_game = game.get_new_state(move)
        scores.push minimax(possible_game, depth)
        moves.push move
    end

    # Do the min or the max calculation
    if game.active_turn == @player
        # This is the max calculation
        max_score_index = scores.each_with_index.max[1]
        @choice = moves[max_score_index]
        return scores[max_score_index]
    else
        # This is the min calculation
        min_score_index = scores.each_with_index.min[1]
        @choice = moves[min_score_index]
        return scores[min_score_index]
    end
end

=#

function game()
    touch("results.txt")
    println("Would you like to go 1st or 2nd(type in 1 or 2)")
    turn = readline()
    turn = parse(Int, turn)
    if turn == 1
        println("You're going first")
    else
        println("You're going second")
    end

    println("You will be \"X\"")

    GameBoard = zeros(Int, 3, 3)

    print(printBoard(GameBoard))
    for i in 0:7
        if turn == 1
            playerCooridinants = playerMove(GameBoard) #Player Move
            println(printBoard(GameBoard))

            if checkWin(GameBoard,1) == 1
                println("You Win!")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Won!")
                    close(file)
                end
                break
            elseif checkWin(GameBoard,1) == 0
                println("It's a tie! Try again!")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Tied!")
                    close(file)
                end
                break
            end

            aiCoordinants = computerMove(GameBoard) #Computer Move
            GameBoard[aiCoordinants[1], aiCoordinants[2]] = 2
            println(printBoard(GameBoard))

            if checkWin(GameBoard,2) == 1
                println("You lose")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Lost!")
                    close(file)
                end
                break
            elseif checkWin(GameBoard,2) == 0
                println("It's a tie! Try again!")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Tied!")
                    close(file)
                end
                break
            end

            i+=1

        else
            aiCoordinants = computerMove(GameBoard) #Computer Move
            GameBoard[aiCoordinants[1], aiCoordinants[2]] = 2
            print(printBoard(GameBoard))
            
            if checkWin(GameBoard,2) == true
                println("You lose")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Lost!")
                    close(file)
                end
                break
            elseif checkWin(GameBoard,2) == 0
                println("It's a tie! Try again!")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Tied!")
                    close(file)
                end
                break
            end

            playerCooridinants = playerMove(GameBoard) #Player Move
            print(printBoard(GameBoard))
           
            if checkWin(GameBoard,1) == 1
                println("You Win!")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Won!")
                    close(file)
                end
                break
            elseif checkWin(GameBoard,1) == 0
                println("It's a tie! Try again!")
                open("results.txt", "w") do file
                    write(file, printBoard(GameBoard)*"You Tied!")
                    close(file)
                end
                break
            end
            i+=1

        end
    end
    
    println("The game is over! Go to \"results.txt\" to check out the the final board")
    
end 