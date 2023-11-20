//
//  LocationManager.swift
//  tree
//
//  Created by Sandesh Sharma on 18.11.23.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    var hasLocation: Bool {
        if lastLocation != nil {
            return true
        }
        return false
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        if status == .notDetermined {
            manager.requestWhenInUseAuthorization()
            
        }
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        print(#function, location)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
}
