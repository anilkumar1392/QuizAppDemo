//
//  AppDelegate.swift
//  QuizAppDemo
//
//  Created by mac on 27/03/21.
//

import UIKit
import QuizEngine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRootNavigation()
        //setupRootForResults()
        return true
    }

    func setupRootNavigation(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller = QuestionViewController(question: "What is your name?", options: ["Anil","Sunil","Rakesh"]) {
            print($0)
        }
        _ = controller.view
        controller.tableView.allowsMultipleSelection = false
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    func setupRootForResults(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller = ResultsViewController(summary: "Summary",answers: [
            PresentableAnswer(question: "First Question?", answer: "First Answer"),
            PresentableAnswer(question: "Second Questino?", answer: "Third Answer", wrongAnswer: "Hell wrong")
        ])
        _ = controller.view
        controller.tableView.allowsMultipleSelection = false
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

