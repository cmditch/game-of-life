module View exposing (..)

import Board
import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (attribute)
import Html.Events
import Html.Lazy
import Matrix
import Model exposing (Model)
import Shapes exposing (Shape(..))
import Update exposing (Msg(..))


view : Model -> Browser.Document Msg
view model =
    { title = "Game of Life"
    , body = [ Html.Lazy.lazy viewBody model ]
    }


viewBody : Model -> Html Msg
viewBody model =
    div
        [ attribute "width" "100%"
        , attribute "height" "100%"
        ]
        [ Html.node "style" [] [ Html.text styleSheet ]
        , viewMatrix model.drawing (Matrix.toIndexedList model.board)
        , viewShapes
        , viewButtons
        ]


viewMatrix : Bool -> List ( ( Int, Int ), Bool ) -> Html Msg
viewMatrix drawing matrixList =
    div [ Html.Attributes.class "grid-container" ]
        (List.map (viewCell drawing) matrixList)


viewShapes : Html Msg
viewShapes =
    div [] (List.map viewShape Shapes.shapes)


viewShape : Shape -> Html Msg
viewShape shape =
    button
        [ Html.Events.onClick (UseShape shape) ]
        [ text (Shapes.shapeToString shape) ]


viewButtons : Html Msg
viewButtons =
    div
        []
        [ button [ Html.Events.onClick Start ] [ text "Start" ]
        , button [ Html.Events.onClick Stop ] [ text "Stop" ]
        , button [ Html.Events.onClick Clear ] [ text "Clear" ]
        ]


viewCell : Bool -> ( ( Int, Int ), Bool ) -> Html Msg
viewCell drawing ( ( x, y ), cellState ) =
    div
        [ Html.Events.onMouseDown (Mark ( x, y ))
        , if drawing then
            Html.Events.onMouseEnter (Mark ( x, y ))

          else
            Html.Attributes.class ""
        , Html.Attributes.class
            (if cellState then
                "active"

             else
                ""
            )
        ]
        []


styleSheet : String
styleSheet =
    let
        gridColumnSettings =
            Board.size
                |> Tuple.first
                |> (\x -> List.repeat x "7px")
                |> String.join " "
    in
    """
    body {
        margin: 0;
        padding: 0;
        background-color: #333;
    }

    .grid-container {
        display: grid;
        grid-template-columns: """ ++ gridColumnSettings ++ """;
    }

    .grid-container > div {
        height: 7px;
        width: 7px;
        border: 1px solid #111;
        background-color: #000;
    }

    .grid-container > .active {
        background-color: #fff;
    }
    """
