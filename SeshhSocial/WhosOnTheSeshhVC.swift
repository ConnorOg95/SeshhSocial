//
//  WhosOnTheSeshhVC.swift
//  SeshhSocial
//
//  Created by User on 23/02/2017.
//  Copyright © 2017 OGCompany. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class WhosOnTheSeshhVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var geoFire: GeoFire!
    var mapHasCentredOnce = false
    var geoFireRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        geoFireRef = FIRDatabase.database().reference()
//         geoFireRef = REF_SESHHS.child("location")
        geoFire = GeoFire(firebaseRef: geoFireRef)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    // ENSURES CURRENT LOCATION MUST BE AUTHORISED WHEN IN USE
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // CHANGED AUTHORISATION STATUS TO TRUE
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    // THIS CENTRES MAP ON CURRENT LOCATION
    func centreMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // THIS CENTRES MAP ON CURRENT LOCATION WHEN MAP OPENS
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            if !mapHasCentredOnce {
                centreMapOnLocation(location: loc)
                mapHasCentredOnce = true
            }
        }
    }
    
    // THIS IS ANNOTATION FOR CURRENT LOCATION & SESHH MARKERS
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annoIdentifier = "Seshh"
        var annotationView: MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "profile1")
        } else if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier) {
            annotationView = deqAnno
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        // MAP MARKER ANNOTATION
        if let annotationView = annotationView, let anno = annotation as? SeshhAnnotation {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "\(anno.seshhNumber)")
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setImage(UIImage(named: "seshhlogo350frcropped"), for: .normal)
            annotationView.rightCalloutAccessoryView = btn
        }
        return annotationView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // CREATES SESHH LOCATION ON MAP
    func createSeshh(forLocaion location: CLLocation, withSeshh seshhId: Int) {
        
        geoFire.setLocation(location, forKey: "\(seshhId)")
    }
    
    // SHOWS SESHHS WITHIN A 2.5KM RADIUS OF LOCATION
    func showSightingsOnMap (location: CLLocation) {
        
        let circleQuery = geoFire!.query(at: location, withRadius: 2.5)
        
        _ = circleQuery?.observe(GFEventType.keyEntered, with: { (key, location) in
            
            if let key = key, let location = location {
                let anno = SeshhAnnotation(coordinate: location.coordinate, seshhNumber: Int(key)!)
                self.mapView.addAnnotation(anno)
            }
            
        })
        
    }
    
    // UPDATES SESHHS ON MAP WHEN PANNING
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        showSightingsOnMap(location: loc)
    }
    
    // BUTTON PRESSED ON CALLOUT ACCESSORY TO OPEN MAPS TO TRAVEL TO SESHH
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let anno = view.annotation as? SeshhAnnotation {
            let place = MKPlacemark(coordinate: anno.coordinate)
            let destination = MKMapItem(placemark: place)
            destination.name = "Seshh Location"
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
            
            MKMapItem.openMaps(with: [destination], launchOptions: options)
        }
        
    }
    
        
    // POSTS RANDOM SESHH MARKER TO MAP AT CENTRE OF SCREEN
    @IBAction func btnPressed(_ sender: Any) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        let rand = arc4random_uniform(5) + 1
        createSeshh(forLocaion: loc, withSeshh: Int(rand))
    }
}
