module Main exposing (main)

import Browser
import Html exposing (Html, Attribute, span, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { input : String
  -- , error : Bool
  }


init : Model
init =
  { input = "" }



-- UPDATE


type Msg
  = Change String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newInput ->
      { model | input = newInput }



-- VIEW


view : Model -> Html Msg
view model =
  case String.toFloat model.input of
    Just celsius ->
      viewConverter model.input False "blue" (String.fromFloat (celsius * 1.8 + 32))

    Nothing ->
      -- span []
      --   [
      --     input [ value model.input, style "border" "1px solid red" ] []
      --   ]
      viewConverter model.input True "red" "???"


viewConverter : String -> Bool -> String -> String -> Html Msg
viewConverter userInput isError color equivalentTemp =
  span []
    [ input [ value userInput, onInput Change, style "width" "40px", style "border" (if isError then "1px solid " ++ color else "none") ] []
    , text "°C = "
    , span [ style "color" color ] [ text equivalentTemp ], text "°F"
    ]

-- viewAttrConverter attr =
