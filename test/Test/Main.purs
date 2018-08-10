module Test.Main where

import Effect   (Effect)
import Prelude
import Test.Jwt (testJwt)

main :: Effect Unit
main = do
  testJwt
