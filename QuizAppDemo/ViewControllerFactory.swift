//
//  ViewControllerFactory.swift
//  QuizAppDemo
//
//  Created by mac on 11/04/21.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question : Question<String>, answerCallback : @escaping ([String])->Void) -> UIViewController
    func resultsViewController(for question : Result<Question<String>,[String]>) -> UIViewController
}
