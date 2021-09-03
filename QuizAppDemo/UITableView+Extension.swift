//
//  UITableView+Extension.swift
//  QuizAppDemo
//
//  Created by mac on 28/03/21.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(_ type : UITableViewCell.Type){
        let string = String(describing: type)
        register(UINib(nibName: string, bundle: nil), forCellReuseIdentifier: string)
    }
    
    func dequeueCell<T>(_ type : T.Type) -> T?{
        let string = String(describing: type)
        return dequeueReusableCell(withIdentifier: string) as? T
    }
}
