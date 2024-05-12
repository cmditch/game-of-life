module Shapes exposing (..)

import Dict exposing (Dict)


shapes : List Shape
shapes =
    [ Block
    , Beehive
    , Loaf
    , Boat
    , Tub
    , Blinker
    , Toad
    , Beacon
    , Pulsar
    , Pentadecathlon
    , Glider
    , LWSS
    , MWSS
    , RPentomino
    , Diehard
    , Acorn
    ]


type Shape
    = Cell
    | Block
    | Beehive
    | Loaf
    | Boat
    | Tub
    | Blinker
    | Toad
    | Beacon
    | Pulsar
    | Pentadecathlon
    | Glider
    | LWSS
    | MWSS
    | RPentomino
    | Diehard
    | Acorn


shapeToString : Shape -> String
shapeToString shape =
    case shape of
        Cell ->
            "Cell"

        Block ->
            "Block"

        Beehive ->
            "Beehive"

        Loaf ->
            "Loaf"

        Boat ->
            "Boat"

        Tub ->
            "Tub"

        Blinker ->
            "Blinker"

        Toad ->
            "Toad"

        Beacon ->
            "Beacon"

        Pulsar ->
            "Pulsar"

        Pentadecathlon ->
            "Pentadecathlon"

        Glider ->
            "Glider"

        LWSS ->
            "LWSS"

        MWSS ->
            "MWSS"

        RPentomino ->
            "RPentomino"

        Diehard ->
            "Diehard"

        Acorn ->
            "Acorn"


shapeCoords : Dict String (List ( Int, Int ))
shapeCoords =
    [ ( "Cell"
      , [ ( 0, 0 )
        ]
      )
    , ( "Block"
      , [ ( 0, 0 )
        , ( 1, 0 )
        , ( 0, 1 )
        , ( 1, 1 )
        ]
      )
    , ( "Beehive"
      , [ ( 1, 0 )
        , ( 2, 0 )
        , ( 0, 1 )
        , ( 3, 1 )
        , ( 1, 2 )
        , ( 2, 2 )
        ]
      )
    , ( "Loaf"
      , [ ( 1, 0 )
        , ( 2, 0 )
        , ( 0, 1 )
        , ( 3, 1 )
        , ( 1, 2 )
        , ( 3, 2 )
        , ( 2, 3 )
        ]
      )
    , ( "Boat"
      , [ ( 0, 0 )
        , ( 1, 0 )
        , ( 0, 1 )
        , ( 2, 1 )
        , ( 1, 2 )
        ]
      )
    , ( "Tub"
      , [ ( 1, 0 )
        , ( 0, 1 )
        , ( 2, 1 )
        , ( 1, 2 )
        ]
      )
    , ( "Blinker"
      , [ ( 1, 0 )
        , ( 1, 1 )
        , ( 1, 2 )
        ]
      )
    , ( "Toad"
      , [ ( 1, 1 )
        , ( 2, 1 )
        , ( 3, 1 )
        , ( 0, 2 )
        , ( 1, 2 )
        , ( 2, 2 )
        ]
      )
    , ( "Beacon"
      , [ ( 0, 0 )
        , ( 1, 0 )
        , ( 0, 1 )
        , ( 3, 2 )
        , ( 2, 3 )
        , ( 3, 3 )
        ]
      )
    , ( "Pulsar"
      , [ ( 2, 0 )
        , ( 3, 0 )
        , ( 4, 0 )
        , ( 8, 0 )
        , ( 9, 0 )
        , ( 10, 0 )
        , ( 0, 2 )
        , ( 5, 2 )
        , ( 7, 2 )
        , ( 12, 2 )
        , ( 0, 3 )
        , ( 5, 3 )
        , ( 7, 3 )
        , ( 12, 3 )
        , ( 0, 4 )
        , ( 5, 4 )
        , ( 7, 4 )
        , ( 12, 4 )
        , ( 2, 5 )
        , ( 3, 5 )
        , ( 4, 5 )
        , ( 8, 5 )
        , ( 9, 5 )
        , ( 10, 5 )
        , ( 2, 7 )
        , ( 3, 7 )
        , ( 4, 7 )
        , ( 8, 7 )
        , ( 9, 7 )
        , ( 10, 7 )
        , ( 0, 8 )
        , ( 5, 8 )
        , ( 7, 8 )
        , ( 12, 8 )
        , ( 0, 9 )
        , ( 5, 9 )
        , ( 7, 9 )
        , ( 12, 9 )
        , ( 0, 10 )
        , ( 5, 10 )
        , ( 7, 10 )
        , ( 12, 10 )
        , ( 2, 12 )
        , ( 3, 12 )
        , ( 4, 12 )
        , ( 8, 12 )
        , ( 9, 12 )
        , ( 10, 12 )
        ]
      )
    , ( "Pentadecathlon"
      , [ ( 4, 0 )
        , ( 5, 0 )
        , ( 6, 0 )
        , ( 3, 1 )
        , ( 7, 1 )
        , ( 3, 2 )
        , ( 7, 2 )
        , ( 2, 3 )
        , ( 8, 3 )
        , ( 2, 4 )
        , ( 8, 4 )
        , ( 1, 5 )
        , ( 9, 5 )
        , ( 1, 6 )
        , ( 9, 6 )
        , ( 1, 7 )
        , ( 9, 7 )
        ]
      )
    , ( "Glider"
      , [ ( 1, 0 )
        , ( 2, 1 )
        , ( 0, 2 )
        , ( 1, 2 )
        , ( 2, 2 )
        ]
      )
    , ( "LWSS"
      , [ ( 0, 1 )
        , ( 3, 1 )
        , ( 4, 1 )
        , ( 0, 2 )
        , ( 4, 2 )
        , ( 1, 3 )
        , ( 2, 3 )
        , ( 4, 3 )
        , ( 1, 4 )
        , ( 2, 4 )
        ]
      )
    , ( "MWSS"
      , [ ( 3, 0 )
        , ( 4, 0 )
        , ( 0, 1 )
        , ( 5, 1 )
        , ( 0, 2 )
        , ( 5, 2 )
        , ( 0, 3 )
        , ( 5, 3 )
        , ( 1, 4 )
        , ( 2, 4 )
        , ( 3, 4 )
        , ( 4, 4 )
        , ( 1, 5 )
        , ( 4, 5 )
        ]
      )
    , ( "HWSS"
      , [ ( 0, 1 )
        , ( 1, 1 )
        , ( 5, 1 )
        , ( 6, 1 )
        , ( 0, 2 )
        , ( 6, 2 )
        , ( 2, 3 )
        , ( 3, 3 )
        , ( 4, 3 )
        , ( 6, 3 )
        , ( 2, 4 )
        , ( 3, 4 )
        , ( 4, 4 )
        , ( 2, 5 )
        ]
      )
    , ( "RPentomino"
      , [ ( 1, 0 )
        , ( 2, 0 )
        , ( 0, 1 )
        , ( 1, 1 )
        , ( 1, 2 )
        ]
      )
    , ( "Diehard"
      , [ ( 0, 1 )
        , ( 1, 1 )
        , ( 1, 2 )
        , ( 5, 2 )
        , ( 6, 2 )
        , ( 6, 3 )
        , ( 5, 4 )
        ]
      )
    , ( "Acorn"
      , [ ( 0, 1 )
        , ( 1, 3 )
        , ( 4, 3 )
        , ( 5, 3 )
        , ( 6, 3 )
        , ( 3, 4 )
        , ( 1, 5 )
        ]
      )
    ]
        |> Dict.fromList
