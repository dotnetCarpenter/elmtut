module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model = Int

init : Model
init = 0

-- UPDATE

type Msg
  = Increment
  | Decrement
  | Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
      0

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "minus" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "plus" ]
    , button [ onClick Reset ] [ text "reset" ]
    ]
