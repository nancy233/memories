//
//  FootMarkViewController.swift
//  Mom Zang
//
//  Created by nancy on 4/20/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import MapKit


class FootMarkViewContvarler:UIViewController, MKMapViewDelegate{
    
    var selectedPlace:String?
    
    
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Map.delegate = self
        
        for loc in locations.keys{
            let span = MKCoordinateSpanMake(10, 10)
            let region = MKCoordinateRegion(center:locations[loc]!, span:span)
            
            Map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title = loc
            
            annotation.coordinate = locations[loc]!
            
            Map.addAnnotation(annotation)
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedPlace = (view.annotation?.title)!
        performSegue(withIdentifier: "MapToScroll", sender: view)
        
        let selectedAnnotations = mapView.selectedAnnotations
        for annotation in selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: false)
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ScrollViewController {
            let annotationView = sender as! MKAnnotationView
            destination.selectedPlace = (annotationView.annotation?.title)!
            print(destination.selectedPlace!)
            
            //print(sender)
        }
        
        
        
    }
    
}
