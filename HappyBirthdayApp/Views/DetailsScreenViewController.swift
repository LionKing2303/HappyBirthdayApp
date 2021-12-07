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
    private let imagePicker = ImagePicker()
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
    
    
    
    @IBAction func selectPictureAction(_ sender: Any) {
        imagePicker.presentImagePicker(on: self) { [weak self] image in
            // save image
            self?.viewModel.image = image
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let birthdayScreen = segue.destination as? BirthdayScreenViewController {
            let vm = BirthdayScreenViewController.ViewModel(model: viewModel.birthdayModel, service: CachingService())
            birthdayScreen.setViewModel(viewModel: vm)
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
