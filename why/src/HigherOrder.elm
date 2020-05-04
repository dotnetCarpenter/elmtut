module HigherOrder exposing (main)

-- Input a user name and password. Make sure the password matches.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/forms.html
--

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import Debug

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }




-- MODEL

type alias Model = String

init : Model
init = ""

applyTwice : (a -> a) -> a -> a
applyTwice f x = f (f x)


-- UPDATE

type Msg =
  Apply


update : Msg -> Model -> Model
update msg model =
  case msg of
    Apply ->
      applyTwice (\s -> s ++ "fizzbuzz") model


-- VIEW

view : Model -> Html Msg
view model =
    div []
      [ button [ Html.Events.onClick Apply] [ text "Apply Twice"]
      , text model
      , p [] [ text ("Model: " ++ (Debug.toString model)) ]
      ]
