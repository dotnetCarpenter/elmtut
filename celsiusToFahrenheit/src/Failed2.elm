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
  , fahrenheit: Maybe Float
  , celsius: Maybe Float
  , inches: Maybe Float
  , meters: Maybe Float
  }


init : Model
init =
  { input = ""
  , fahrenheit = Nothing
  , celsius = Nothing
  , inches = Nothing
  , meters = Nothing
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


update : Msg -> Model -> Model
update msg model =
  case msg of
    Celsius newInput ->
      case String.toFloat newInput of
        Just float ->
          { model | fahrenheit = Just (toFahrenheit float), celsius = Just float }

        Nothing ->
          { model | input = newInput }



-- VIEW


view : Model -> Html Msg
view model =
  case String.toFloat model.input of
    Just celsius ->
      viewConverter celsius "blue"

    Nothing ->
      viewError 0 "red" "???"

viewInput v msg =
  input [ value v, onInput msg, style "width" "40px" ] []

viewConverter : Float -> String -> Html Msg
viewConverter input color =
  span []
    [ viewInput input Celsius
    , text "°C = "
    , span [ style "color" color ] [ text (String.fromFloat Maybe.withDefault 0 model.fahrenheit) ]
    , text "°F"
    ]

viewError : Float -> String -> String -> Html Msg
viewError celsius color t =
  span []
    [ viewInput celsius Celsius
    , text "°C = "
    , span [ style "color" color ] [ text t ]
    , text "°F"
    ]
