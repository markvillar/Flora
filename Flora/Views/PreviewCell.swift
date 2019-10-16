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

class PreviewCell: UICollectionViewCell {
    
    //MARK: - Property declarations
    
    let titleSize = 34 as CGFloat
    let activityIndicatorState = true
    
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
                imageBackground.image = UIImage(named: "noimage")
            }
            
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        return activityIndicator
    }()
    
    let overlayView: UIView = {
        let overlay = UIView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .white
        title.numberOfLines = 0
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
        article.textColor = .white
        article.numberOfLines = 0
        return article
    }()
    
    //MARK: - Method declarations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        clipsToBounds = true
        
        //Check if dark mode is enabled
        if traitCollection.userInterfaceStyle == .dark {
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = .zero
            layer.shadowRadius = 10
        }
        
        cellSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func cellSetup() {
        imageBackgroundSetup()
        titleSetup()
        showActivityIndicatorSetup()
    }
    
}

extension PreviewCell {
    
    override func prepareForReuse() {
        if activityIndicatorState {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}

extension PreviewCell {
    
    //MARK: - PreviewCell Constraints
    
    fileprivate func titleSetup() {
        contentView.addSubview(title)
        title.font = UIFont(name: "Avenir Next", size: titleSize)
        title.font = UIFont.boldSystemFont(ofSize: titleSize)
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.bounds.height/2 - 25).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18).isActive = true
        title.widthAnchor.constraint(equalToConstant: contentView.bounds.width).isActive = true
        
        articleSetup()
    }
    
    fileprivate func articleSetup() {
        contentView.addSubview(article)
        
        article.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        article.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive = true
        article.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18).isActive = true
        article.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18).isActive = true
        article.lineBreakMode = .byTruncatingTail
        article.textAlignment = .justified
    }
    
    fileprivate func imageBackgroundSetup() {
        contentView.addSubview(imageBackground)
        
        imageBackground.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    fileprivate func showActivityIndicatorSetup() {
        contentView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    fileprivate func overlayViewSetUp() {
        contentView.addSubview(overlayView)
        
        overlayView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
}

extension PreviewCell {
    
    func fetchImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
