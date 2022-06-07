using PlotlyJS, WebIO, Blink, Images, Colors

    trace = scatter(
        x = [.5, 1.5, 2.5, .5, 1.5, 2.5,.5, 1.5, 2.5],
        y = [.5, .5, .5, 1.5, 1.5, 1.5, 2.5, 2.5, 2.5],
        mode = "markers",
        marker=attr(size=100, color=colorant"rgb(229,236,246)"),
        scrollZoom = false,
        staticPlot = true,
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

on(p["click"]) do data
    color_vec = (fill("red", 10), fill("blue", 10))
    for i in d
        color_vec[i[1]][i[2]] = "gold"
    end
    symbols = (fill("circle", 10), fill("circle", 10))
    for point in data["points"]
        color_vec[point["curveNumber"] + 1][point["pointIndex"] + 1] = "gold"
        push!(d, (point["curveNumber"] + 1,point["pointIndex"] + 1) )
        symbols[point["curveNumber"] + 1][point["pointIndex"] + 1] = "X"
    end
    restyle!(p, marker_color=color_vec, marker_symbol=symbols)
    end
    

PlotlyJS.display_blink(p)
