//
//  ViewController.swift
//  Project16 - Capital Cities
//
//  Created by Travis Brigman on 6/30/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    @IBAction func changeMapType(_ sender: Any) {
        let ac = UIAlertController(title: "Choose Map Type", message:
                                    nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { (map) in
            self.mapView.mapType = .satellite
        }))
        
        ac.addAction(UIAlertAction(title: "Satellite with Roads", style: .default, handler: { (map) in
            self.mapView.mapType = .hybrid
        }))
        
        ac.addAction(UIAlertAction(title: "muted", style: .default, handler: { (map) in
            self.mapView.mapType = .mutedStandard
        }))
        present(ac, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over 1000 years ago")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it")
        let washington = Capital(title: "Washington, D.C.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.03667), info: "Named after George himself")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .cyan
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        /*
         guard let capital = view.annotation as? Capital else { return }
         let placeName = capital.title
         let placeInfo = capital.info
         let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default))
         present(ac, animated: true)
         */
        guard let capital = view.annotation as? Capital else { return }
        // 1: try loading the "Web" view controller and typecasting it to be WebViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "webView") as? WebViewController {
            // 2: success! Set its selectedImage property
            vc.selectedCapital = capital.title
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

