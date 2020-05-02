module Main exposing (main)

import Browser
import Html exposing (Html, Attribute, div, span, label, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  {
    celsius : Float
  , fahrenheit : Float
  , inches : Float
  , meters : Float
  }


init : Model
init =
  {
    celsius = 0
  , fahrenheit = 0
  , inches = 0
  , meters = 0
  }



-- UPDATE


type Msg
  = Celsius String
  | Fahrenheit String
  | Inches String
  | Meters String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Celsius newInput ->
      { model | celsius = (String.toFloat newInput), fahrenheit = toFahrenheit (String.toFloat newInput) }

toFahrenheit : Float -> Float
toFahrenheit n =
  n * 1.8 + 32

toCelsius : Float -> Float
toCelsius n =
  n / 1.8 - 32

toMeters : Float -> Float
toMeters n =
  n / 39.37

toInches : Float -> Float
toInches m =
  m * 39.37

-- VIEW

-- add Error border around the input if its wrong ✓
-- add Fahrenheit to Celsius
-- add Inches to Meters

view : Model -> Html Msg
view model =
  Html.div [] [
    text model.input
  , Html.ul
      []
      [
        Html.li
          []
          [
            label
            []
            [
              text "Celcius to Fahrenheit"
            , styleInput
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
            , styleInput
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
            , styleInput
            ]
          , span [] [ text "Result"]
          ]
      ]
  ]


styleInput : (String -> msg) -> Html Msg
styleInput f =
  input [
          type_ "number"
        , style "width" "40px"
        , style "margin-left" "1em"
        , onInput f
        ] []

-- #region old
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
-- #endregion


-- viewAttrConverter attr =
