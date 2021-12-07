//
//  Style.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 07/12/2021.
//

import UIKit

enum Style: CaseIterable {
    case elephant, fox, pelican
    
    func backgroudImage() -> UIImage {
        switch self {
        case .elephant: return UIImage(named: "bgElephant")!
        case .fox: return UIImage(named: "bgFox")!
        case .pelican: return UIImage(named: "bgPelican")!
        }
    }
    
    func cameraImage() -> UIImage {
        switch self {
        case .elephant: return UIImage(named: "cameraIconYellow")!
        case .fox: return UIImage(named: "cameraIconGreen")!
        case .pelican: return UIImage(named: "cameraIconBlue")!
        }
    }
    
    func placeholderImage() -> UIImage {
        switch self {
        case .elephant: return UIImage(named: "defaultPlaceHolderYellow")!
        case .fox: return UIImage(named: "defaultPlaceHolderGreen")!
        case .pelican: return UIImage(named: "defaultPlaceHolderBlue")!
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .elephant: return UIColor(red: 254/255, green: 239/255, blue: 203/255, alpha: 1.0)
        case .fox: return UIColor(red: 197/255, green: 232/255, blue: 223/255, alpha: 1.0)
        case .pelican: return UIColor(red: 218/255, green: 241/255, blue: 246/255, alpha: 1.0)
        }
    }
    
    func borderColor() -> UIColor {
        switch self {
        case .elephant: return UIColor(red: 254/255, green: 190/255, blue: 32/255, alpha: 1.0)
        case .fox: return UIColor(red: 111/255, green: 197/255, blue: 175/255, alpha: 1.0)
        case .pelican: return UIColor(red: 139/255, green: 211/255, blue: 228/255, alpha: 1.0)
        }
    }
}
