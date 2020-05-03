module Main exposing (main)

import Browser
import Html exposing (Html, div, span, input, text)
import Html.Attributes exposing (value, style, placeholder, type_)
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
  , error : String
  }

type alias Model =
  { celsius: ConversionValue
  , fahrenheit: ConversionValue
  , meters: ConversionValue
  , inches: ConversionValue
  }

initialValue : ConversionValue
initialValue = { input = ""
               , output = 0.0
               , error = "" }

init : Model
init =
  { celsius = initialValue
  , fahrenheit = initialValue
  , meters = initialValue
  , inches = initialValue
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
  | Meters String
  | Inches String

type Error
  = BadConversion

convertToFloat : String -> Float
convertToFloat v =
  Maybe.withDefault 0.0 (String.toFloat v)

updateValidation : String -> Result Error Float
updateValidation maybe =
  case String.toFloat maybe of
    Nothing ->
      Err BadConversion

    Just v ->
      Ok v

update : Msg -> Model -> Model
update msg model =
  case msg of
    Celsius value ->
      let
        result = updateValidation value
      in
        if result == Err BadConversion then
          { model | celsius = ConversionValue value 0.0 "Not a Float" }
        else {- if result == Ok value then -}
          { model | celsius = ConversionValue value (toFahrenheit (convertToFloat value)) "" }
      -- \c -> case String.toFloat c of
      --         Nothing ->
      --           { model | celsius = ConversionValue value 0.0 "Not a Float" }
      --         Just v ->
      --           { model | celsius = ConversionValue value (toFahrenheit v) "" }

    Fahrenheit v ->
      { model | fahrenheit = ConversionValue v (toCelsius (convertToFloat v)) "" }

    Meters v ->
      { model | meters = ConversionValue v (toInches (convertToFloat v)) "" }

    Inches v ->
      { model | inches = ConversionValue v (toMeters (convertToFloat v)) "" }


-- VIEW


view : Model -> Html Msg
view model =
  div [] [
    Html.form [] (viewConverter model.celsius Celsius "Celsius" "°F")
  , Html.form [] (viewConverter model.fahrenheit Fahrenheit "Fahrenheit" "°C")
  , Html.form [] (viewConverter model.meters Meters "Meters" "“")
  , Html.form [] (viewConverter model.inches Inches "Inches" "m")
  , Html.form [] [ text (Debug.toString model) ]
  ]

viewConverter : ConversionValue -> (String -> msg) -> String -> String -> List (Html msg)
viewConverter value msg p convertSymbol =
  [ viewInput "text" value.input p msg
    , span []
    [ text " = "
    , span [] [ text (Round.round 2 value.output)
    ]
    , text convertSymbol
    ]
  ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t v p toMsg =
  input [type_ t
  , value v
  , placeholder p
  , onInput toMsg
  , style "width" "6em" ] []

