//
//  IncidentListViewController.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit
import MapKit

class IncidentListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var locationManager:CLLocationManager!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self;
        tableView.dataSource = self;
        
        let refreshControl = UIRefreshControl();
        tableView.refreshControl = refreshControl;
        refreshControl.addTarget(self, action: #selector(refreshIncidentData(_:)), for: .valueChanged);
        
        locationManager = CLLocationManager();
        locationManager.requestWhenInUseAuthorization();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        AppData.pullFromCloud {
            self.tableView.reloadData();
        };
        
        self.tableView.reloadData();
    }
    
    @objc func refreshIncidentData(_ sender:UIRefreshControl){
        AppData.pullFromCloud {
            self.tableView.reloadData();
        };
        
        sender.endRefreshing();
    }
    
    @IBAction func tapped_viewProfile(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Information", message: "2019 © Jake Chasan Apps\n\nAccount Information:", preferredStyle: .alert);
        
        alert.addTextField { (textField) in
            textField.text = AppData.username;
            
            textField.addTarget(self, action: #selector(self.usernameChanged(_:)), for: UIControl.Event.editingChanged);
        }
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil));
        
        self.present(alert, animated: true, completion: nil);
    }
    
    @objc func usernameChanged(_ textField: UITextField) {
        AppData.username = textField.text!;
    }
    
    @IBAction func tapped_addNewReport(_ sender: UIBarButtonItem) {
        
        let viewController = storyboard?.instantiateViewController(identifier: "IncidentReportTableViewController") as! IncidentReportTableViewController;
        
        let navigationController = UINavigationController(rootViewController: viewController);
        
        self.present(navigationController, animated: true, completion: nil);
    }
    
    @IBAction func tapped_orderApp(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Change Order", message: nil, preferredStyle: .actionSheet);
        
        let action_oldest = UIAlertAction(title: "Oldest First", style: .default, handler: { (action) in
            
            AppData.sortData(oldest: true);
            self.tableView.reloadData();
            
        });
        action_oldest.setValue(!AppData.newestFirst, forKey: "checked")

        alertController.addAction(action_oldest);
        
        let action_newest = UIAlertAction(title: "Newest First", style: .default, handler: { (action) in
            
            AppData.sortData(oldest: false);
            self.tableView.reloadData();
            
        });
        action_newest.setValue(AppData.newestFirst, forKey: "checked")
        alertController.addAction(action_newest);
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil));
        
        alertController.popoverPresentationController?.barButtonItem = sender;
        
        self.present(alertController, animated: true, completion: nil);
    }
}

extension IncidentListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let incidentDetail = storyboard?.instantiateViewController(withIdentifier: "IncidentDetailViewController") as! IncidentDetailViewController;
        incidentDetail.data = AppData.markers[indexPath.row];
        self.navigationController?.pushViewController(incidentDetail, animated: true);
        
        self.tableView.deselectRow(at: indexPath, animated: true);
    }
}

extension IncidentListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppData.markers.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentListTableViewCell") as! IncidentListTableViewCell;
        
        cell.imageView_icon.image = UIImage(named: AppData.getImageForData(AppData.markers[indexPath.row]).rawValue);
        
        cell.textView_title.text = AppData.markers[indexPath.row].Category;
        cell.textView_description.text = AppData.markers[indexPath.row].Comment;
        
        var span = MKCoordinateSpan();
        span.latitudeDelta = 0.5;
        span.longitudeDelta = 0.5;
        
        let offsetCoordinate = CLLocationCoordinate2D(latitude: AppData.markers[indexPath.row].Lat + 0.1, longitude: AppData.markers[indexPath.row].Long);
        
        let region = MKCoordinateRegion(center: offsetCoordinate, span: span);
        cell.mapView.setRegion(region, animated: false);
        
        let coordinate = CLLocationCoordinate2D(latitude: AppData.markers[indexPath.row].Lat, longitude: AppData.markers[indexPath.row].Long);

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
