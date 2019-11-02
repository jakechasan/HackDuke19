//
//  IncidentListTableViewCell.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit
import MapKit

class IncidentListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView_icon: UIImageView!
    @IBOutlet weak var textView_title: UILabel!
    @IBOutlet weak var textView_description: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func prepareForReuse() {
        self.prepareForReuse();
        
        imageView?.image = nil;
        textView_title.text = "";
        textView_description.text = "";
    }
}
