//
//  PreviewCell.swift
//  Flora
//
//  Created by Mark on 11/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit
import WikipediaKit

let language = WikipediaLanguage("en")

let cornerRadius:CGFloat = 15

class PreviewCell: UICollectionViewCell {
    
    //MARK: - Property declarations
    
    let titleSize = 34 as CGFloat
    
    var articlePreview: WikipediaArticlePreview? {
        didSet {
            
            guard let articlePreview = articlePreview else { return }
            
            title.text = articlePreview.displayTitle
            article.text = articlePreview.displayText
            
            if let imageURL = articlePreview.imageURL {
                
                fetchImage(from: imageURL) { [weak self] (data, response, error) in
                    
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        self?.imageBackground.image = UIImage(data: data)
                    }
                    
                }
                
            } else {
                imageBackground.image = nil
                
            }
            
        }
    }
    
    let contentContainerView: UIView = {
        let content = UIView()
        content.layer.cornerRadius = cornerRadius
        //content.layer.masksToBounds = true
        content.clipsToBounds = true
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    let overlayView: UIView = {
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.backgroundColor = .black
        overlay.alpha = 0.4
        return overlay
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .white
        title.numberOfLines = 2
        title.text = "No label"
        return title
    }()
    
    let imageBackground: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let article: UILabel = {
        let article = UILabel()
        article.translatesAutoresizingMaskIntoConstraints = false
        article.text = "No Article"
        article.font = UIFont(name: "SFUIText", size: 15)
        article.textColor = .white
        article.numberOfLines = 0
        return article
    }()
    
    //MARK: - Method declarations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = cornerRadius
        
        //Check if dark mode is enabled
        if traitCollection.userInterfaceStyle == .dark {
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.4
            layer.shadowOffset = .zero
            layer.shadowRadius = 8
        }
        
        cellSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func cellSetup() {
        setupContentContainerView()
        overlayViewSetUp()
        imageBackgroundSetup()
        titleSetup()
        articleSetup()
    }
    
}

extension PreviewCell {
    
    //MARK: - PreviewCell Constraints
    
    fileprivate func setupContentContainerView() {
        contentView.addSubview(contentContainerView)
        
        NSLayoutConstraint.activate([
            contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    fileprivate func overlayViewSetUp() {
        contentContainerView.addSubview(overlayView)
        
        overlayView.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        overlayView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
    }
    
    fileprivate func imageBackgroundSetup() {
        contentContainerView.insertSubview(imageBackground, belowSubview: overlayView)
        
        imageBackground.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
        imageBackground.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
        imageBackground.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        imageBackground.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor).isActive = true
    }
    
    fileprivate func titleSetup() {
        contentContainerView.addSubview(title)
        title.font = UIFont(name: "Avenir Next", size: titleSize)
        title.font = UIFont.boldSystemFont(ofSize: titleSize)
        
        title.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: contentView.bounds.height/2 - 25).isActive = true
        title.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 18).isActive = true
        title.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -18).isActive = true
        title.widthAnchor.constraint(equalToConstant: contentContainerView.bounds.width).isActive = true
    }
    
    fileprivate func articleSetup() {
        contentContainerView.addSubview(article)
        
        article.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        article.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 18).isActive = true
        article.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -18).isActive = true
        article.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -18).isActive = true
        article.lineBreakMode = .byTruncatingTail
        article.textAlignment = .natural
    }
    
    
}

extension PreviewCell {
    
    func fetchImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
