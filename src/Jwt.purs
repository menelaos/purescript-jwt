-- | A `JSON Web Token` (JWT) (RFC 7519) is a string that consists of three
-- | (URL-safe) Base64-encoded strings separated by dots.
-- |
-- | <header>.<payload>.<signature>
-- |
-- | The `payload` is basically an encoded JSON object which can be
-- | retrieved via the `decode` function in this module.
-- |
-- | For further information see:
-- | https://en.wikipedia.org/wiki/JSON_Web_Token
-- | https://tools.ietf.org/html/rfc7519
module Jwt
  ( JwtError (..)
  , decode
  , decodeWith
  )
where

import Data.Argonaut.Core   ( Json )
import Data.Argonaut.Parser ( jsonParser )
import Data.Array           ( index )
import Data.Either          ( Either, note )
import Data.Lens            ( _Left, over )
import Data.String          ( Pattern (Pattern), split )
import Data.String.Base64   as Base64
import Effect.Exception     ( Error )
import Prelude


-- | A `JwtError a` can be a
-- | * `MalformedToken` when the token is not of the form
-- |   `<header>.<payload>.<signature>`
-- | * `Base64DecodeError` when the `payload` is not a valid Base64 string
-- | * `JsonDecodeError a` when the user-provided decoder function fails
-- | * `JsonParseError` when the decoded Base64 string cannot be parsed as JSON
data JwtError a
  = MalformedToken
  | Base64DecodeError Error
  | JsonDecodeError a
  | JsonParseError String

-- | Decode a token into a `Json` value.
decode :: ∀ a. String -> Either (JwtError a) Json
decode token =
  let
    payload =
      note MalformedToken <<< (_ `index` 1) <<< split (Pattern ".") $ token

    -- Map possibly failing functions to the same error type
    decodeBase64 = map (over _Left Base64DecodeError) Base64.decode
    parseAsJson  = map (over _Left JsonParseError   ) jsonParser

  in
    payload >>= decodeBase64 >>= parseAsJson

-- | Decode a token to a PureScript value via a user-provided function.
-- | This is for convenience as it saves a little bit of error type juggling.
decodeWith :: ∀ a b. (Json -> Either b a) -> String -> Either (JwtError b) a
decodeWith f token =
  let
    decodeJson = map (over _Left JsonDecodeError) f
  in
    decode token >>= decodeJson
