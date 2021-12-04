//
//  ViewController.swift
//  HappyBirthdayApp
//
//  Created by Arie Peretz on 04/12/2021.
//

import UIKit

class DetailsScreenViewController: UIViewController {

    // MARK: -- Outlets
    @IBOutlet weak var selectPicture: UIButton!
    @IBOutlet weak var showBirthdayScreen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPicture.layer.borderWidth = 2.0
        selectPicture.layer.borderColor = UIColor.black.cgColor
        selectPicture.setTitleColor(.black, for: .normal)
        selectPicture.layer.cornerRadius = selectPicture.frame.height / 2
        
        showBirthdayScreen.layer.borderWidth = 2.0
        showBirthdayScreen.layer.borderColor = UIColor.black.cgColor
        showBirthdayScreen.setTitleColor(.black, for: .normal)
        showBirthdayScreen.layer.cornerRadius = showBirthdayScreen.frame.height / 2
    }


}

