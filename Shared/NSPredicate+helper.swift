//
//  NSPredicate+helper.swift
//  Slipbox
//
//  Created by Xiaochun Shen on 2021/3/10.
//

import Foundation
import CoreData

extension NSPredicate {
    static var all =  NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}

