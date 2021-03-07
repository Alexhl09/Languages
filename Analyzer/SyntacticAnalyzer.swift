//
//  SyntacticAnalyzer.swift
//  Analyzer
//
//  Created by Yulisa M on 03/03/21.
//

import Foundation

//1. An OPERATION (SUM, SUB, MUL, and DIV) must be followed by two registers. For example: SUM #A #B. It is not allowed for an operation to involve an INTEGER directly (it must be assigned to a register to be used).
//2. An ASSIGNMENT (MOV) can take an INTEGER or a REGISTER as first operand. However, the second operand must be a REGISTER. For example: MOVE 12 #A or MOV #B #D.
//3. Only at the end of the file, the symbol ; must be present. This is to indicate the end of the file.

/*
 GRAMMAR:
 
 S -> X;
 
 X -> O R R X
 
 X -> MOV R R X
 X -> MOV I R X
 
 TERMINAL
 O -> SUM
 O -> SUB
 O -> MUL
 O -> DIV
 
 R -> #A
 R -> #B
 R -> #C
 R -> #D
 
 I -> NUMBER (integer value)
 
 */

class SyntacticAnalyzer{
    
    func match(tokens : inout [Token], expected : Token) -> Void{
//        Check if array is empty
        if(tokens.isEmpty){
            print("Error with string syntax: expected '\(expected.value)' but found nothing")
            exit(EXIT_FAILURE)
//            return false
        }
//        Check if both token's type and value are equal to that expected
        if(tokens[0].identifier == expected.identifier && tokens[0].value == expected.value){
            tokens.removeFirst()
            return
//            return true
        }else{
            print("Error with string syntax: expected '\(expected.value)', but found '\(tokens[0].value)'")
            exit(EXIT_FAILURE)
//            return false
        }
    }
    
    func parse(tokens : inout [Token]) -> Void{
        print("\nStarting syntax analysis...\n")
        parseS(tokens: &tokens)
    }
    
//    Generating token for terminal rules
    func getTerminalRegister(token : Token) -> Token{
        switch token.value {
        case "#A":
            return Token(identifier: "\(Identifier.register)", value: "#A")
        case "#B":
            return Token(identifier: "\(Identifier.register)", value: "#B")
        case "#C":
            return Token(identifier: "\(Identifier.register)", value: "#C")
        case "#D":
            return Token(identifier: "\(Identifier.register)", value: "#D")
        default:
            return Token(identifier: "\(Identifier.register)", value: "REGISTER")
        }
    }
    
    func getTerminalOperation(token : Token) -> Token{
        switch token.value {
        case "SUM":
            return Token(identifier: "\(Identifier.operation)", value: "SUM")
        case "SUB":
            return Token(identifier: "\(Identifier.operation)", value: "SUB")
        case "MUL":
            return Token(identifier: "\(Identifier.operation)", value: "MUL")
        case "DIV":
            return Token(identifier: "\(Identifier.operation)", value: "DIV")
        default:
            return Token(identifier: "\(Identifier.operation)", value: "OPERATION")
        }
    }
    
    func getTerminalInteger(token : Token) -> Token{
        return Token(identifier: "\(Identifier.integer)", value: token.value)
    }
    
    func parseS(tokens : inout [Token]) -> Void{
        //        Check if array is empty
                if(tokens.isEmpty){
                    print("Error with string syntax: expecting token but found nothing")
                    exit(EXIT_FAILURE)
                }
        //        Verify if token matches with grammatical rules established
        switch tokens[0].identifier {
                case "\(Identifier.assigment)":
                    match(tokens: &tokens, expected: Token(identifier: "\(Identifier.assigment)", value: "MOV"))
                    if(tokens[0].identifier == "\(Identifier.register)"){
                        match(tokens: &tokens, expected: getTerminalRegister(token: tokens[0]))
                    }else if(tokens[0].identifier == "\(Identifier.integer)"){
                        match(tokens: &tokens, expected: getTerminalInteger(token: tokens[0]))
                    }
                    match(tokens: &tokens, expected: getTerminalRegister(token: tokens[0]))
                    break
                case "\(Identifier.operation)":
                    match(tokens: &tokens, expected: getTerminalOperation(token: tokens[0]))
                    match(tokens: &tokens, expected: getTerminalRegister(token: tokens[0]))
                    match(tokens: &tokens, expected: getTerminalRegister(token: tokens[0]))
                    break
                case "\(Identifier.eof)":
                    match(tokens: &tokens, expected: Token(identifier: "\(Identifier.eof)", value: ";"))
                    return
                default:
                    print("Error with string syntax: undefined token type detected")
                    exit(EXIT_FAILURE)
                }
        
        parseS(tokens: &tokens)
    }
}
