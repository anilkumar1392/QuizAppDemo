//
//  NavigationControllerRouterTests.swift
//  QuizAppDemoTests
//
//  Created by mac on 03/04/21.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizAppDemo

class NavigationControllerRouterTest : XCTestCase {
    
    let navigationController = UINavigationController()
    let factory = viewControllerFactoryStub()
    lazy var sut : NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController,factory : factory)
    }()

    func test_routeToSecondQuestion_withCorrectionViewController(){

        let viewController = UIViewController()
        let secondViewController = UIViewController()

        factory.stub(question : Question.singleAnswer("Q1"),with : viewController)
        factory.stub(question : Question.singleAnswer("Q2"),with : secondViewController)

        sut.routeTo(question : Question.singleAnswer("Q1"),answerCallback : {_ in} )
        sut.routeTo(question : Question.singleAnswer("Q2"),answerCallback : {_ in} )

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuesitonWithRigthCallback(){
        factory.stub(question : Question.singleAnswer("Q1"),with : UIViewController())
        var callbackFired = false
        sut.routeTo(question : Question.singleAnswer("Q1"),answerCallback : {_ in callbackFired = true})
        factory.answerCallback[Question.singleAnswer("Q1")]!(["Anything"])
        XCTAssertTrue(callbackFired)
    }
    
    func test_routeToResult_showsResultController(){
        let viewController = UIViewController()
        let secondViewController = UIViewController()

        let result = Result(answers: [Question.singleAnswer("Q1") : ["A1"]], score: 10)
        let secondResult = Result(answers: [Question.singleAnswer("Q2") : ["A2"]], score: 20)

        factory.stub(result : result,with : viewController)
        factory.stub(result : secondResult,with : secondViewController)

        sut.routeTo(results: result)
        sut.routeTo(results: secondResult)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
        
    }
    
    //MARK:- Helper
    class viewControllerFactoryStub : ViewControllerFactory {

        private var stubbedQuestions = [Question<String>:UIViewController]()
        private var stubbedResults = Dictionary<Result<Question<String>,[String]>,UIViewController>()

        var answerCallback = [Question<String> : ([String]) -> Void]()
        
        func stub(question : Question<String>,with viewController : UIViewController){
            stubbedQuestions[question] = viewController
        }
        
        func stub(result : Result<Question<String>,[String]>,with viewController : UIViewController){
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultsViewController(for result : Result<Question<String>,[String]>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }

    }

}


extension Result: Hashable{
    
    public var hashValue : Int {
        return 1
    }

    public static func ==(lhs : Result,rhs : Result) -> Bool {
        return lhs.score == rhs.score
    }
}
