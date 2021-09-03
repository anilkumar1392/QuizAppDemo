//
//  QuestionTests.swift
//  QuizAppDemoTests
//
//  Created by mac on 04/04/21.
//

import Foundation
import XCTest
@testable import QuizAppDemo

class QuestionTest : XCTestCase {
    
    func test_hashValue_singleAnswer_returnsTypeHash(){
        let type = "a string"
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash(){
        let type = "a string"
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equal_singleAnswer_isEqual(){
        let type = "a string"
        XCTAssertEqual(Question.singleAnswer(type), Question.singleAnswer(type))
    }
    
    func test_equal_singleAnswer_isNotEqual(){
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
    }
    
    func test_equal_multipleAnswer_isEqual(){
        XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
    }
    
    func test_equal_multipleAnswer_isNotEqual(){
        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
    }
}
