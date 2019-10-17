module Test.Utils
  ( getUsername )
where

import Control.Error.Util   ( note )
import Data.Argonaut.Core   ( Json, toObject )
import Data.Argonaut.Decode ( (.:) )
import Data.Either          ( Either )
import Prelude


getUsername :: Json -> Either String String
getUsername json = do
  obj <- note "Could not parse JSON as object" $ toObject json
  obj .: "username"
