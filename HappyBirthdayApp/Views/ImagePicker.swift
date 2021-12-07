//
//  ImagePicker.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 07/12/2021.
//

import UIKit

final class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let imagePickerController: UIImagePickerController = .init()
    private var didFinishPicking: ((UIImage?)->Void)?
    private weak var viewController: UIViewController?
    
    override init() {
        super.init()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
    }
    
    func presentImagePicker(on viewController: UIViewController, didFinishPicking: ((UIImage?)->Void)?) {
        self.didFinishPicking = didFinishPicking
        self.viewController = viewController
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        _ = [
            action(for: .camera, title: "Take photo"),
            action(for: .savedPhotosAlbum, title: "Camera roll"),
            action(for: .photoLibrary, title: "Photo library"),
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ]
        .compactMap { $0 }
        .map(alertController.addAction)
        
        self.viewController?.present(alertController, animated: true)
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { _ in
            self.imagePickerController.sourceType = type
            self.viewController?.present(self.imagePickerController, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            self.didFinishPicking?(nil)
            return
        }
        
        self.didFinishPicking?(image.upOrientationImage())
        picker.dismiss(animated: true, completion: nil)
    }
}
