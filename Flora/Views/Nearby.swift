//
//  Nearby.swift
//  Flora
//
//  Created by Mark on 04/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit

class Nearby: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        view.backgroundColor = .red
    }
    
    fileprivate func viewSetup() {
        navigationItem.title = "Nearby Places"
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
