//
//  Place.swift
//  Flora
//
//  Created by Mark on 02/06/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import Foundation
import WikipediaKit

struct Place {
    
    private var preview: WikipediaArticlePreview
    private var article: WikipediaArticle?
    
    init?(placeID: String, preview: WikipediaArticlePreview, article: WikipediaArticle?) {
        self.preview = preview
        
        if let fullArticle = article {
            self.article = fullArticle
        }

    }
    
}
