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
  | Increment10
  | Decrement10

increaser : Model -> Int -> Model
increaser model n = model + n

decreaser : Model -> Int -> Model
decreaser model n = model - n

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment -> increaser model 1

    Increment10 -> increaser model 10

    Decrement -> model - 1

    Decrement10 -> decreaser model 10

    Reset -> 0

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [
      div [] [ text (String.fromInt model) ]
    , button [ onClick Decrement10 ] [ text "minus 10" ]
    , button [ onClick Decrement ] [ text "minus" ]
    , button [ onClick Increment ] [ text "plus" ]
    , button [ onClick Increment10 ] [ text "plus 10" ]
    , div []
        [
            button [ onClick Reset ] [ text "reset" ]
        ]
    ]
