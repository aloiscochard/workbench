{-# LANGUAGE OverloadedStrings #-}

import qualified Workbench.JSON as JSON
import qualified Workbench.File as File

import Data.Aeson (Value(Bool))
import Data.HashMap.Strict (insert)

main :: IO ()
main = File.transformByLines (JSON.transformObject f) "/home/alois/jvm/persist/src/test/resources/com/timeout/persist/data/platform/venues.json"
  where
    f = insert "sponsored" (Bool False)
