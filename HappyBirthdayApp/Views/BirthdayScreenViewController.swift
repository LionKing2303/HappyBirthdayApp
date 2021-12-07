//
//  BirthdayScreenViewController.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 06/12/2021.
//

import UIKit
import Combine

class BirthdayScreenViewController: UIViewController {
    
    // MARK: -- Private variables
    private var viewModel: ViewModel?
    private let imagePicker = ImagePicker()
    private var cancellables = Set<AnyCancellable>()
    private var screenShot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.isOpaque, 3.0)
        // hide elements that are not reuired for the screen shot
        shareTheNews.isHidden = true
        camera.isHidden = true
        close.isHidden = true
        
        // render the view
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // show the elements back
        shareTheNews.isHidden = false
        camera.isHidden = false
        close.isHidden = false
        
        return image
    }
    
    // MARK: -- Outlets
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var age: UIImageView!
    @IBOutlet weak var measureTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var shareTheNews: UIButton!
    @IBOutlet weak var cameraCenterX: NSLayoutConstraint!
    @IBOutlet weak var cameraCenterY: NSLayoutConstraint!
    @IBOutlet weak var close: UIButton!
    
    func setViewModel(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.refreshImage
            .sink(receiveValue: { [weak self] _ in
                self?.setImage()
            })
            .store(in: &cancellables)
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        imagePicker.presentImagePicker(on: self) { [weak self] image in
            guard let image = image else { return }
            self?.viewModel?.updateImage(image: image)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareTheNewsButtonAction(_ sender: Any) {
        guard let screenShot = screenShot else { return }
        let activityViewController = UIActivityViewController(
            activityItems: [screenShot],
            applicationActivities: nil
        )
        present(activityViewController, animated: true)
    }
    
    func setupUI() {
        shareTheNews.backgroundColor = UIColor(red: 239/255, green: 123/255, blue: 123/255, alpha: 1.0)
        shareTheNews.layer.cornerRadius = shareTheNews.frame.height / 2
        positionCameraButton()

        nameTitle.text = viewModel?.nameTitle
        age.image = viewModel?.age
        measureTitle.text = viewModel?.measureTitle
        setImage()
        image.layer.borderWidth = 7.0
        image.layer.borderColor = viewModel?.borderColor.cgColor
        image.layer.cornerRadius = image.frame.size.width/2
        camera.setImage(viewModel?.cameraImage, for: .normal)
        background.image = viewModel?.background
        view.backgroundColor = viewModel?.backgroundColor
    }
    
    private func setImage() {
        image.image = viewModel?.image
        if viewModel?.imageShouldBeClipped == true {
            image.image = self.makeRoundImage(image: image)
        }
    }
    
    private func makeRoundImage(image: UIImageView) -> UIImage {
        let layer = CALayer()
        layer.frame = image.bounds
        layer.contents = image.image?.cgImage
        layer.masksToBounds = true

        layer.cornerRadius = image.frame.size.width/2

        UIGraphicsBeginImageContext(image.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    
    private func positionCameraButton() {
        let radius = image.frame.width / 2
        let offsetX = sin(45) * radius
        let offsetY = -(cos(45) * radius)
        cameraCenterX.constant = offsetX
        cameraCenterY.constant = offsetY
        view.layoutIfNeeded()
    }
}
