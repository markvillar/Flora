//
//  Marker.swift
//  Flora
//
//  Created by Mark on 06/02/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit
import MapKit
import WikipediaKit

class Marker: MKPointAnnotation {
    
    var articlePreview: WikipediaArticlePreview?
    
    init(place: MKPointAnnotation) {
        super.init()
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        super.init()
        self.coordinate = coordinate
    }
    
    init(wikipediaArticlePreview: WikipediaArticlePreview) {
        super.init()
        self.articlePreview = wikipediaArticlePreview
        
        let latitude = articlePreview?.coordinate?.latitude
        let longtitude = articlePreview?.coordinate?.longitude
        
        guard latitude != nil && longtitude != nil else { return }
        
        let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longtitude!)
        
        self.title = wikipediaArticlePreview.title
        
    }
    
}
