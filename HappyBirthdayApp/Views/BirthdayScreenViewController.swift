//
//  BirthdayScreenViewController.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 06/12/2021.
//

import UIKit

class BirthdayScreenViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareTheNews.backgroundColor = UIColor(red: 239/255, green: 123/255, blue: 123/255, alpha: 1.0)
        shareTheNews.layer.cornerRadius = shareTheNews.frame.height / 2
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
