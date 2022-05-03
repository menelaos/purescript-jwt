{ name = "jwt"
, license = "Apache-2.0"
, repository = "git://github.com/menelaos/purescript-jwt.git"
, dependencies =
  [ "argonaut-codecs"
  , "argonaut-core"
  , "arrays"
  , "assert"
  , "b64"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "foreign-object"
  , "maybe"
  , "prelude"
  , "profunctor-lenses"
  , "strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
