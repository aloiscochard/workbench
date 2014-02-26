module Workbench.JSON where

import Data.Aeson
import Data.ByteString.UTF8 (fromString)
import Data.ByteString.Lazy.UTF8 (toString)

import qualified Data.Text as Text

transform :: (Value -> Value) -> String -> String
transform f x = maybe x set get 
  where
    get = decodeStrict $ fromString x
    set x = write (f x)
    write = toString . encode

transformObject :: (Object -> Object) -> String -> String
transformObject f x = transform g x 
  where
    g (Object xs) = Object (f xs)
    g x = x

