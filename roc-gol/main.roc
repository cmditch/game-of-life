app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.10.0/vNe6s9hWzoTZtFmNkvEICPErI9ptji_ySjicO6CkucY.tar.br",
    ansi: "https://github.com/lukewilliamboswell/roc-ansi/releases/download/0.5/1JOFFXrqOrdoINq6C4OJ8k3UK0TJhgITLbcOb-6WMwY.tar.br",
}

import pf.Stdout
import pf.Stdin
import pf.Task exposing [Task]
import pf.Sleep
import pf.Tty
import ansi.Core

ScreenInfo : { cursor : Core.Position, screen : Core.ScreenSize }

main =
    Tty.enableRawMode!
    setTerminalBuffer! Bool.true
    terminalSize = getTerminalSize!
    screenInfo = { cursor: { row: 0, col: 0 }, screen: terminalSize }
    initBoardSize = { width: Num.toU64 terminalSize.width, height: Num.toU64 terminalSize.height }
    _ = Task.loop! (init initBoardSize) (\board -> gameLoop screenInfo board)
    setTerminalBuffer! Bool.false
    Tty.disableRawMode!
    Task.ok {}

gameLoop : ScreenInfo, Board -> Task.Task _ _
gameLoop = \screenInfo, board ->
    drawBoard! board
    Sleep.millis! 200
    boardSize = { width: Num.toU64 screenInfo.screen.width, height: Num.toU64 screenInfo.screen.height }
    nextBoard = next boardSize board
    Task.ok (Step nextBoard)

# -----
# Board
# -----

pulsar : List RelativeCoord
pulsar = [
    { x: 2, y: 0 },
    { x: 3, y: 0 },
    { x: 4, y: 0 },
    { x: 8, y: 0 },
    { x: 9, y: 0 },
    { x: 10, y: 0 },
    { x: 0, y: 2 },
    { x: 5, y: 2 },
    { x: 7, y: 2 },
    { x: 12, y: 2 },
    { x: 0, y: 3 },
    { x: 5, y: 3 },
    { x: 7, y: 3 },
    { x: 12, y: 3 },
    { x: 0, y: 4 },
    { x: 5, y: 4 },
    { x: 7, y: 4 },
    { x: 12, y: 4 },
    { x: 2, y: 5 },
    { x: 3, y: 5 },
    { x: 4, y: 5 },
    { x: 8, y: 5 },
    { x: 9, y: 5 },
    { x: 10, y: 5 },
    { x: 2, y: 7 },
    { x: 3, y: 7 },
    { x: 4, y: 7 },
    { x: 8, y: 7 },
    { x: 9, y: 7 },
    { x: 10, y: 7 },
    { x: 0, y: 8 },
    { x: 5, y: 8 },
    { x: 7, y: 8 },
    { x: 12, y: 8 },
    { x: 0, y: 9 },
    { x: 5, y: 9 },
    { x: 7, y: 9 },
    { x: 12, y: 9 },
    { x: 0, y: 10 },
    { x: 5, y: 10 },
    { x: 7, y: 10 },
    { x: 12, y: 10 },
    { x: 2, y: 12 },
    { x: 3, y: 12 },
    { x: 4, y: 12 },
    { x: 8, y: 12 },
    { x: 9, y: 12 },
    { x: 10, y: 12 },
]

glider : List RelativeCoord
glider = [
    { x: 1, y: 0 },
    { x: 2, y: 1 },
    { x: 0, y: 2 },
    { x: 1, y: 2 },
    { x: 2, y: 2 },
]

Board : List (List Bool)
BoardSize : { width : U64, height : U64 }
Coord : { x : U64, y : U64 }
RelativeCoord : { x : I16, y : I16 }

init : BoardSize -> Board
init = \boardSize ->
    row = List.repeat Bool.false boardSize.width
    board = List.repeat row boardSize.height
    withPulsar = add { x: 15, y: 15 } pulsar
    withGlider = add { x: 30, y: 30 } glider
    board
    |> mark withPulsar
    |> mark withGlider

next : BoardSize, Board -> Board
next = \boardSize, board ->
    List.mapWithIndex
        board
        (\row, rowNum ->
            List.mapWithIndex
                row
                (\cell, colNum ->
                    nextCellState boardSize board { x: rowNum, y: colNum } cell
                )
        )

isInBounds : BoardSize, Coord -> Bool
isInBounds = \boardSize, { x, y } ->
    x >= 0 && x <= boardSize.width && y >= 0 && y <= boardSize.height

mark : Board, List Coord -> Board
mark = \board, coords ->
    List.walk coords board (\acc, coord -> markCell acc coord)

markCell : Board, Coord -> Board
markCell = \board, coord ->
    when List.get board coord.y is
        Ok row ->
            newRow = List.set row coord.x Bool.true
            List.set board coord.y newRow

        Err _ ->
            board

add : Coord, List RelativeCoord -> List Coord
add = \actual, pattern ->
    List.map
        pattern
        (\rel -> {
            x: Num.toU64 (rel.x + Num.toI16 actual.x),
            y: Num.toU64 (rel.y + Num.toI16 actual.y),
        })

# Private

nextCellState : BoardSize, Board, Coord, Bool -> Bool
nextCellState = \boardSize, board, cellCoord, cellState ->
    a = add cellCoord adjacentCells
    b = List.keepIf a (\coord -> isInBounds boardSize coord)
    c = List.map
        b
        (\{ x, y } -> List.get board y
            |> Result.try (\row -> List.get row x)
            |> Result.withDefault Bool.false
        )

    List.keepIf c (\v -> v)
    |> List.len
    |> (\len -> nextCellStateHelp cellState len)

# Relative coordinates of the 8 cells surrounding a cell.
adjacentCells : List RelativeCoord
adjacentCells = [
    { x: -1, y: -1 }, # Top left
    { x: 0, y: -1 }, # Top center
    { x: 1, y: -1 }, # Top right
    { x: -1, y: 0 }, # Middle left
    { x: 1, y: 0 }, # Middle right
    { x: -1, y: 1 }, # Bottom left
    { x: 0, y: 1 }, # Bottom center
    { x: 1, y: 1 }, # Bottom right
]

# {-| Rules:

#  - Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
#  - Any live cell with two or three live neighbours lives on to the next generation.
#  - Any live cell with more than three live neighbours dies, as if by overpopulation.
#  - Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

# -}
nextCellStateHelp : Bool, U64 -> Bool
nextCellStateHelp = \cellState, liveNeighbors ->
    (cellState && (liveNeighbors == 2 || liveNeighbors == 3)) || (Bool.not cellState && liveNeighbors == 3)

# ----
# UI
# ----

getTerminalSize : Task.Task Core.ScreenSize _
getTerminalSize =
    # Move the cursor to bottom right corner of terminal
    cmd =
        [MoveCursor (To { row: 999, col: 999 }), GetCursor]
        |> List.map Control
        |> List.map Core.toStr
        |> Str.joinWith ""
    Stdout.write! cmd
    # Read the cursor position
    Stdin.bytes
        |> Task.map Core.parseCursor
        |> Task.map! \{ row, col } -> { width: col, height: row }

setTerminalBuffer : Bool -> Task.Task _ _
setTerminalBuffer = \enable ->
    if
        enable
    then
        Stdout.write! "\u(001b)[?1049h"
    else
        Stdout.write! "\u(001b)[?1049l"

drawBoard : Board -> Task.Task _ _
drawBoard = \board ->
    # Reset screen
    Stdout.write! "\u(001b)[2J"
    List.map
        board
        (\row ->
            List.map row (\cellState -> (if cellState then "█" else " "))
            |> Str.joinWith ""
        )
        |> Str.joinWith "\n"
        |> Stdout.write!
