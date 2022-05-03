module Test.Jwt
  ( testJwt )
where

import Data.Argonaut.Core ( fromBoolean, fromObject, fromString, stringify )
import Data.Either        ( hush )
import Data.Maybe         ( Maybe (Just, Nothing) )
import Effect             ( Effect )
import Effect.Console     ( log )
import Foreign.Object     ( singleton )
import Jwt                ( decode, decodeWith )
import Prelude
import Test.Assert        ( assert )
import Test.Utils         ( getUsername )

testJwt :: Effect Unit
testJwt = do
  let
    -- Convert different (error) types to `Maybe` and work around the missing
    -- `Show` instance for `Json`
    decode'      = map stringify <<< hush <<< decode
    decodeWith'  = (map <<< map) hush decodeWith
    fromObject'  = Just <<< stringify <<< fromObject

    malformedToken     = "malformedToken"
    invalidBase64Token = "Hello.I'mAValidBase𝟞𝟜String.TrustMe"

    -- { "username" : "山田太郎" }
    usernameToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IuWxseeUsOWkqumDjiJ9.05PVZNY2t-DM4OUn__7gEgMwqMBVKq5KfNr1JKQ_HRc"

    -- { "admin" : true }
    adminToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbiI6dHJ1ZX0.fXypkBFuqt1YgTjy6DWKdlZY-4ikLwJ0CtAhG472rvY"

    -- {"username":"山田太郎", missing closing brace
    invalidJsonToken = "containsInvalidJSON.eyJ1c2VybmFtZSI6IuWxseeUsOWkqumDjiI.andShouldNeverHaveBeenGenerated"

  log "decode"
  assert $ decode' adminToken
    == (fromObject' <<< singleton "admin" <<< fromBoolean) true

  assert $ decode' usernameToken
    == (fromObject' <<< singleton "username" <<< fromString) "山田太郎"

  assert $ decode' invalidJsonToken   == Nothing
  assert $ decode' malformedToken     == Nothing
  assert $ decode' invalidBase64Token == Nothing

  log "decodeWith"
  assert $ decodeWith' getUsername usernameToken      == Just "山田太郎"
  assert $ decodeWith' getUsername malformedToken     == Nothing
  assert $ decodeWith' getUsername invalidBase64Token == Nothing
  assert $ decodeWith' getUsername adminToken         == Nothing
  assert $ decodeWith' getUsername invalidJsonToken   == Nothing
