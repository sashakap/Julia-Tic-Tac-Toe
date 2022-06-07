using PlotlyJS, WebIO, Blink, Images, Colors

include("Game.jl")
#include("UI.jl")

color_defualt = colorant"rgb(229,236,246)"

trace = scatter(
    x = [.5, 1.5, 2.5, .5, 1.5, 2.5,.5, 1.5, 2.5],
    y = [.5, .5, .5, 1.5, 1.5, 1.5, 2.5, 2.5, 2.5],
    mode = "markers",
    marker=attr(size=100, color=color_defualt, symbol=("sqaure",))
)

layout = Layout(    
    autosize = false,
    width = 500,
    height = 500,
    scrollZoom=false,

    xaxis = attr(
        title_text = "Columns",    
        tickvals = [0, 1, 2, 3],
        tickmode="array",
        titlefont_size=30,
        automargin = true    
    ),

    yaxis = attr(
        title_text = "Rows",
        tickvals=[0, 1, 2, 3],
        tickmode="array",
        titlefont_size=30,
        automargin=true
    ),
)

p = plot(trace, layout)
PlotlyJS.display_blink(p)



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