//
//  ViewController.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 04/12/2021.
//

import UIKit
import PhotosUI

class DetailsScreenViewController: UIViewController {

    // MARK: -- Private variables
    private let imagePickerController: UIImagePickerController = .init()
    
    // MARK: -- Outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectPicture: UIButton!
    @IBOutlet weak var showBirthdayScreen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    func setup() {
        selectPicture.backgroundColor = .black
        selectPicture.setTitleColor(.white, for: .normal)
        selectPicture.layer.cornerRadius = selectPicture.frame.height / 2
        
        showBirthdayScreen.backgroundColor = .black
        showBirthdayScreen.setTitleColor(.white, for: .normal)
        showBirthdayScreen.layer.cornerRadius = showBirthdayScreen.frame.height / 2
        
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { _ in
            self.imagePickerController.sourceType = type
            self.present(self.imagePickerController, animated: true)
        }
    }
    
    @IBAction func selectPictureAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    @IBAction func showBirthdayScreenAction(_ sender: Any) {
    }
}

extension DetailsScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        
    }
}
