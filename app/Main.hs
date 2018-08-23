{-# LANGUAGE OverloadedStrings #-}

module Main where

import AstBuilder
import qualified Text.PrettyPrint.Leijen.Text as P

main :: IO ()
main = P.putDoc (P.parens "hi")
