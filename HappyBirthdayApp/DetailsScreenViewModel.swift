//
//  DetailsScreenViewModel.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 05/12/2021.
//

import UIKit
import Combine

extension DetailsScreenViewController {
    class ViewModel {
        @Published var name: String?
        @Published var birthdayDate: Date?
        @Published var image: UIImage?
        private var cachingService: Service
        private var cancellables = Set<AnyCancellable>()
        
        init(service: Service) {
            self.cachingService = service
            
            // fetch the cached data
            name = cachingService.name
            birthdayDate = cachingService.birthday
            image = cachingService.image
            
            // store data when changes
            $name
                .dropFirst()
                .print()
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
