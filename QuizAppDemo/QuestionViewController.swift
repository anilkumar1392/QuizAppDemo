//
//  QuestionViewController.swift
//  QuizAppDemo
//
//  Created by mac on 27/03/21.
//

import Foundation
import UIKit

class QuestionViewController : UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private(set) var question = ""
    private(set) var options = [String]()
    var selection : (([String]) -> Void)? = nil
    private let resueIdentifier = "cell"

    convenience init(question : String,options : [String],selection : @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
    }
}

extension QuestionViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeCell(in : tableView)
        cell.textLabel?.text = self.options[indexPath.row]
        return cell
    }

    func dequeCell(in table : UITableView) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: resueIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: resueIdentifier)
    }
}

extension QuestionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection{
            selection?(selectedOptions(in: tableView))
        }
    }
    func selectedOptions(in tableView : UITableView) -> [String] {
        guard let selcetdOptions = tableView.indexPathsForSelectedRows else {return []}
        return selcetdOptions.map({ options[$0.row] })
    }
}
