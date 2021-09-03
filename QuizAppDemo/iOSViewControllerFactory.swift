//
//  iOSViewControllerFactory.swift
//  QuizAppDemo
//
//  Created by mac on 11/04/21.
//

import UIKit
import QuizEngine

public class iOSViewControllerFactory : ViewControllerFactory{
    private let options : Dictionary<Question<String>,[String]>
    
    init(options: Dictionary<Question<String>,[String]>) {
        self.options = options
    }
    
    func questionViewController(for question : Question<String>, answerCallback : @escaping ([String]) -> Void) -> UIViewController{
        switch question {
        case.singleAnswer(let value):
            return QuestionViewController(question: value, options: self.options[question]!, selection: answerCallback)
        default :
            return UIViewController()
        }
    }
    
    func resultsViewController(for question : Result<Question<String>,[String]>) -> UIViewController{
        return UIViewController()
    }
}
