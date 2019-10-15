//
//  TabBarController.swift
//  Flora
//
//  Created by Mark on 04/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var homeScreenController: UINavigationController = {
        var hc = UINavigationController(rootViewController: HomeScreen())
        
        hc.tabBarItem.title = "Home"
        hc.tabBarItem.image = UIImage(named: "list")
        return hc
    }()
    
    let mapController: MapController = {
        let mv = MapController()
        
        mv.tabBarItem.title = "Map"
        mv.tabBarItem.image = UIImage(named: "map")
        return mv
    }()
    
    let aboutController: About = {
        let about = About()
        
        about.tabBarItem.title = "About"
        about.tabBarItem.image = UIImage(named: "developer")
        return about
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
    }
    
    fileprivate func setUpViewControllers() {
        
        tabBar.isTranslucent = false
        
        let viewControllerList = [homeScreenController, mapController, aboutController]
        
        setViewControllers(viewControllerList, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
