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
  = Increment Int
  | Decrement Int
  | Reset


increaser : Int -> Model -> Model
increaser n model = model + n

decreaser : Int -> Model -> Model
decreaser n model = model - n

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment n -> increaser n model

    Decrement n -> decreaser n model

    Reset -> initialValue

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [
      div [] [ text (String.fromInt model) ]
    , button [ onClick (Decrement 10) ] [ text "minus 10" ]
    , button [ onClick (Decrement 1) ] [ text "minus" ]
    , button [ onClick (Increment 1) ] [ text "plus" ]
    , button [ onClick (Increment 10) ] [ text "plus 10" ]
    , div []
        [
            button [ onClick Reset ] [ text "reset" ]
        ]
    ]
