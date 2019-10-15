//
//  MapController.swift
//  Flora
//
//  Created by Mark on 04/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        setUpMapKit()
    }
    
    let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    fileprivate func viewSetup() {
        navigationItem.title = "Map View"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setUpMapKit() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
}
