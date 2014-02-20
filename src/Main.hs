import Data.Aeson
import Data.ByteString.UTF8 (fromString)
import Data.ByteString.Lazy (toStrict)
import Data.ByteString.Lazy.UTF8 (toString)
import Data.HashMap.Strict (HashMap, insert)

import qualified Data.Text as Text

main :: IO ()
main = do
  let source  = "/home/alois/jvm/persist/src/test/resources/com/timeout/persist/data/platform/venues.json"
  let target  = source ++ ".new"
  content     <- readFile source
  _           <- writeFile target $ unlines $ map transform $ lines content
  return () where
    transform :: String -> String
    transform x = maybe x set get where
      get = decodeStrict $ fromString x
      set (Object xs) = write . Object $ insert (Text.pack "sponsored") (Bool False) xs
      set x = write x 
      write = toString . encode

  
