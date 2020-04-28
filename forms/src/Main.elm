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
  { name : String
  , password : String
  , passwordAgain : String
  }


init : Model
init =
  Model "" "" ""



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div [ class "foo" ]
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  {- if String.length model.password < 8 then
    div [ style "color" "red" ] [ text "Password is too short! Must be above 8 characters." ]
  else  -}if weakPassword model.password then
    div [ style "color" "red" ] [ text "Password is too weak! Must contain upper case, lower case, and numeric characters." ]
  -- else if model.password /= model.passwordAgain then
  --   div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else
    div [ style "color" "green" ] [ text "OK" ]

-- debug : String -> Bool -> Bool
-- debug pw f =
--   no pw Char.isAlphaNum |> Debug.log "no pw Char.isAlphaNum"
--   f

-- False if pw is weak, True if it's strong
weakPassword : String -> Bool
weakPassword pw =
  (no pw Char.isLower |> Debug.log "no pw Char.isLower")
  || (no pw Char.isUpper |> Debug.log "no pw Char.isUpper")
  || no pw Char.isDigit |> Debug.log "no pw Char.isDigit"

-- True if predicate yields an empty string
no : String -> (Char -> Bool) -> Bool
no s predicate =
  String.filter predicate s |> String.isEmpty
