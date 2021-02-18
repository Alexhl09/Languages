//
//  Lexer.swift
//  Analyzer
//
//  Created by Alejandro Hernández López on 17/02/21.
//

import Foundation

enum Identifier : Int{
    case integer = 400
    case register = 500
    case operation = 600
    case assigment = 700
    case eof = 800
    case error = 999
    
}

struct Token{
    var identifier : String
    var value : String
}

class Lexer {

    private var textToAnalyze : String

    init(){
        var path : URL?
        
        // Ask the user the name of the file
        repeat{
            print("Type the name of the file, without extension\n")
            guard let nameOfFile = readLine() else {
                self.textToAnalyze = ""
                return}
            path = Bundle.main.url(forResource: nameOfFile, withExtension: "txt")
        }while path == nil
        
        
        // Get complete string to analyze
        do{
            self.textToAnalyze = try String(contentsOf: path!)
        } catch let error{
            print(error.localizedDescription)
            self.textToAnalyze = ""
        }
    }
    
    func getTokens() -> [Token]{
       
        
        let transitionMatrix : [[Int]] = getTransitionMatrix()
        var index = 0
        var char : Character = " "
        var state = 0
        var tokens : [Token] = []
        var prevState = 0
        
        while (index < self.textToAnalyze.count) {
            var value = ""
            repeat {
                let i = self.textToAnalyze.index(self.textToAnalyze.startIndex, offsetBy: index)
                char = self.textToAnalyze[i]
                index += 1
                let filtered = filter(char: char)
                guard filtered < 100 else {
                    print("Not identified character: \(char)")
                    return []}
                
                state = transitionMatrix[state][filtered]
                
                // Verify numbers when they have reached an end, set state to 400
                if(state == 0  && prevState == 1){
                    state = 400
                }
                
                switch state {
                // White spaces with an incomplete string, error
                case 0 where value.count > 0:
                    print("Incomplete string for value '\(value)' followed by space")
                    exit(EXIT_FAILURE)
                // Append characters
                case 1...900 where state != 400:
                    value.append(char)
                // Error for 999 state
                case 999:
                    print("Error with the string sequence: \(value), due to a problem with the character \(char)")
                    exit(EXIT_FAILURE)
                default:
                    break
                }
                
                prevState = state
                
            } while (index < self.textToAnalyze.count && state < 200)
            
            // Good token, reached goal
            if(state > 200){
                tokens.append(Token(identifier: "\(Identifier(rawValue: state) ?? .error)", value: value))
            }
            
            // Set again the state to 0
            state = 0
        }
    
        return tokens
        
}
    func filter(char : Character) -> Int {
        if(char.isNumber){
            return 1
        }else{
            switch char {
            case " ":
                return 0
            case "#":
                return 2
            case ";":
                return 3
            case "A":
                return 4
            case "B":
                return 5
            case "C":
                return 6
            case "D":
                return 7
            case "I":
                return 8
            case "L":
                return 9
            case "M":
                return 10
            case "O":
                return 11
            case "S":
                return 12
            case "U":
                return 13
            case "V":
                return 14
            case "\n":
                return 0
            default:
                return 999
            }
        }
    }
}

