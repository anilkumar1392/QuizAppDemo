//
//  TableViewHelper.swift
//  QuizAppDemoTests
//
//  Created by mac on 28/03/21.
//

import Foundation
import UIKit

extension UITableView {
    func cell(at index : Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: index, section: 0))
    }
    func title(at row : Int) -> String?{
        return cell(at: row)?.textLabel?.text
    }
    func selectRow(at index : Int){
        let indePath = IndexPath(row: index, section: 0)
        selectRow(at: indePath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indePath)
    }
    func deselectRow(at index : Int){
        let indePath = IndexPath(row: index, section: 0)
        deselectRow(at: indePath, animated: false)
        delegate?.tableView?(self, didDeselectRowAt: indePath)
    }
}
