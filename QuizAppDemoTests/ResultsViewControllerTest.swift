//
//  ResultsViewControllerTest.swift
//  QuizAppDemoTests
//
//  Created by mac on 28/03/21.
//

import Foundation
import XCTest
@testable import QuizAppDemo

class ResultsViewControllerTests : XCTestCase {
    
    func test_viewDidLoad_renderSummary(){
        XCTAssertEqual(makeSut(summary: "A summary", answers: []).headerLabel.text, "A summary")
    }
    
    func test_viewDidLoad_renderAnswer(){
        XCTAssertEqual(makeSut(summary: "A summary", answers: []).tableView.numberOfRows(inSection: 0),0)
        XCTAssertEqual(makeSut(summary: "A summary", answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0),1)
    }
    
    func test_withCorrectAnswer_configureCell(){
        let sut = makeSut(summary: "A summary", answers: [makeAnswer(question: "Q1", answer: "A1")])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text,"Q1")
        XCTAssertEqual(cell?.answerLabel.text,"A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_ConfigureCell(){
        let sut = makeSut(summary: "A summary", answers: [makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text,"Q1")
        XCTAssertEqual(cell?.answerLabel.text,"A1")
    }
    
    //MARK: - Helper
    
    func makeSut(summary : String,answers : [PresentableAnswer]) -> ResultsViewController {
        let sut = ResultsViewController(summary: "A summary", answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question : String = "",answer : String = "",wrongAnswer : String? = nil) -> PresentableAnswer{
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }
    
}

