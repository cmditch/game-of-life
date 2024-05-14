module Board exposing (Board, add, init, isInBounds, mark, next, size)

import Matrix exposing (Matrix)



-- Public


type alias Board =
    Matrix Bool


init : Board
init =
    Matrix.initialize size (always False)


size : ( Int, Int )
size =
    ( 200, 90 )


next : Board -> Board
next board =
    Matrix.indexedMap (nextCellState board) board


isInBounds : ( Int, Int ) -> Bool
isInBounds ( x, y ) =
    let
        ( width, height ) =
            size
    in
    x >= 0 && x <= width && y >= 0 && y <= height


mark : Board -> List ( Int, Int ) -> Board
mark board coords =
    List.foldl (\coord acc -> Matrix.set coord True acc) board coords


add : ( Int, Int ) -> List ( Int, Int ) -> List ( Int, Int )
add ( xActual, yActual ) =
    List.map (\( x, y ) -> ( x + xActual, y + yActual ))



-- Private


nextCellState : Board -> ( Int, Int ) -> Bool -> Bool
nextCellState board cellCoords cellState =
    add cellCoords adjacentCells
        |> List.filter isInBounds
        |> List.map (\coords -> Matrix.get coords board |> Maybe.withDefault False)
        |> List.filter identity
        |> List.length
        |> nextCellStateHelp cellState


{-| Relative coordinates of the 8 cells surrounding a cell.
-}
adjacentCells : List ( Int, Int )
adjacentCells =
    [ ( -1, -1 ) -- Top left
    , ( 0, -1 ) -- Top center
    , ( 1, -1 ) -- Top right
    , ( -1, 0 ) -- Middle left
    , ( 1, 0 ) -- Middle right
    , ( -1, 1 ) -- Bottom left
    , ( 0, 1 ) -- Bottom center
    , ( 1, 1 ) -- Bottom right
    ]


{-| Rules:

  - Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  - Any live cell with two or three live neighbours lives on to the next generation.
  - Any live cell with more than three live neighbours dies, as if by overpopulation.
  - Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

-}
nextCellStateHelp : Bool -> Int -> Bool
nextCellStateHelp cellState liveNeighbors =
    (cellState && (liveNeighbors == 2 || liveNeighbors == 3)) || (not cellState && liveNeighbors == 3)
