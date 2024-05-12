module Update exposing (..)

import Board
import Dict
import Model exposing (Model)
import Shapes exposing (Shape)


type Msg
    = Start
    | Stop
    | Clear
    | UseShape Shape
    | Mark ( Int, Int )
    | SetDrawing Bool
    | Tick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            ( { model | running = True }
            , Cmd.none
            )

        Stop ->
            ( { model | running = False }
            , Cmd.none
            )

        Clear ->
            ( { model | board = Board.init }
            , Cmd.none
            )

        UseShape shape ->
            ( { model | shape = shape }
            , Cmd.none
            )

        Mark coords ->
            let
                newBoard =
                    Dict.get (Shapes.shapeToString model.shape) Shapes.shapeCoords
                        |> Maybe.withDefault []
                        |> Board.add coords
                        |> List.filter Board.isInBounds
                        |> Board.mark model.board
            in
            ( { model | board = newBoard }
            , Cmd.none
            )

        SetDrawing isDrawing ->
            ( { model | drawing = isDrawing }
            , Cmd.none
            )

        Tick ->
            ( if model.running then
                { model | board = Board.next model.board }

              else
                model
            , Cmd.none
            )
