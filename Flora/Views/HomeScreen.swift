//
//  HomeScreen.swift
//  Flora
//
//  Created by Mark on 04/10/2019.
//  Copyright © 2019 Mark Villar. All rights reserved.
//

import UIKit
import CoreLocation
import WikipediaKit

let potentialLocationCollectionCellIdentifier = "potentialCollectionCell"

class HomeScreen: UIViewController {
    
    var locationManager = CLLocationManager()
    lazy var zoomLevel: Float = 13.0
    
    let language = WikipediaLanguage("en")
    lazy var geocoder = CLGeocoder()
    
    lazy var totalPadding: CGFloat = 40
    
    //Location
    var potentialCollections: [WikipediaArticlePreview] = [] {
        didSet {
            reloadCollectionView(collectionView: potentialLocationCollection)
        }
    }
    
    var potentialLocationCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let location = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        location.isPagingEnabled = false
        location.translatesAutoresizingMaskIntoConstraints = false
        location.backgroundColor = .white
        return location
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        viewSetup()
        collectionViewDelegateDataSourceSetup()
        reusableCellRegistration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpPotentialLocationCollection()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewSetup()
    }
    
    fileprivate func reloadCollectionView(collectionView: UICollectionView) {
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
}

extension HomeScreen {
    
    fileprivate func collectionViewDelegateDataSourceSetup() {
        potentialLocationCollection.delegate = self
        potentialLocationCollection.dataSource = self
    }
    
    fileprivate func reusableCellRegistration() {
        potentialLocationCollection.register(PreviewCell.self, forCellWithReuseIdentifier: potentialLocationCollectionCellIdentifier)
    }
    
    fileprivate func viewSetup() {
        navigationItem.title = "Home Tab"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }
    
    fileprivate func scrollViewSetup() {
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        setUpPotentialLocationCollection()
    }
    
    fileprivate func setUpPotentialLocationCollection() {
        scrollView.addSubview(potentialLocationCollection)
        
        NSLayoutConstraint.activate([
            potentialLocationCollection.topAnchor.constraint(equalTo: scrollView.topAnchor),
            potentialLocationCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            potentialLocationCollection.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            potentialLocationCollection.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/1.5),
            potentialLocationCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
}

extension HomeScreen: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        potentialCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: potentialLocationCollectionCellIdentifier, for: indexPath) as! PreviewCell
        
        cell.articlePreview = potentialCollections[indexPath.row]
        
        return cell
    }
    
}


extension HomeScreen: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = potentialLocationCollection.bounds.width - totalPadding
        let cellHeight = potentialLocationCollection.bounds.height - totalPadding
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return totalPadding / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: totalPadding / 2, left: totalPadding / 2, bottom: totalPadding / 2, right: totalPadding / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedView = DetailedView(previewArticle: potentialCollections[indexPath.item])
        
        navigationController?.pushViewController(detailedView, animated: true)
    }
    
    
}

extension HomeScreen {
    
    func getNearbyArticles(location: CLLocation, completion: @escaping ([WikipediaArticlePreview])->()) {
        
        let language = WikipediaLanguage("en")
        
        let _ = Wikipedia.shared.requestNearbyResults(language: language, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, maxCount: 10, maxRadiusInMeters: 9000, imageWidth: 800, loadExtracts: true) { (articlePreviews, lnguage, error) in
            
            guard error == nil else { return }
            
            guard let articlePreviews = articlePreviews else { return }
            
            completion(articlePreviews)
            
        }
        
    }
    
}

//Location Controller
extension HomeScreen: CLLocationManagerDelegate {
    
    //Check if user have allowed access to device's location
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorisation()
        } else {
            //Location services is turned off, let the user know!
            Alert.locationServicesTurnedOff(on: self)
        }
    }
    
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.requestAlwaysAuthorization()
    }
    
    fileprivate func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            print("User Selected: Authorise When in Use")
        case .denied:
            print("User Denied Access to Location")
            Alert.locationServicesTurnedOff(on: self)
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            print("User hasn't selected any options yet")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            print("User Selected: Always Allow")
        case .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        print("Location Coordinate: \(location.coordinate)")
        
        getNearbyArticles(location: location) { [weak self] (articlePreviews) in
            for preview in articlePreviews {
                // Check if article is already in the list
                if (self?.potentialCollections.contains(preview))! { return } else {
                    self?.potentialCollections.append(preview)
                }
            }
        }
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemark, error) in
            if error == nil {
                self?.navigationItem.title = "\(String(describing: placemark!.first!.locality!))"
            }
        }
        
    }
    
    // Handle authorization for the location manager - This method is called whenever the application’s ability to use location services changes. Changes can occur because the user allowed or denied the use of location services for your application or for the system as a whole.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorisation()
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error in retrieving user location: \(error)")
    }
    
    
}
