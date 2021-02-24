//
//  Syntactic.swift
//  Analyzer
//
//  Created by Yulisa M. on 23/02/21.
//

import Foundation

//1. An OPERATION (SUM, SUB, MUL, and DIV) must be followed by two registers. For example: SUM #A #B. It is not allowed for an operation to involve an INTEGER directly (it must be assigned to a register to be used).
//2. An ASSIGNMENT (MOV) can take an INTEGER or a REGISTER as first operand. However, the second operand must be a REGISTER. For example: MOVE 12 #A or MOV #B #D.
//3. Only at the end of the file, the symbol ; must be present. This is to indicate the end of the file.

/*
 
 S -> X
 
 X -> O #R #R
 
 X -> MOV I #R
 X -> MOV #R #R
 
 X -> ; // CHECAR QUE ; SOLO SEA ACEPTADO SI ES EL ULTIMO RENGLON DEL ARCHIVO
 
 I -> 0I
 I -> 1I
 I -> 2I
 I -> 3I
 I -> 4I
 I -> 5I
 I -> 6I
 I -> 8I
 I -> 9I
 
 TERMINALES
 O -> SUM
 O -> SUB
 O -> MUL
 O -> DIV
 
 R -> A
 R -> B
 R -> C
 R -> D
 
 I -> 0
 I -> 1
 I -> 2
 I -> 3
 I -> 4
 I -> 5
 I -> 6
 I -> 8
 I -> 9
 
 */
 
class Syntactic{
    
    
}
