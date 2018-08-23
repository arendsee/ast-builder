{-# LANGUAGE OverloadedStrings #-}

module Main where

import AstBuilder
import qualified Text.PrettyPrint.Leijen.Text as P

g = pythonGrammar

main :: IO ()
main = P.putDoc $ (gFunction g)
  (P.text "Int", P.text "foo")
  [(P.text "Int", P.text "x"), (P.text "Int", P.text "z")]
  []
  (
       (gAssign g) (P.text "y") (P.text "x")  
    <> (gReturn g) ((gCall g) (P.text "sqrt") [P.text "y"] [])
  )
