//
//  QuestionViewControllerTests.swift
//  QuizAppDemoTests
//
//  Created by mac on 27/03/21.
//

import Foundation
import XCTest
@testable import QuizAppDemo

class QuestionViewControllerTests : XCTestCase {
    
    func test_viewDidLoad_questionHeaderLabel(){
        XCTAssertEqual(makeSut("Q1", []).headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_witnNonOptions_renderNoOption(){
        XCTAssertEqual(makeSut("Q1", []).tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_witnOneOptions_renderOption(){
        XCTAssertEqual(makeSut("Q1", []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSut("Q1", ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSut("Q1", ["A1","A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_withOneOptions_renderOptionText(){
        let sut = makeSut("", ["A1","A2","A3"])
        XCTAssertEqual(sut.tableView.title(at: 0), "A1")
        XCTAssertEqual(sut.tableView.title(at: 1), "A2")
        XCTAssertEqual(sut.tableView.title(at: 2), "A3")
    }
    
    //test to handle selection
    
    func test_optionSelected_notifiesDelegateWithLastSelection(){
        var receivedAnswer = [String]()
        let sut = makeSut("", ["A1","A2","A3"]){
            receivedAnswer = $0
        }
        sut.tableView.selectRow(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.selectRow(at: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifiesDelegate(){
        var callbackCount = 0
        let sut = makeSut("", ["A1","A2","A3"]){ _ in callbackCount += 1}
        sut.tableView.selectRow(at: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselectRow(at: 1)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionsSelected_withMultipleSelctionenabled_notifiesDeleagte(){
        var receivedAnswer = [String]()
        let sut = makeSut("", ["A1","A2","A3"]){
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection =  true
        sut.tableView.selectRow(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.selectRow(at: 1)
        XCTAssertEqual(receivedAnswer, ["A1","A2"])
    }
    
    func test_optionsDeselected_withMultipleSelctionenabled_notifiesDeleagte(){
        var receivedAnswer = [String]()
        let sut = makeSut("", ["A1","A2","A3"]){
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection =  true
        sut.tableView.selectRow(at: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselectRow(at: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    //MARK: - Helper
    func makeSut(_ question : String = "",
                 _ options : [String] = [],
                 selection : @escaping ([String]) -> Void = {_ in}) -> QuestionViewController{
        let sut = QuestionViewController(question: question,options: options, selection: selection)
        _ = sut.view
        return sut
    }
}



