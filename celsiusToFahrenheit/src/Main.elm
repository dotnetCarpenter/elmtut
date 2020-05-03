module Main exposing (main)

import Browser
import Html exposing (Html, Attribute, div, span, input, text)
import Html.Attributes exposing (value, style, placeholder, type_, title, autofocus)
import Html.Events exposing (onInput)
import Round
-- import Json.Encode as Encode

-- import Debug

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
      if updateValidation value == Err BadConversion then
        { model | celsius = ConversionValue value 0.0 (value ++ " is not a Float") }
      else
        { model | celsius = ConversionValue value (toFahrenheit (convertToFloat value)) "" }


    Fahrenheit value ->
      if updateValidation value == Err BadConversion then
        { model | fahrenheit = ConversionValue value 0.0 (value ++ " is not a Float") }
      else
        { model | fahrenheit = ConversionValue value (toCelsius (convertToFloat value)) "" }


    Meters value ->
      if updateValidation value == Err BadConversion then
        { model | meters = ConversionValue value 0.0 (value ++ " is not a Float") }
      else
        { model | meters = ConversionValue value (toInches (convertToFloat value)) "" }


    Inches value ->
      if updateValidation value == Err BadConversion then
        { model | inches = ConversionValue value 0.0 (value ++ " is not a Float") }
      else
        { model | inches = ConversionValue value (toMeters (convertToFloat value)) "" }



-- VIEW

-- add Error border around the input if its wrong ✓
-- add Fahrenheit to Celsius ✓
-- add Celsius to Fahrenheit ✓
-- add Inches to Meters ✓
-- add Meters to Inches ✓

view : Model -> Html Msg
view model =
  div [] [
    Html.form [] (viewConverter model.celsius Celsius "Celsius" "°F" True)
  , Html.form [] (viewConverter model.fahrenheit Fahrenheit "Fahrenheit" "°C" False)
  , Html.form [] (viewConverter model.meters Meters "Meters" "“" False)
  , Html.form [] (viewConverter model.inches Inches "Inches" "m" False)
  -- , Html.form [] [ text (Debug.toString model) ]
  ]

viewConverter : ConversionValue -> (String -> msg) -> String -> String -> Bool -> List (Html msg)
viewConverter value msg placeholder convertSymbol autofocus =
  [ viewInput "text" value.input value.error placeholder autofocus msg
    , span []
    [ text "= "
    , span [] [ text (Round.round 2 value.output)
    ]
    , text convertSymbol
    ]
  ]

viewInput : String -> String -> String -> String -> Bool -> (String -> msg) -> Html msg
viewInput t v e p auto toMsg =
  input
    (List.append [
      type_ t
    , value v
    , placeholder p
    , autofocus auto
    , onInput toMsg
    -- , Html.Attributes.property "setCustomValidity" (Encode.string e)
    , style "width" "6em"
    , style "margin" "1em 1em 0" ]

      (viewInputError e)
    )
  []

viewInputError : String -> List (Attribute msg)
viewInputError errMsg =
  if String.length errMsg > 0 then
    [ style "border-color" "red"
    , title errMsg
    ]
  else
    [ style "border-color" "unset" ]
