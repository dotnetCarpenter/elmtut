module Main exposing (..)

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

type alias Model =
  { fieldA : String
  , fieldB : String
  }


init : Model
init =
    Model "" ""



-- UPDATE

type Msg
  = FieldA String
  | FieldB String


update : Msg -> Model -> Model
update msg model =
  case msg of
    FieldA fieldA ->
      { model | fieldA = fieldA }

    FieldB fieldB -> Debug.todo ("Handle FieldB. Currently fieldB contains " ++ fieldB)



-- VIEW

view : Model -> Html Msg
view model =
    div []
    [
        input [ placeholder "Text input", value model.fieldA, onInput FieldA ] []
    ,   viewFunction model -- viewFunction will be called whenever there is a change to model
    ]

viewFunction : Model -> Html msg
viewFunction model =
    text ("Reactive text: " ++ model.fieldA)





