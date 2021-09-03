//
//  NavigationControllerRouter.swift
//  QuizAppDemo
//
//  Created by mac on 03/04/21.
//

import UIKit
import QuizEngine

class NavigationControllerRouter : Router {

    private var navigationController : UINavigationController?
    var factory : ViewControllerFactory
    
    init(_ navigationController : UINavigationController,factory :  ViewControllerFactory){
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question : Question<String>, answerCallback : @escaping ([String]) -> Void) {
        show(self.factory.questionViewController(for: question, answerCallback: answerCallback))
    }

    func routeTo(results : Result<Question<String>,[String]>) {
        show(self.factory.resultsViewController(for: results))
    }
    
    func show(_ viewController : UIViewController) {
        navigationController?.pushViewController(viewController, animated: false)
    }
}

