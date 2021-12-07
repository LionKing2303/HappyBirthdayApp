//
//  BirthdayScreenViewController.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 06/12/2021.
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
}

class BirthdayScreenViewController: UIViewController {
    
    // MARK: -- Private variables
    private var viewModel: ViewModel?
    
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
    
    func setViewModel(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func updateUI() {
        nameTitle.text = viewModel?.nameTitle
        age.image = viewModel?.age
        measureTitle.text = viewModel?.measureTitle
        image.image = viewModel?.image
        if viewModel?.imageShouldBeClipped == true {
            image.image = self.makeRoundImage(image: image)
        }
        camera.setImage(viewModel?.cameraImage, for: .normal)
        background.image = viewModel?.background
        
        
    }
    
    func makeRoundImage(image: UIImageView) -> UIImage {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareTheNews.backgroundColor = UIColor(red: 239/255, green: 123/255, blue: 123/255, alpha: 1.0)
        shareTheNews.layer.cornerRadius = shareTheNews.frame.height / 2
        
        updateUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
