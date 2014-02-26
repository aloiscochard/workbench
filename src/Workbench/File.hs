module Workbench.File where

transform :: (String -> String) -> String -> IO ()
transform f source = do
  let target  = source ++ ".new"
  content     <- readFile source
  _           <- writeFile target $ f content
  return ()

transformByLines :: (String -> String) -> String -> IO ()
transformByLines f source = transform g source
  where
    g content = unlines $ map f $ lines content
