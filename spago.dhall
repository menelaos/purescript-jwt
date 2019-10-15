{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "jwt"
, dependencies =
    [ "argonaut-codecs"
    , "argonaut-core"
    , "arrays"
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
    , "strongcheck"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
