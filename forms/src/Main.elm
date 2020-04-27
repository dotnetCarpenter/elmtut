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
  if String.length model.password < 8 then
    div [ style "color" "red" ] [ text "Password is too short! Must be above 8 characters." ]
  else if validateStrongness model.password then
    div [ style "color" "red" ] [ text "Password is too weak! Must contain  upper case, lower case, and numeric characters." ]
  else if model.password /= model.passwordAgain then
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else
    div [ style "color" "green" ] [ text "OK" ]


validateStrongness : String -> Bool
validateStrongness pw =
  test pw Char.isLower
  && test pw Char.isUpper
  && test pw Char.isDigit

  -- (String.filter (\c -> Char.isLower c) pw |> String.isEmpty)
  -- && (String.filter (\c -> Char.isUpper c) pw |> String.isEmpty)
  -- &&  (String.filter (\c -> Char.isDigit c) pw |> String.isEmpty)

  -- Debug.log (String.foldl hasLower "" pw)
  -- Debug.log (String.foldl hasUpper "" pw)

  -- String.length (String.foldl hasLower "" pw) > 0
  -- && String.length (String.foldl hasUpper "" pw) > 0

test : String -> (Char -> Bool) -> Bool
test s f =
  String.filter f s |> String.isEmpty |> not

-- hasLower : Char -> String -> String
-- hasLower char accu =
--   if Char.isLower char then String.fromChar char else accu

-- hasUpper : Char -> String -> String
-- hasUpper char accu =
--   if Char.isUpper char then String.fromChar char else accu

