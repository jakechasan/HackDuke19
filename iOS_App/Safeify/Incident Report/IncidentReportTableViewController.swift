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
    var cell_selectImage:IncidentReportSelectImageTableViewCell?;
    
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
        
        return 4;
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
                
                for type in AppData.typesStrings {
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
                
                let alertController = UIAlertController(title: "Which source would you like to upload from?", message: nil, preferredStyle: .actionSheet);
                
                let action_takePhoto = UIAlertAction(title: "Take Photo with Camera", style: .default, handler: { (action) in
                    
                });
                action_takePhoto.setValue(UIImage(systemName: "camera"), forKey: "image");
                alertController.addAction(action_takePhoto);
                
                let action_photoLibrary = UIAlertAction(title: "Select from Photo Library", style: .default, handler: { (action) in
                    var pickerController = UIImagePickerController();
                    pickerController.delegate = self;
                    self.present(pickerController, animated: true, completion: nil);
                });
                action_photoLibrary.setValue(UIImage(systemName: "photo.on.rectangle"), forKey: "image");
                alertController.addAction(action_photoLibrary);
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil));
                
                self.present(alertController, animated: true, completion: nil);
            }
            
            return cell;
        }
        else if(indexPath.row == 3) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "IncidentReportSelectImageTableViewCell") as! IncidentReportSelectImageTableViewCell;
            
            cell_selectImage = cell;
            
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
        
        if(newMarker.Category == ""){
            let alertController = UIAlertController(title: "Please select a category", message: nil, preferredStyle: .alert);
            self.present(alertController, animated: true, completion: nil);
        }
        else if(newMarker.Comment == ""){
            let alertController = UIAlertController(title: "Please enter a comment", message: nil, preferredStyle: .alert);
            self.present(alertController, animated: true, completion: nil);
        }
        else if(newMarker.Img == ""){
            let alertController = UIAlertController(title: "Please select an image", message: nil, preferredStyle: .alert);
            self.present(alertController, animated: true, completion: nil);
        }
        else{
            let formatter = ISO8601DateFormatter();
            let timestamp = Date();
            let timestampString = formatter.string(from: timestamp);
            newMarker.Timestamp = timestampString;
            
            newMarker.User = AppData.username;
            
            AppData.uploadNewMarker(marker: newMarker);
            
            self.navigationController?.dismiss(animated: true, completion: nil);
        }
    }
    
    @IBAction func tapped_buttonCancel(_ sender: UIBarButtonItem) {
        
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
}

extension IncidentReportTableViewController:UINavigationControllerDelegate {
    
}

extension IncidentReportTableViewController:UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self.cell_selectImage!.imageView!.contentMode = .scaleAspectFit;
                    self.cell_selectImage!.imageView!.image = image;
                    
                    self.cell_selectImage?.setNeedsLayout();
                }
            }
        }
    }
}
