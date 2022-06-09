using PlotlyJS, WebIO, Blink, Images, Colors

include("Game.jl")

iterator = 1

trace = scatter(
    x = [0.5, 0.5, 0.5, 1.5, 1.5, 1.5, 2.5, 2.5, 2.5],
    y = [2.5, 1.5, 0.5, 2.5, 1.5, 0.5, 2.5, 1.5, 0.5],
    mode = "markers",
    xaxis_showgrid=false, 
    yaxis_showgrid=false,
    marker=attr(size=100, color="SKYBLUE"),
    title = "Tic-Tac-Toe",
)

layout = Layout(    
    autosize = false,
    width = 500,
    height = 500,
    scrollZoom=false,
    bgcolor = "white",

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

add_shape!(p, line(
    x0=1, y0=0,
    x1=1, y1=3,
    line=attr(color="Black", width=5),
))

add_shape!(p, line(
    x0=2, y0=0,
    x1=2, y1=3,
    line=attr(color="Black", width=5),
))

add_shape!(p, line(
    x0=0, y0=2,
    x1=3, y1=2,
    line=attr(color="Black", width=5),
))

add_shape!(p, line(
    x0=0, y0=1,
    x1=3, y1=1,
    line=attr(color="Black", width=5),
))
    


GameBoard = zeros(Int, 3, 3)

color_vec = (fill("lightskyblue", 10), fill("blue", 10))
symbols = (fill("circle", 10), fill("circle", 10))

d1 = []
d2 = []

on(p["click"]) do data
    global iterator

    color_vec = (fill("lightskyblue", 10), fill("blue", 10))
    symbols = (fill("circle", 10), fill("circle", 10))
    for i in d1
        color_vec[i[1]][i[2]] = "black"
        symbols[i[1]][i[2]] = "x"
    end
        
    for i in d2
        color_vec[i[1]][i[2]] = "black"
        symbols[i[1]][i[2]] = "circle-open"
    end
        
    for point in data["points"]
        
        if iterator %2 == 1
            if GameBoard[point["pointIndex"] + 1] != 0
                println("Invalid Move, try Again")
            else
                color_vec[point["curveNumber"] + 1][point["pointIndex"] + 1] = "black"
                symbols[point["curveNumber"] + 1][point["pointIndex"] + 1] = "x"
                push!(d1, (point["curveNumber"] + 1,point["pointIndex"] + 1) )
                GameBoard[point["pointNumber"]+1] = 1
                restyle!(p, marker_color=color_vec, marker_symbol=symbols)
                if checkWin(GameBoard, 1) == true
                    println("X Wins!")
                    savefig(p,"Resuls.png")
                    return;
                elseif checkWin(GameBoard, 1) == false
                    println("It's a tie")
                    savefig(p,"Resuls.png")
                    return;
                end
            end
            randomNumber = rand(1:9)
            while GameBoard[randomNumber] != 0
                randomNumber = rand(1:9)
            end
            color_vec[point["curveNumber"] + 1][(point["pointIndex"] - point["pointIndex"]) + randomNumber] = "black"
            symbols[point["curveNumber"] + 1][(point["pointIndex"] - point["pointIndex"]) + randomNumber] = "circle-open"
            push!(d2, (point["curveNumber"] + 1,(point["pointIndex"] - point["pointIndex"]) + randomNumber) )
            GameBoard[randomNumber] = 2
            restyle!(p, marker_color=color_vec, marker_symbol=symbols)

            if checkWin(GameBoard, 2) == true
                println("O Wins!")
                savefig(p,"Resuls.png")
                return;
            elseif checkWin(GameBoard, 2) == false
                println("It's a tie")
                savefig(p,"Resuls.png")
                return;
            end
        end
        iterator+=1 
    end
end
println()
PlotlyJS.display_blink(p)