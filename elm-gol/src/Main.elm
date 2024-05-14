module Main exposing (main)

import Board
import Browser
import Browser.Events
import Json.Decode as Decode
import Model exposing (Model)
import Shapes exposing (Shape(..))
import Time
import Update exposing (Msg(..))
import View


init : Model
init =
    { board = Board.init
    , running = False
    , drawing = False
    , shape = Cell
    }


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> ( init, Cmd.none )
        , view = View.view
        , update = Update.update
        , subscriptions =
            \_ ->
                Sub.batch
                    [ Browser.Events.onMouseDown (Decode.succeed <| SetDrawing True)
                    , Browser.Events.onMouseUp (Decode.succeed <| SetDrawing False)

                    -- , Browser.Events.onAnimationFrame (always Tick)
                    , Time.every 200 (always Tick)
                    ]
        }
