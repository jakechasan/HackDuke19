//
//  IncidentReportTableViewController.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentReportTableViewController: UITableViewController {

    var newMarker:MarkerItem!;
    
    var cell_comment:IncidentReportTextInputTableViewCell?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newMarker = MarkerItem(Category: "", Comment: "", Img: "", Lat: 0, Long: 0, Timestamp: "", User: "");
        
        self.tableView.tableFooterView = UIView();
        
        self.tableView.allowsSelection = false;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        _ = cell_comment?.becomeFirstResponder();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         1. Category
         2. Comment
         3. Photo
         */
        
        return 3;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "IncidentReportButtonTableViewCell") as! IncidentReportButtonTableViewCell;
            
            cell.cell_title.text = "Incident Category";
            
            var value = newMarker.Category;
            
            if(value == ""){
                value = "Select Category";
            }
            cell.cell_button.setTitle(value, for: .normal);
            
            cell.buttonTappedAction = {
                let actionSheet = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet);
                
                for type in Data.typesStrings {
                    let action = UIAlertAction(title: type, style: .default) { (action) in
                        self.newMarker.Category = type;
                        
                        cell.cell_button.setTitle(self.newMarker.Category, for: .normal);
                        
                        _ = self.cell_comment?.becomeFirstResponder();
                    };
                    
                    action.setValue((self.newMarker.Category == type), forKey: "checked")
                    
                    actionSheet.addAction(action);
                }
                
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil));
                
                if let popoverController = actionSheet.popoverPresentationController {
                    popoverController.sourceView = cell;
                    popoverController.sourceRect = cell.bounds;
                }
                
                self.present(actionSheet, animated: true, completion: nil);
            }
            
            return cell;
        }
        else if(indexPath.row == 1) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "IncidentReportTextInputTableViewCell") as! IncidentReportTextInputTableViewCell;
            
            cell.cell_titleLabel.text = "Comment";
            cell.textField.text = "";
            
            self.cell_comment = cell;
            
            return cell;
        }
        else if(indexPath.row == 2) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "IncidentReportButtonTableViewCell") as! IncidentReportButtonTableViewCell;
            
            cell.buttonTappedAction = {
                
                let pickerController = UIImagePickerController();
                
                self.present(pickerController, animated: true, completion: nil);
                
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
