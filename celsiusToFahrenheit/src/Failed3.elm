module Main exposing (main)

import Browser
import Html exposing (Html, div, span, input, text)
import Html.Attributes exposing (value, placeholder, style, type_)
import Html.Events exposing (onInput)

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
  { fahrenheit: ConversionValue
  , celsius: ConversionValue
  , inches: ConversionValue
  , meters: ConversionValue
  }

initalValue : ConversionValue
initalValue = { input = "", output = 0.0 }

init : Model
init =
  { fahrenheit = initalValue
  , celsius = initalValue
  , inches = initalValue
  , meters = initalValue
  }


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


-- UPDATE


type Msg
  = Celsius String
  | Fahrenheit String


debugMsg : a -> b -> a
debugMsg o msg = o |> Debug.log (Debug.toString msg)

debug : a -> a
debug o = o |> Debug.log (Debug.toString o)



updateInput : ConversionValue -> String -> ConversionValue
updateInput slice input =
  { slice | input = input }

updateOutput : ConversionValue -> Float -> ConversionValue
updateOutput slice output =
  { slice | output = output }


updateConversion : Model -> ConversionValue -> Model
updateConversion model value =
  case String.toFloat value.input of
    Just float ->
      { model | fahrenheit = updateOutput model.fahrenheit (toFahrenheit float) }

    Nothing ->
      model

update : Msg -> Model -> Model
update msg model =
  case msg of
    Celsius newInput ->
      updateConversion
        { model | celsius = updateInput model.celsius newInput, fahrenheit = updateOutput model.fahrenheit (Maybe.withDefault 0 (String.toFloat newInput))  }
        model.celsius
      -- updateConversion msg { model.celsius | input = newInput }
      -- debug model newInput

    Fahrenheit _ -> Debug.todo "Not implemented"
  -- case msg of
  --   Celsius newInput ->
  --     case String.toFloat newInput of
  --       Just float ->
  --         { model | input = newInput, fahrenheit | output = toFahrenheit float, celsius = float }

  --       Nothing ->
  --         { model | input = newInput }


  --   Fahrenheit newInput ->
  --     case String.toFloat newInput of
  --       Just float ->
  --         { model | input = newInput, fahrenheit = float, celsius = toCelsius float }

  --       Nothing ->
  --         { model | input = newInput }


-- VIEW


view : Model -> Html Msg
view model =
  div [] [
    div [] [ text (Debug.toString model) ]
  , div [] (viewConverter model.celsius Celsius "°C")
  , div [] (viewConverter model.fahrenheit Fahrenheit "°F")
  ]

viewConverter : ConversionValue -> (String -> msg) -> String -> List (Html msg)
viewConverter model msg s =
  [ viewInput "text" model.input msg
    , span []
    [ text (s ++ " = ")
      , text (String.fromFloat model.output)
    ]
  ]

viewInput : String -> String -> (String -> msg) -> Html msg
viewInput t v toMsg =
  input [type_ t
  , value v
  , onInput toMsg
  , style "width" "6em" ] []

