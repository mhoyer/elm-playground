import Debug exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)

-- type alias Mailbox a = { address : Address a, signal : Signal a }
nameMailbox = Signal.mailbox "world"

resetName : String
resetName = 
  ""

sendTargetValue : Signal.Address String -> (String -> Message)
sendTargetValue addr =
    (\x -> Signal.message addr x)

-- from http://package.elm-lang.org/packages/evancz/elm-html/4.0.1/Html-Events#targetValue
onInput : Signal.Address String -> Attribute
onInput addr =
    on "input" targetValue <| sendTargetValue addr

view : String -> Html
view name = 
  div [] [
    text ("Hello, " ++ name)
    , br [] []
    , input [ 
      placeholder "Enter your name"
      , value name
      , onFocus nameMailbox.address resetName
      , onInput nameMailbox.address
      ] []
  ]

main : Signal Html
main = view <~ (nameMailbox.signal)
