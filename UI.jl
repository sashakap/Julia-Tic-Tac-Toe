using PlotlyJS, WebIO, Blink, Images, Colors


function makeBoard()
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
    p
end

function makeGrid(plot)
    add_shape!(p, line(
        x0=0, y0=1,
        x1=3, y1=1,
        line=attr(color="Black", width=5),
    )), 

    add_shape!(p, line(
        x0=0, y0=2,
        x1=3, y1=2,
        line=attr(color="Black", width=5),
    )), 

    add_shape!(p, line(
        x0=2, y0=3,
        x1=2, y1=0,
        line=attr(color="Black", width=5),
    )), 

    add_shape!(p, line(
        x0=1, y0=3,
        x1=1, y1=0,
        line=attr(color="Black", width=5),
    ))

end
