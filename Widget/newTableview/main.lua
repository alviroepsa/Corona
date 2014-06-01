-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local widget = require( "widget" )

local function touchListener(event)
    if event.phase == "press" then
        print(event.row.index)
    end
end

local function renderListener(event)
        display.newText(event.row, event.row.index, 20,20,nil,20)
end

local tableView = widget.newTableView
{
    left = 0,
    top = 0,
    height = display.contentHeight,
    width =  display.contentWidth,
    onRowRender = renderListener,
    onRowTouch = touchListener,
 
}

for i = 1,100 do
    tableView:insertRow(
        {
            rowHeight = 50,
            rowColor = { default={ (i+1)/255, (i+1)/255, (i+1)/255 } },
        }
    )
end