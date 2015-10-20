import Debug exposing (..)
import Html exposing (..)
import String exposing (..)

add3 x = x + 3
mul4 x = x * 4
add3mul4 = add3 << mul4

variants = [
   ("braces ()  ", add3 (mul4 5))
  ,("backward <|", add3 <| mul4 5)
  ,("forward |> ", mul4 5 |> add3)
  ,("fncomp >>  ", 5 |> mul4 >> add3)
  ]

print : (String, x) -> x 
print (variantName, result) = 
  log variantName result

prepend : String -> String -> String
prepend =
  flip String.append

main : Html
main = 
  List.map print variants
  |> List.length
  |> toString
  |> prepend " variants"
  |> text