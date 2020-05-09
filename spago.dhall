{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "jwt"
, license =
    "Apache-2.0"
, repository =
    "git://github.com/menelaos/purescript-jwt.git"
, dependencies =
    [ "argonaut-codecs"
    , "argonaut-core"
    , "arrays"
    , "assert"
    , "b64"
    , "console"
    , "effect"
    , "either"
    , "errors"
    , "exceptions"
    , "foreign-object"
    , "prelude"
    , "profunctor-lenses"
    , "psci-support"
    , "strings"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
