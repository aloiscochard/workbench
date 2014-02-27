module Workbench.HTTP where

import Data.Aeson
import Data.Attoparsec
import Data.ByteString
import Data.Maybe
import Network.HTTP
import Network.URI

getUrl :: String -> IO ByteString
getUrl url = getResponseBody =<< simpleHTTP (mkRequest GET (fromJust $ parseURI url))

getUrlAsJson :: String -> IO (Either String Value)
getUrlAsJson url = fmap (eitherResult . parse json) $ getUrl url


