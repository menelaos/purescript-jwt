module Test.Utils
  ( getUsername )
where

import Data.Argonaut.Core   ( Json )
import Data.Argonaut.Decode ( JsonDecodeError, decodeJson, getField )
import Data.Either          ( Either )
import Prelude


getUsername :: Json -> Either JsonDecodeError String
getUsername = flip getField "username" <=< decodeJson
