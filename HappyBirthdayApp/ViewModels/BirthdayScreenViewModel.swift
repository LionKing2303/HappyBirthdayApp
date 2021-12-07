//
//  BirthdayScreenViewModel.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 06/12/2021.
//

import UIKit

extension BirthdayScreenViewController {
    class ViewModel {
        var nameTitle: String {
            model.getNameTitle()
        }
        var age: UIImage {
            model.getAgeImage()
        }
        var measureTitle: String {
            model.getMeasureTitle()
        }
        var image: UIImage {
            if let image = model.image {
                return image
            }
            return style.placeholderImage()
        }
        var imageShouldBeClipped: Bool {
            model.image != nil
        }
        var cameraImage: UIImage {
            style.cameraImage()
        }
        var background: UIImage {
            style.backgroudImage()
        }
        var backgroundColor: UIColor {
            style.backgroundColor()
        }
        var borderColor: UIColor {
            style.borderColor()
        }
        
        @Published var style: Style = .elephant
        @Published var model: BirthdayModel
        
        init(model: BirthdayModel) {
            self.model = model
            self.style = Style.allCases.randomElement() ?? .elephant
        }
    }
}
