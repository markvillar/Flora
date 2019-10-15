//
//  About.swift
//  Flora
//
//  Created by Mark on 05/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit

class About: UIViewController {
    
    //MARK: - Property declarations
    
    let profileImageSize = UIScreen.main.bounds.width - 100
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "profile")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let name: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Mark Villar"
        text.font = UIFont(name: "Avenir-Black", size: 40)
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        text.minimumScaleFactor = 24/40
        return text
    }()
    
    //MARK: - Function declarations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        setUpProfile()
        setupName()
        view.backgroundColor = .white
    }
    
    
}

//MARK: - Constraint declarations

extension About {
    
    fileprivate func setUpScrollView() {
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func setUpProfile() {
        scrollView.addSubview(profileImage)
        
        profileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: profileImageSize).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: profileImageSize).isActive = true
    }
    
    fileprivate func setupName() {
        scrollView.addSubview(name)
        
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12).isActive = true
        name.widthAnchor.constraint(equalTo: profileImage.widthAnchor).isActive = true
        name.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
}
