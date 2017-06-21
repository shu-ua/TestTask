//
//  MapView.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/22/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView: UIView {
    
    lazy var map: GMSMapView = {
        var startCoordinates = CLLocationCoordinate2D(latitude: 29.364813, longitude: 47.982395)
        let camera = GMSCameraPosition.camera(withTarget: startCoordinates, zoom: 14.0)
        var map = GMSMapView.map(withFrame: self.frame, camera: camera)
        map.delegate = self
        map.isMyLocationEnabled = true

        return map
    }()
    
    private var marker:GMSMarker?
    
    //MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initMap()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initMap()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.map.frame = self.bounds //Update map frame on each container frame changes.
    }
    
    //MARK: - Init map
    func initMap() {
        marker = GMSMarker()
        marker!.icon = UIImage(named: "map_target_pin")
        marker!.map = map
        marker!.appearAnimation = .pop
        marker!.position = map.camera.target
        map.selectedMarker = marker
        
        self.addSubview(map)
    }
    
    func moveMarker(to coordinate: CLLocationCoordinate2D) {
        marker!.position = coordinate
    }
    
    func moveCamera(to coordinate: CLLocationCoordinate2D) {
        map.camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 14.0)
    }
    
    func moveToCurentLocation() {
        if let currentCoordinates = map.myLocation?.coordinate {
            self.moveCamera(to: currentCoordinates)
        }
    }
}

//MARK: - GMSMapViewDelegate
extension MapView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.moveMarker(to: coordinate)
    }
}
