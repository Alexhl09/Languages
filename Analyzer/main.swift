//
//  main.swift
//  Analyzer
//
//  Created by Alejandro Hernández López on 16/02/21.
//

import Foundation

let lexer = Lexer()
var tokens = lexer.getTokens()
for i in tokens{
    print(i.identifier + " - " + i.value)
}
let syntacticParser = SyntacticAnalyzer()
syntacticParser.parse(tokens: &tokens)
print("Sequence accepted!")
