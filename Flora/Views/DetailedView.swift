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
    
    var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        return webView
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
        title.font = .systemFont(ofSize: 25, weight: .semibold)
        title.text = "No Article"
        title.backgroundColor = .systemBackground
        return title
    }()
    
    let articleContent: UILabel = {
        let content = UILabel()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        content.textAlignment = .natural
        content.font = UIFont(name: "Helvetica", size: 20)
        content.text = "No Content"
        content.backgroundColor = .systemBackground
        return content
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
        view.backgroundColor = .systemBackground
        
        self.articleTitle.text = previewArticle.displayTitle
        self.articleContent.text = previewArticle.displayText
        
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
    }
    
    fileprivate func navigationBarSetUp() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
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
        
        setUpContent()
    }
    
    fileprivate func setUpContent() {
        scrollView.addSubview(articleContent)
        
        articleContent.topAnchor.constraint(equalTo: articleTitle.bottomAnchor).isActive = true
        articleContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        articleContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        webViewConstraints()
    }
    
    fileprivate func webViewConstraints() {
        scrollView.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: articleContent.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        webView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}

extension DetailedView {
    
    func fetchImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
