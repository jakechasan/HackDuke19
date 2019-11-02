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
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView();
        self.tableView.allowsSelection = false;
        
        configureMap();
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

extension IncidentDetailViewController:UITableViewDelegate {
    
}

extension IncidentDetailViewController:UITableViewDataSource {
    
    /*
    1. Incident Type: right detail
    2. Incident Time: right detail
    3. Utility Status: right detail
    4. Descripton: custom expandable
    5. Image: custom image cell
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) { //incident type
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "nil");
            
            cell.textLabel?.text = "Incident Type";
            cell.detailTextLabel?.text = data.Category;
            
            return cell;
        }
        else if (indexPath.row == 1) { //incident time
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "nil");
            
            cell.textLabel?.text = "Incident Time";
            
            let isoDateFormatter = ISO8601DateFormatter();
            let timestamp = isoDateFormatter.date(from: data.Timestamp);
            
            let formatter = DateFormatter();
            formatter.dateFormat = "EEE, MMM d, yyyy # h:mm a";
            var formattedString = formatter.string(from: timestamp!);
            formattedString = formattedString.replacingOccurrences(of: "#", with: "at");
            
            cell.detailTextLabel?.text = formattedString;
            
            return cell;
        }
        else if (indexPath.row == 2) { //utility status
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "nil");
            
            cell.textLabel?.text = "Utility Status";
            
            let statuses = ["Utility Alerted", "Maintenance In Progress", "3 Days Until Fixed", "5 Days Until Fixed", "False Report"];
            cell.detailTextLabel?.text = statuses.randomElement();
            
            return cell;
        }
        else if (indexPath.row == 3) { //description
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentDetailDescriptionTableViewCell") as! IncidentDetailDescriptionTableViewCell;
            
            cell.textView_description.text = data.Comment;
            
            return cell;
        }
        else if (indexPath.row == 4) { //image
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentDetailImageTableViewCell") as! IncidentDetailImageTableViewCell;
            
            cell.cell_image.downloadImageFrom(link: data.Img, contentMode: .scaleAspectFit);
            
            return cell;
        }
        else {
            return UITableViewCell();
        }
    }
}
