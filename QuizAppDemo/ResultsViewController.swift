//
//  ResultsViewController.swift
//  QuizAppDemo
//
//  Created by mac on 28/03/21.
//

import Foundation
import UIKit

class ResultsViewController : UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var summary = ""
    var answers = [PresentableAnswer]()
    convenience init (summary : String,answers : [PresentableAnswer]){
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.headerLabel.text = self.summary
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.registerCell(CorrectAnswerCell.self)
        tableView.registerCell(WrongAnswerCell.self)
    }
}

extension ResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.answers[indexPath.row].wrongAnswer == nil {
            return configureCorrectAnswer(for: self.answers[indexPath.row])
        }
        return configureWrongAnswer(for: self.answers[indexPath.row])
    }
    
    func configureCorrectAnswer(for answer : PresentableAnswer) -> UITableViewCell{
        let cell = tableView.dequeueCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    func configureWrongAnswer(for answer : PresentableAnswer) -> UITableViewCell{
        let cell = tableView.dequeueCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}

extension ResultsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.answers[indexPath.row].wrongAnswer == nil ? 80 : 120
    }
}
