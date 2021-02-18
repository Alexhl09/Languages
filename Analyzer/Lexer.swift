//
//  Lexer.swift
//  Analyzer
//
//  Created by Alejandro Hernández López on 17/02/21.
//

import Foundation

enum Operation : Int{
    case add = 0
    case sub
    case mul
    case div
    case error = 999
}

enum Identifier : Int{
    case integer = 400
    case register = 500
    case operation = 600
    case assigment = 700
    case eof = 800
    case error = 999
    
}

enum Tokens : Int{
    case zero = 0
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case space = 10
    case gato = 35
    case puntoComa = 59
    case a = 65
    case b
    case c
    case d
    case i = 73
    case l = 76
    case m
    case o = 79
    case s = 83
    case u = 85
    case v
    case error = 999
}

class Lexer {
    //let tokens : [Token]
    var textToAnalyze : String
    init(){
        defer{
            print("There is an error, check again")
        }
        
        print("Type the name of the file, without extension\n")
        guard let nameOfFile = readLine() else {
            self.textToAnalyze = ""
            return}
        var path : URL?
        repeat{
            path = Bundle.main.url(forResource: nameOfFile, withExtension: "txt")
        }while path == nil
        do{
            self.textToAnalyze = try String(contentsOf: path!)
        } catch let error{
            print(error.localizedDescription)
            self.textToAnalyze = ""
        }
    }
    
    func getTokens(){
        
//        case a = 65
//        case b
//        case c
//        case d
//        case i = 73
//        case l = 76
//        case m
//        case o = 79
//        case s = 83
//        case u = 85
//        case v
        //        let transitionMatrix : [[Int]] = [[0space,1nu,2gat,3punt,4a,999b,999c,7d,999i,999l,10m,999o,12s,999u,999v,999],

        let transitionMatrix : [[Int]] = [[0,1,2,800,4,999,999,7,999,999,10,999,12,999,999,999],
                                          [0,1,999,999,999,999,999,999,999,999,999,999,999,999,999,999],
                                          [999,999,999,999,500,500,500,500,999,999,999,999,999,999,999,999],
                                          [0,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999],
                                          [0,999,999,999,999,999,999,7,999,999,999,999,999,999,999,999],
                                          [0,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999],
                                         [0,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999],
                                            [999,999,999,999,999,999,999,600,999,999,999,999,999,999,999,999],
                                            [999,999,999,999,999,999,999,999,999,999,999,999,999,999,600,999],
                                            [0,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999],
                                            [0,999,999,999,999,999,999,999,999,999,999,11,999,13,999,999],
                                            [999,999,999,999,999,999,999,999,999,999,999,999,999,999,700,999],
                                            [999,999,999,999,999,999,999,999,999,999,999,999,999,13,999,999],
                                            [999,999,999,999,999,600,999,999,999,600,600,999,999,999,999,999],
                                            [0,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999],
                                            [999,999,999,999,999,999,999,999,999,999,999,999,999,999,999,999],

            //[0,999,999,999,999,999,999,999,999,999,999,999,11,999,999,14,999,999],

                                          ]
        var index = 0
        var c : Character = " "
        var state = 0
        let arrayCharacters = Array(self.textToAnalyze)
        var token : [(Int, String)] = []
        var prevState = 0
        var prevChar : Character = " "

        while (index < arrayCharacters.count) {
            var value = ""
            repeat {
                c = arrayCharacters[index]
                index += 1
                let f = filter(char: c)
                guard f < 100 else {
                    print("Not identified character")
                    return}
                
                state = transitionMatrix[state][f]
                
              
                if(prevChar.isNumber && prevState == 1){
                    state = 400
                }
                
                if (state != 0 && state != 400) {
                    value.append(c)
                }
                
                
                prevState = state
                prevChar = c
                
            } while (index < arrayCharacters.count && state < 200)
            if(state == 999){
                exit(EXIT_FAILURE)
            }else if(state > 200){
                token.append((state,value))
            }
            state = 0
        }
    
        for (a,b) in token{
            print("\(b) - \(Identifier(rawValue: a) ?? .error)")
        }
        print(token)
        
}
    func filter(char : Character) -> Int{
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
/**
 do{
     print("Type the name of the file, without extension\n")
     guard let nameOfFile = readLine() else {return}
     
     if let url = Bundle.main.url(forResource: "example", withExtension: "txt") {
               do {

                   let myData = try Data(contentsOf: url)
                   print(myData.count)
               } catch {
                   print(error)
               }
           }

     if let audioFilePath = Bundle.main.url(forResource: "ex", withExtension: "txt"){
         print(audioFilePath)
     }
     
//            let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
//            print(currentDirectoryURL.absoluteURL)
//            let url = URL(fileURLWithPath: nameOfFile, relativeTo: currentDirectoryURL)
//            print(url.absoluteURL)
//            let textToAnalyze = try String(contentsOf: url)
//            let trimmedCode = textToAnalyze.trimmingCharacters(in: .whitespacesAndNewlines)
//            print(trimmedCode)
 }catch let error{
     print(error.localizedDescription)
 }
**/
