//
//  QuestionType.swift
//  QuizAppDemo
//
//  Created by mac on 04/04/21.
//

import Foundation

enum Question<T : Hashable> : Hashable{
    case singleAnswer(T)
    case multipleAnswer(T)

    var hashValue: Int{
        switch self {
        case .singleAnswer(let a):
            return a.hashValue
        case .multipleAnswer(let a):
            return a.hashValue
        }
    }
    
    static func == (lhs : Question<T>,rhs : Question<T>) -> Bool{
        switch (lhs,rhs) {
        case (singleAnswer(let a),singleAnswer(let b)):
            return a.hashValue == b.hashValue
        case (multipleAnswer(let a),multipleAnswer(let b)):
            return a.hashValue == b.hashValue
        default: return false
        }
    }
    
}

