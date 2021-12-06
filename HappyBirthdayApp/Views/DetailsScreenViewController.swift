//
//  ViewController.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 04/12/2021.
//

import UIKit
import PhotosUI
import Combine

class DetailsScreenViewController: UIViewController {

    // MARK: -- Private variables
    private let viewModel = ViewModel(service: CachingService())
    private let imagePickerController: UIImagePickerController = .init()
    private var cancellables = Set<AnyCancellable>()

    // MARK: -- Outlets
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectPicture: UIButton!
    @IBOutlet weak var showBirthdayScreen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getInitialValues()
    }

    func setup() {
        name.delegate = self
        
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)

        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        
        viewModel.$showBirthdayScreenDisabled
            .assign(to: \.isEnabled, on: showBirthdayScreen)
            .store(in: &cancellables)
    }
    
    private func getInitialValues() {
        name.text = viewModel.name
        datePicker.date = viewModel.birthdayDate ?? Date()
    }
    
    @objc
    func datePickerChanged(picker: UIDatePicker) {
        // save date
        viewModel.birthdayDate = picker.date
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
        
        _ = [
            action(for: .camera, title: "Take photo"),
            action(for: .savedPhotosAlbum, title: "Camera roll"),
            action(for: .photoLibrary, title: "Photo library"),
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ]
        .compactMap { $0 }
        .map(alertController.addAction)
        
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let birthdayScreen = segue.destination as? BirthdayScreenViewController {
            
        }
    }
}

extension DetailsScreenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // save name
        viewModel.name = updatedText
        return true
    }
}

extension DetailsScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        // save image
        viewModel.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
