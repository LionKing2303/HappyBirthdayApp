//
//  DetailsScreenViewModel.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 05/12/2021.
//

import UIKit
import Combine

extension DetailsScreenViewController {
    final class ViewModel {
        @Published var name: String?
        @Published var birthdayDate: Date
        @Published var image: UIImage?
        @Published var showBirthdayScreenDisabled: Bool = true
        var birthdayModel: BirthdayModel {
            .init(name: name, birthdayDate: birthdayDate, image: image)
        }
        
        private var cachingService: Service
        private var cancellables = Set<AnyCancellable>()
        
        init(service: Service) {
            self.cachingService = service
            
            // fetch the cached data
            name = cachingService.name
            birthdayDate = cachingService.birthday ?? Date()
            image = cachingService.image
            
            // store data when changes
            $name
                .dropFirst()
                .sink { [weak self] name in
                    self?.storeName(name: name)
                }
                .store(in: &cancellables)
            $birthdayDate
                .dropFirst()
                .sink { [weak self] date in
                    self?.storeBirthday(date: date)
                }
                .store(in: &cancellables)
            $image
                .dropFirst()
                .sink { [weak self] uiImage in
                    self?.storeImage(uiImage: uiImage)
                }
                .store(in: &cancellables)
            
            // enable/disable the button based on inputs
            Publishers.CombineLatest($name, $birthdayDate)
                .map { (name, date) -> Bool in
                    if let name = name {
                        return !name.isEmpty
                    }
                    return false
                }
                .assign(to: \.showBirthdayScreenDisabled, on: self)
                .store(in: &cancellables)
        }
        
        private func storeName(name: String?) {
            cachingService.name = name
        }
        
        private func storeBirthday(date: Date?) {
            cachingService.birthday = date
        }
        
        private func storeImage(uiImage: UIImage?) {
            cachingService.image = uiImage
        }
    }
}
