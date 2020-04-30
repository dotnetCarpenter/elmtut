module Main exposing (main)

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
initialValue = 0

type alias Model = Int

init : Model
init = initialValue

-- UPDATE

type Msg
  = Change Int
  | Reset


change : Int -> Model -> Model
change n model = model + n

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change n -> change n model

    Reset -> initialValue

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [
      div [] [ text (String.fromInt model) ]
    , button [ onClick (Change -10) ] [ text "minus 10" ]
    , button [ onClick (Change -1) ] [ text "minus" ]
    , button [ onClick (Change 1) ] [ text "plus" ]
    , button [ onClick (Change 10) ] [ text "plus 10" ]
    , div []
        [
            button [ onClick Reset ] [ text "reset" ]
        ]
    ]
