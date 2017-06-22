//
//  AddressSelectionVC.swift
//  SalonyTestApp
//
//  Created by Bohdan Shcherbyna on 6/21/17.
//  Copyright © 2017 Bohdan Shcherbyna. All rights reserved.
//

import UIKit
import GoogleMaps

class AddressSelectionVC: BaseViewController {
    
    enum ControllerSegue: String {
        case addAddress = "addNewAddress"
    }
    
    @IBOutlet var mapView: MapView!
    @IBOutlet var searchBarButtonItem: UIBarButtonItem!
    @IBOutlet var currentLocationButton: UIButton!
    
    private var titleView: UIView?
    private lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleView = navigationItem.titleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Add new address"
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controllerSegue = ControllerSegue(rawValue: segue.identifier!) else {
            assertionFailure("Applicatin trying to open segue, which not added to ControllerSegue enum.")
            return
        }
        switch controllerSegue {
        case .addAddress:
            if let address = sender as? Address {
                //Add address if exist
                let vc = segue.destination as! AddAddressVC
                vc.address = address
            }
        }
    }

    //MARK: - Actions
    @IBAction func skipButtonTouchUp(_ sender: Any) {
        self.performSegue(withIdentifier: ControllerSegue.addAddress.rawValue, sender: nil)
    }
    
    @IBAction func confirmButtonTouchUp(_ sender: Any) {
        self.showLoadingMask()
        let coordinateLocation = CLLocation(latitude: self.mapView.marker!.position.latitude, longitude: self.mapView.marker!.position.longitude)
        
        networkManager?.requestAddressInfo(withLocation: coordinateLocation) { (address, errorMessage) in
            self.dismissLoadingMask()
            if let error = errorMessage {
                self.displayAlert(message: error)
            } else {
                self.performSegue(withIdentifier: ControllerSegue.addAddress.rawValue, sender: address)
            }
        }
    }
    
    @IBAction func currentLocationTouchUp(_ sender: Any) {
        mapView.moveToCurentLocation()
    }
    
    @IBAction func searchBarButtonTouchUp(_ sender: Any) {
        if isSearchBarActive() {
            hideSearchBar()
        } else {
            showSearchBar()
        }
    }
    
    //MARK: - SearchBar
    private func isSearchBarActive() -> Bool {
        return navigationItem.titleView == self.searchBar
    }
    
    private func showSearchBar() {
        self.navigationItem.titleView = self.searchBar
        self.searchBarButtonItem.title = "Cancel"
        self.searchBarButtonItem.image = nil
    }
    
    private func hideSearchBar() {
        self.navigationItem.titleView = self.titleView
        self.searchBarButtonItem.title = nil
        self.searchBarButtonItem.image = UIImage(named: "search_icon")
    }
    
    func updateMapRegionWithSearchBarValue() {
        CLGeocoder().geocodeAddressString(self.searchBar.text!) { (placemark, error) in
            if let location = placemark?.first?.location, error == nil {
                self.mapView.moveCamera(to: location.coordinate)
            }
        }
    }
}

extension AddressSelectionVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .notDetermined, .denied:
            self.currentLocationButton.isHidden = true
        case .authorizedAlways, .authorizedWhenInUse:
            self.currentLocationButton.isHidden = false
        }
    }
}

extension AddressSelectionVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(AddressSelectionVC.updateMapRegionWithSearchBarValue), object: nil)
        self.perform(#selector(AddressSelectionVC.updateMapRegionWithSearchBarValue), with: nil, afterDelay: 0.5) //Start upgraiding map after 0.5 sec user inactivity.
    }
}
