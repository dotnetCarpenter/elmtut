module Main exposing (main)

import Browser
import Html exposing (Html, Attribute, div, span, label, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL
-- type
type Attr = Attribute
type alias Model =
  {
    input : String
  , style : List Attr
  -- , error : Bool
  }


init : Model
init =
  { input = ""
  , style = [
      type_ "number"
    , style "width" "40px"
    , style "margin-left" "1em"
    ]
  }



-- UPDATE


type Msg
  = Change String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newInput ->
      { model | input = newInput }

toFahrenheit : Float -> String
toFahrenheit n =
  String.fromFloat (n * 1.8 + 32)

toCelsius : Float -> String
toCelsius n =
  String.fromFloat (n / 1.8 - 32)

toMeters : Float -> String
toMeters n =
  String.fromFloat (n / 39.37)

toInches : Float -> String
toInches m =
  String.fromFloat (m * 39.37)

-- VIEW

-- add Error border around the input if its wrong ✓
-- add Fahrenheit to Celsius
-- add Inches to Meters

view : Model -> Html Msg
view model =
  Html.ul
    []
    [
      Html.li
        []
        [
          label
          []
          [
            text "Celcius to Fahrenheit"
          , input
            [
              type_ "number"
            , style "width" "40px"
            , style "margin-left" "1em"
            ]
            []
          ]
        , span [] [ text "Result"]
        ]
      , Html.li
        []
        [
          label
          []
          [
            text "Fahrenheit to Celcius"
          , input
            [
              type_ "number"
            , style "width" "40px"
            , style "margin-left" "1em"
            ]
            []
          ]
        , span [] [ text "Result"]
        ]
      , Html.li
        []
        [
          label
          []
          [
            text "Inches to Meters"
          , input
            [
              type_ "number"
            , style "width" "40px"
            , style "margin-left" "1em"
            ]
            []
          ]
        , span [] [ text "Result"]
        ]
    ]

    -- , div [] [ viewConverter model.input False "blue" (toFahrenheit (Maybe.withDefault 0 String.toFloat model.input)) ]
-- view model =
--   case String.toFloat model.input of
--     Just celsius ->
--       viewConverter model.input False "blue" (toFahrenheit celsius)

--     Nothing ->
--       -- span []
--       --   [
--       --     input [ value model.input, style "border" "1px solid red" ] []
--       --   ]
--       viewConverter model.input True "red" "???"

-- viewConvertion id =
--   case id of
--     "ctof" -> viewConverter

-- viewConverter : String -> Bool -> String -> String -> Html Msg
-- viewConverter userInput isError color equivalentTemp =
--   case String.toFloat model.input of
--       option1 ->


--       option2 ->


--   span []
--     [ input [
--       value userInput
--     , onInput Change
--     , style "width" "40px"
--     , style "border" (if isError then "1px solid " ++ color else "none")
--     , autofocus True
--     ] []
--     , text "°C = "
--     , span [ style "color" color ] [ text equivalentTemp ], text "°F"
--     ]

-- viewAttrConverter attr =
