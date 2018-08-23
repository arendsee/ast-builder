{-# LANGUAGE OverloadedStrings #-}

{-|
Module      : AstBuilder.Grammar
Description : Funtions for building common language constructs
Copyright   : (c) Zebulun Arendsee, 2018
License     : GPL-3
Maintainer  : zbwrnz@gmail.com
Stability   : experimental
-}

module AstBuilder.Grammar
(
    Grammar(..)
  , pythonGrammar
) where

import Text.PrettyPrint.Leijen.Text


data Grammar = Grammar {
      gFunction
        :: (Doc,Doc)         --   return type and function name
        -> [(Doc, Doc)]      --   list of positional argument types and names
        -> [(Doc, Doc, Doc)] --   list of keyword argument types and names and defaults
        -> Doc               --   function body
        -> Doc
    , gCall :: Doc -> [Doc] -> [(Doc,Doc)] -> Doc
    , gReturn :: Doc -> Doc
    , gAssign :: Doc -> Doc -> Doc
  }

pythonGrammar = Grammar {
      gFunction = function'
    , gCall     = call'
    , gReturn   = return'
    , gAssign   = assign'
  }
  where
    function' (_, oname) args kwargs body =
        text "def "
      <> oname
      <> tupled (map makeArg args ++ map makeKwarg kwargs)
      <> text ":" <> line <> indent 4 body <> line
      where
        makeArg :: (Doc, Doc) -> Doc
        makeArg (_, x) = x
    
        makeKwarg :: (Doc,Doc,Doc) -> Doc
        makeKwarg (_, name, value) = name <> text "=" <> value

    call' name args kwargs =
      name <> tupled (args ++ map makeKwarg kwargs)
      where
        makeKwarg (key, val) = key <> text "=" <> val 

    return' x = text "return" <> parens x

    assign' lhs rhs = lhs <> text " = " <> rhs <> line
