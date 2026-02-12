//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Нурбол Мухаметжан on 12.02.2026.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
