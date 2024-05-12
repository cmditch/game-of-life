module Model exposing (..)

import Board exposing (Board)
import Shapes exposing (Shape)


type alias Model =
    { board : Board
    , running : Bool
    , drawing : Bool
    , shape : Shape
    }
