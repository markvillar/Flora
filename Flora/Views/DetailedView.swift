//
//  DetailedView.swift
//  Flora
//
//  Created by Mark on 14/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit
import WebKit
import WikipediaKit

class DetailedView: UIViewController, WKUIDelegate {
    
    //MARK: - Property declarations
    
    let articleText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var previewArticle: WikipediaArticlePreview
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemBackground
        return scroll
    }()
    
    let imageHeader: UIImageView = {
        let header = UIImageView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .systemBackground
        header.contentMode = .scaleAspectFill
        return header
    }()
    
    let articleTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        //title.adjustsFontSizeToFitWidth = true
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 25, weight: .semibold)
        title.text = "No Article"
        title.backgroundColor = .systemBackground
        return title
    }()
    
    init(previewArticle: WikipediaArticlePreview) {
        
        self.previewArticle = previewArticle
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Function delcarations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScrollView()
        viewSetup()
    }
    
}

extension DetailedView {
    
    fileprivate func viewSetup() {
        Wikipedia.sharedFormattingDelegate = FormattingDelegate.shared
        
        self.articleTitle.text = previewArticle.displayTitle
        
        title = previewArticle.displayTitle
        
        if let imageURL = previewArticle.imageURL {
            
            fetchImage(from: imageURL) { [weak self] (data, response, error) in
                
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self?.imageHeader.image = UIImage(data: data)
                }
                
            }
            
        } else {
            imageHeader.image = UIImage(named: "noimage")
        }
        
        navigationBarSetUp()
        view.backgroundColor = .systemBackground
        
        getFullArticle(term: previewArticle.displayTitle) { [weak self] article in
            self?.articleText.attributedText = article.displayText.html2Attributed
        }
    }
    
    fileprivate func navigationBarSetUp() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    fileprivate func setUpScrollView() {
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setUpHeaderImage()
    }
    
    fileprivate func setUpHeaderImage() {
        scrollView.addSubview(imageHeader)
        
        imageHeader.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageHeader.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageHeader.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/2).isActive = true
        
        setUpTitle()
    }
    
    fileprivate func setUpTitle() {
        scrollView.addSubview(articleTitle)
        
        articleTitle.topAnchor.constraint(equalTo: imageHeader.bottomAnchor).isActive = true
        articleTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        articleTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        articleTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        webViewConstraints()
    }
    
    fileprivate func webViewConstraints() {
        scrollView.addSubview(articleText)
        
        articleText.topAnchor.constraint(equalTo: articleTitle.bottomAnchor).isActive = true
        articleText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        articleText.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        articleText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}

extension DetailedView {
    
    func getFullArticle(term: String, completion: @escaping (WikipediaArticle)->()) {
        
        let language = WikipediaLanguage("en")
        let imageWidth = Int(self.view.frame.size.width * UIScreen.main.scale)

        let _ = Wikipedia.shared.requestArticle(language: language, title: term, imageWidth: imageWidth) { article, error in
            guard error == nil else { return }
            guard let article = article else { return }
            completion(article)
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
