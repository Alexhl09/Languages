//
//  main.swift
//  Analyzer
//
//  Created by Alejandro Hernández López on 16/02/21.
//

import Foundation

let lexer = Lexer()
let tokens = lexer.getTokens()
for i in tokens{
    print(i.identifier + " - " + i.value)
}
