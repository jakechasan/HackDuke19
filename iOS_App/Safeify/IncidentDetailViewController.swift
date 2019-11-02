//
//  ViewController.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit
import MapKit

class IncidentDetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var data:MarkerItem!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "\(data.Category) Incident Detail";
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        mapView.subviews[1].isHidden = true;
        mapView.subviews[2].isHidden = true;
    }
    
    //MARK: MAP Section
    
    func configureMap(){
        //map setup
        var span = MKCoordinateSpan();
        span.latitudeDelta = 0.5;
        span.longitudeDelta = 0.5;
        
        let coordinate = CLLocationCoordinate2D(latitude: data.Lat, longitude: data.Long);
        
        let region = MKCoordinateRegion(center: coordinate, span: span);
        mapView.setRegion(region, animated: false);
        
        let annotation = MKPointAnnotation();
        annotation.coordinate = coordinate;
        mapView.addAnnotation(annotation);
        
        mapView.mapType = .satellite;
        
        mapView.layer.cornerRadius = 25;
    }
    
    @IBAction func changeMapType(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Map Type", message: "Which map type would you like?", preferredStyle: .actionSheet);
        
        actionSheet.popoverPresentationController?.barButtonItem = sender;
        
        actionSheet.addAction(UIAlertAction(title: "Standard", style: .default, handler: { (action) in
            self.mapView.mapType = .standard;
        }));

        actionSheet.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { (action) in
            self.mapView.mapType = .hybrid;
        }));
        
        actionSheet.addAction(UIAlertAction(title: "Sattelite", style: .default, handler: { (action) in
            self.mapView.mapType = .satellite;
        }));
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil));
        
        self.present(actionSheet, animated: true, completion: nil);
    }
}

//MARK: Table View Section
