//
//  Date+Months.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 07/12/2021.
//

import Foundation
extension Date {
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
}
