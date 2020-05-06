module UpdateReturn exposing (main)

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


-- Browser.sandbox
--  init : model
--, view : model -> Html msg
--, update : msg -> model -> model
--     -> Program () model msg
main =
  Browser.sandbox { init = init, update = update, view = view }




-- MODEL

type alias Model = (String, Int)

init : Model
init = ("", 0)

applyTwice : (a -> a) -> a -> a
applyTwice f x = f (f x)


-- UPDATE

type Msg =
  Apply


-- What ever update returns will be the input to view
-- But Browser.sandbox dictates that update : msg -> model -> model
-- So we need to define Model and Msg
update : Msg -> Model -> (String, Int)
update msg model =
  case msg of
    Apply ->
      (applyTwice (\s -> s ++ "fizzbuzz") (Tuple.first model), 0)


-- VIEW
-- Browser.sandbox dictates that view : model -> Html msg
view : (String, Int) -> Html Msg
view (s, i) =
    div []
      [ button [ Html.Events.onClick Apply] [ text "Apply Twice"]
      , text s
      , p [] [ text ("Model: " ++ Debug.toString (s, i)) ]
      ]
