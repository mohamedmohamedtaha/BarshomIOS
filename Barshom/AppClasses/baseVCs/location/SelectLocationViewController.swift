//
//  SelectLocationViewController.swift
//  SharisalNew
//
//  Created by apple on 5/29/19.
//  Copyright © 2019 mohamed elatabany. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

protocol MapVCDelegate {
    func getCoordinatesBack(lat : String , lng : String ) -> Void
}
class SelectLocationViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate {
    
    @IBOutlet weak var mapReferece: MKMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var searchTF : NBSAutoCompletePlaceTextField!
    @IBOutlet weak var searchViewConstraints : NSLayoutConstraint!

    var delegate : MapVCDelegate!
    var CoordinateLat : String?
    var CoordinateLng : String?
    var lat : String?
    var long  :String?
    var latDouble: Double!
    var lngDouble: Double!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Resources.Login.useraddress
        self.searchTF.textAlignment = LanguageManager.isArabic ? .right : .left
        mapReferece.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.animateConstraintsChange(value: 70)
        searchTF.setPaddingPoints(10)
        searchTF.onTextChange = { data in
            self.animateConstraintsChange(value: 230)
            self.mapReferece.isUserInteractionEnabled = false
        }
        searchTF.onTextEnd = {
            
            self.animateConstraintsChange(value: 70)
            self.mapReferece.isUserInteractionEnabled = true
        }
        searchTF.onSelectPlaceID = { place , indexPath in
            print(place)
            self.mapReferece.isUserInteractionEnabled = true
            self.animateConstraintsChange(value: 70)
            GMSPlacesClient().lookUpPlaceID(place.placeID, callback: { (placeData, error) in
                self.searchTF.isEnabled = true
                if error == nil
                {
                    self.searchTF.text = placeData!.formattedAddress
                    
                    self.mapReferece.setCenter(placeData!.coordinate, animated: true)
                    
                }
                else
                {
//                    AppHelper.showInfoAlert(message: Resources.Common.invalidLocation)
                }
            })
            self.dismissKeyboard()
        }
    }
    
    func animateConstraintsChange(value: CGFloat)
    {
        self.searchViewConstraints.constant = value
    }
    @IBAction func selectActionButton(_ sender: Any) {
        delegate.getCoordinatesBack(lat: "\(mapReferece.centerCoordinate.latitude)", lng: "\(mapReferece.centerCoordinate.longitude)" )
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }

    
    
   
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.centerCoordinate.latitude)
        CoordinateLat = "\(mapView.centerCoordinate.latitude)"
        CoordinateLng = "\(mapView.centerCoordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
//        lat = "\(location!.coordinate.latitude)"
//        long = "\(location!.coordinate.longitude)"
//        CoordinateLat = "\(location!.coordinate.latitude)"
//        CoordinateLng = "\(location!.coordinate.longitude)"
//        self.locationManager.stopUpdatingLocation()
//        let locationn = CLLocationCoordinate2DMake(Double(lat!)!, Double(long!)!)
//        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let region = MKCoordinateRegion(center: locationn, span: span)
//        mapReferece.setRegion(region, animated: true)
        
        
        if let location = locations.last?.coordinate {
            CoordinateLat = "\(location.latitude)"
            CoordinateLng = "\(location.longitude)"
            self.lat = String(location.latitude)
            self.long = String(location.longitude)
            self.latDouble = location.latitude
            self.lngDouble = location.longitude
            
            self.setMapToCurrentLocation(lat: location.latitude
                , lang: location.longitude)
            self.locationManager.stopUpdatingLocation()
        }
    }
    @IBAction func cancelButAct(_ sender: Any) {
        self.dismiss(animated: true)

    }
    
//    @objc func doneBtnAction(_ sender: Any) {
//        delegate.getCoordinatesBack(lat: "\(mapReferece.centerCoordinate.latitude)", lng: "\(mapReferece.centerCoordinate.longitude)" )
//
//
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func getMyCurrentLocationButtonAction(_ sender: UIButton) {
        guard let lat = self.latDouble, let lang = self.lngDouble else { return }
        self.setMapToCurrentLocation(lat: lat, lang: lang)
    }
    
    
    func setMapToCurrentLocation(lat: Double, lang: Double) {
        let locationCordinate = CLLocationCoordinate2DMake(Double(lat), Double(lang))
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: locationCordinate, span: span)
        mapReferece.setRegion(region, animated: true)
    }
    
    
}

