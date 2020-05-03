module Main exposing (main)

import Browser
import Html exposing (Html, div, span, input, text)
import Html.Attributes exposing (value, style, type_)
import Html.Events exposing (onInput)
import Round

import Debug

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL

type alias ConversionValue =
  { input : String
  , output : Float
  }

type alias Model =
  { celsius: ConversionValue
  , meters: ConversionValue
  }

initialValue : ConversionValue
initialValue = { input = "", output = 0.0 }

init : Model
init =
  { celsius = initialValue
  , meters = initialValue
  }


toFahrenheit : Float -> Float
toFahrenheit n =
  n * 1.8 + 32

toCelsius : Float -> Float
toCelsius n =
  (n - 32) / 1.8

toMeters : Float -> Float
toMeters n =
  n / 39.37

toInches : Float -> Float
toInches m =
  m * 39.37


-- UPDATE


type Msg
  = Celsius String
  | Fahrenheit String


convertToFloat : String -> Float
convertToFloat v =
  Maybe.withDefault 0.0 (String.toFloat v)

updateInput : ConversionValue -> String -> ConversionValue
updateInput slice value =
  { slice | input = value }

updateOutput : ConversionValue -> Float -> ConversionValue
updateOutput slice value =
  { slice | output = value }

update : Msg -> Model -> Model
update msg model =
  case msg of
    Celsius v ->
      { model |
        celsius = updateInput model.celsius v
      , celsius = updateOutput model.celsius toFahrenheit (convertToFloat v)
      }

    Fahrenheit v ->
      { model |
        celsius = updateOutput model.celsius (toCelsius (convertToFloat v))
      }



-- VIEW


view : Model -> Html Msg
view model =
  div [] [
    div [] (viewConverter model.celsius Celsius "°C")
  , div [] (viewConverter model.fahrenheit Fahrenheit "°F")
  , div [] [ text (Debug.toString model) ]
  ]

viewConverter : ConversionValue -> (String -> msg) -> String -> List (Html msg)
viewConverter value msg symbol =
  [ viewInput "text" value.input msg
    , span []
    [ text (symbol ++ " = ")
      , text (Round.round 2 value.output)
    ]
  ]

viewInput : String -> String -> (String -> msg) -> Html msg
viewInput t v toMsg =
  input [type_ t
  , value v
  , onInput toMsg
  , style "width" "6em" ] []

