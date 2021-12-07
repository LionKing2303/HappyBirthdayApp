//
//  BirthdayScreenViewModel.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 06/12/2021.
//

import UIKit
import Combine

extension BirthdayScreenViewController {
    final class ViewModel {
        var nameTitle: String { model.getNameTitle() }
        var age: UIImage { model.getAgeImage() }
        var measureTitle: String { model.getMeasureTitle() }
        var image: UIImage { model.image ?? style.placeholderImage() }
        var imageShouldBeClipped: Bool { model.image != nil }
        var cameraImage: UIImage { style.cameraImage() }
        var background: UIImage { style.backgroudImage() }
        var backgroundColor: UIColor { style.backgroundColor() }
        var borderColor: UIColor { style.borderColor() }
        
        private(set) var refreshImage: PassthroughSubject<Void,Never> = .init()
        private var style: Style = Style.allCases.randomElement() ?? .elephant
        private var model: BirthdayModel
        private var cachingService: Service

        init(model: BirthdayModel, service: Service) {
            self.model = model
            self.cachingService = service
        }
        
        func updateImage(image: UIImage) {
            // save image
            cachingService.image = image
            // update the model
            model.setImage(image: image)
            // tell the view to refresh the image
            refreshImage.send()
        }
    }
}
