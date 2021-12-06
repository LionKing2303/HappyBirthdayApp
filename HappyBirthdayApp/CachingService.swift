//
//  CachingService.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 05/12/2021.
//
import Foundation
import UIKit

protocol Service {
    var name: String? { get set }
    var birthday: Date? { get set }
    var image: UIImage? { get set }
}

class CachingService: Service {
    var name: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
        get {
            UserDefaults.standard.string(forKey: "name")
        }
    }
    var birthday: Date? {
        set {
            UserDefaults.standard.set(newValue, forKey: "date")
        }
        get {
            UserDefaults.standard.object(forKey: "date") as? Date
        }
    }
    var image: UIImage? {
        set {
            if let data = newValue?.pngData(),
               let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            {
                let filename = url.appendingPathComponent("image.png")
                DispatchQueue.global().async {
                    try? data.write(to: filename)
                }
            }
        }
        get {
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.png"),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                return image
            }
            return nil
        }
    }
}
