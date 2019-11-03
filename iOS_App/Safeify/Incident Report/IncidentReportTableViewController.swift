//
//  IncidentReportTableViewController.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentReportTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView();
        
        self.tableView.allowsSelection = false;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "IncidentReportTextInputTableViewCell") as! IncidentReportTextInputTableViewCell;
            
            cell.textField.text = "";
            
            return cell;
        }
        else if(indexPath.row == 1) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "IncidentReportButtonTableViewCell") as! IncidentReportButtonTableViewCell;
            
            cell.buttonTappedAction = {
                let alert = UIAlertController(title: "test", message: "msg", preferredStyle: .alert);
                self.present(alert, animated: true, completion: nil);
            }
            
            return cell;
        }
        else {
            return UITableViewCell();
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            cell.becomeFirstResponder();
        }
    }
    
    @IBAction func tapped_buttonSubmit(_ sender: UIBarButtonItem) {
        
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func tapped_buttonCancel(_ sender: UIBarButtonItem) {
        
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
}
