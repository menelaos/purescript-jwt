module Test.Utils
  ( getUsername )
where

import Prelude

import Control.Error.Util (note)
import Data.Argonaut.Core (Json, toObject)
import Data.Argonaut.Decode (JsonDecodeError(..), (.:))
import Data.Either (Either)


getUsername :: Json -> Either JsonDecodeError String
getUsername json = do
  obj <- note (TypeMismatch "Could not parse JSON as object") $ toObject json
  obj .: "username"
