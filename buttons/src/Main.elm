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
initialValue: Int
initialValue = 100

type alias Model = Int

init : Model
init = initialValue

-- UPDATE

type Msg
  = Increment
  | Decrement
  | Reset
  | Increment10
  | Decrement10


increaser : Int -> Model -> Model
increaser n model = model + n

decreaser : Int -> Model -> Model
decreaser n model = model - n

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment  -> increaser 1 model

    Increment10 -> increaser 10 model

    Decrement -> decreaser 1 model

    Decrement10 -> decreaser 10 model

    Reset -> initialValue

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
