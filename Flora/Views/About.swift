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
    
    let socialStackView: UIStackView = {
        let socialStackView = UIStackView()
        socialStackView.alignment = .fill
        socialStackView.distribution = .fillEqually
        socialStackView.axis = .horizontal
        socialStackView.spacing = 10
        socialStackView.translatesAutoresizingMaskIntoConstraints = false
        return socialStackView
    }()
    
    let twitterButton: UIButton = {
        let twitterButton = UIButton()
        let twitterIcon = UIImage(named: "twitter")
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.setImage(twitterIcon, for: .normal)
        twitterButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        twitterButton.heightAnchor.constraint(equalTo: twitterButton.widthAnchor, multiplier: 1).isActive = true
        twitterButton.contentHorizontalAlignment = .fill
        twitterButton.contentVerticalAlignment = .fill
        twitterButton.addTarget(self, action: #selector(twitterButtonHandle), for: .touchUpInside)
        return twitterButton
    }()
    
    let githubButton: UIButton = {
        let githubButton = UIButton()
        let githubImage = UIImage(named: "github")
        githubButton.setImage(githubImage, for: .normal)
        githubButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        githubButton.heightAnchor.constraint(equalTo: githubButton.widthAnchor, multiplier: 1).isActive = true
        githubButton.contentHorizontalAlignment = .fill
        githubButton.contentVerticalAlignment = .fill
        githubButton.addTarget(self, action: #selector(githubButtonHandle), for: .touchUpInside)
        return githubButton
    }()
    
    let linkedinButton: UIButton = {
        let linkedinButton = UIButton()
        let linkedinIcon = UIImage(named: "linkedin")
        linkedinButton.setImage(linkedinIcon, for: .normal)
        linkedinButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        linkedinButton.heightAnchor.constraint(equalTo: linkedinButton.widthAnchor, multiplier: 1).isActive = true
        linkedinButton.contentHorizontalAlignment = .fill
        linkedinButton.contentVerticalAlignment = .fill
        linkedinButton.addTarget(self, action: #selector(linkedinButtonHandle), for: .touchUpInside)
        return linkedinButton
    }()
    
    let emailButton: UIButton = {
        let emailButton = UIButton()
        let emailIcon = UIImage(named: "email")
        emailButton.setImage(emailIcon, for: .normal)
        emailButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        emailButton.heightAnchor.constraint(equalTo: emailButton.widthAnchor, multiplier: 1).isActive = true
        emailButton.contentHorizontalAlignment = .fill
        emailButton.contentVerticalAlignment = .fill
        emailButton.addTarget(self, action: #selector(emailButtonHandle), for: .touchUpInside)
        return emailButton
    }()
    
    //MARK: - Function declarations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        setUpProfile()
        setupName()
        socialStackViews()
        view.backgroundColor = .systemBackground
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
    
    fileprivate func socialStackViews() {
        scrollView.addSubview(socialStackView)
        
        socialStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
        socialStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        socialStackView.addArrangedSubviews(twitterButton, githubButton, emailButton, linkedinButton)
    }
    
    @objc func twitterButtonHandle() {
        print("Twitter button is pressed")
    }
    
    @objc func githubButtonHandle() {
        print("GitHub button is pressed")
    }
    
    @objc func linkedinButtonHandle() {
        print("LinkedIn button is pressed")
    }
    
    @objc func emailButtonHandle() {
        print("Email button is pressed")
    }
    
}
