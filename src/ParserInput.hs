{-# LANGUAGE CPP                       #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE Rank2Types                #-}
{-# LANGUAGE TypeSynonymInstances      #-}

module ParserInput where

import           AST
import           Engine
import           Text.ParserCombinators.UU
import           Text.ParserCombinators.UU.BasicInstances
import           Text.ParserCombinators.UU.Utils

parseInput :: FilePath -> String -> Proposition
parseInput filepath fileContent
  = runParser filepath pProposition fileContent

pProposition :: Parser Proposition
pProposition =  symbol <$> pSymbolProposition
            <|> negation <$ pSymbol "~" <*> pProposition
--            <|> implies  <$> pProposition <* pSymbol "->" <*> pProposition

pSymbolProposition :: Parser String
pSymbolProposition = (:[]) <$> pLetter

{-
pAxioms :: Parser Axioms
pAxioms = pListSep pDemostration pSpaces

pDemostration :: Parser Demostration
pDemostration = pSymbol "Demonstrate" <* pSymbol "|-" <*> pProposition <* pSymbol "by" <*> pSteps
-}
