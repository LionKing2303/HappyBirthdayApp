//
//  BirthdayModel.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 06/12/2021.
//

import Foundation
import UIKit

struct BirthdayModel {
    let name: String?
    let birthdayDate: Date?
    let image: UIImage?
    
    func getNameTitle() -> String {
        guard let name = name else { return "" }
        return "TODAY \(name.uppercased()) IS"
    }
    
    func getMeasureTitle() -> String {
        guard let date = birthdayDate else { return "" }
        let years = Date().years(from: date)
        if years == 0 {
            let months = Date().months(from: date)
            if months == 1 {
                return "MONTH OLD"
            } else if months > 1 {
                return "MONTHS OLD"
            }
        } else if years == 1 {
            return "YEAR OLD"
        } else {
            return "YEARS OLD"
        }
        return ""
    }
    
    func getAgeImage() -> UIImage {
        guard let date = birthdayDate else { return UIImage(named: "ageNumber0")! }
        let years = Date().years(from: date)
        if years == 0 {
            let months = Date().months(from: date)
            if (0...12).contains(months) {
                return UIImage(named: "ageNumber\(months)")!
            }
        } else if (0...12).contains(years) {
            return UIImage(named: "ageNumber\(years)")!
        }
        return UIImage(named: "ageNumber0")!
    }
}

extension Date {
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
}
