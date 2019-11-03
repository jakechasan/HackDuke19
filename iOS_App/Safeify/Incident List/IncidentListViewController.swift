//
//  IncidentListViewController.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class IncidentListViewController: UIViewController {
    
//    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self;
        tableView.dataSource = self;
        
        Data.startAFire();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.tableView.reloadData();
    }
    
    @IBAction func tapped_viewProfile(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "User Information", message: "Edit your account information.", preferredStyle: .alert);
        
        alert.addTextField { (textField) in
            textField.text = Data.username;
            
            textField.addTarget(self, action: #selector(self.usernameChanged(_:)), for: UIControl.Event.editingChanged);
        }
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil));
        
        self.present(alert, animated: true, completion: nil);
    }
    
    @objc func usernameChanged(_ textField: UITextField) {
        Data.username = textField.text!;
    }
    
    @IBAction func tapped_addNewReport(_ sender: UIBarButtonItem) {
        
        let viewController = storyboard?.instantiateViewController(identifier: "IncidentReportTableViewController") as! IncidentReportTableViewController;
        
        let navigationController = UINavigationController(rootViewController: viewController);
        
        self.present(navigationController, animated: true, completion: nil);
    }
}

extension IncidentListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let incidentDetail = storyboard?.instantiateViewController(withIdentifier: "IncidentDetailViewController") as! IncidentDetailViewController;
        incidentDetail.data = Data.getData()[indexPath.row];
        self.navigationController?.pushViewController(incidentDetail, animated: true);
        
        self.tableView.deselectRow(at: indexPath, animated: true);
    }
}

extension IncidentListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Data.getData().count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentListTableViewCell") as! IncidentListTableViewCell;
        
        cell.imageView_icon.image = UIImage(named: Data.getImageForData(Data.getData()[indexPath.row]).rawValue);
        
        cell.textView_title.text = Data.getData()[indexPath.row].Category;
        cell.textView_description.text = Data.getData()[indexPath.row].Comment;
        
        var span = MKCoordinateSpan();
        span.latitudeDelta = 0.5;
        span.longitudeDelta = 0.5;
        
        let coordinate = CLLocationCoordinate2D(latitude: Data.getData()[indexPath.row].Lat, longitude: Data.getData()[indexPath.row].Long);
        
        let region = MKCoordinateRegion(center: coordinate, span: span);
        cell.mapView.setRegion(region, animated: false);
        
        let annotation = MKPointAnnotation();
        annotation.coordinate = coordinate;
        cell.mapView.addAnnotation(annotation);
        
        cell.mapView.isUserInteractionEnabled = false;
        cell.mapView.mapType = .satellite;
        
        cell.mapView.layer.cornerRadius = 5;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! IncidentListTableViewCell;
        cell.mapView.subviews[1].isHidden = true;
    }
    
}
