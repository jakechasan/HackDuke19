//
//  IncidentDetailDescriptionTableViewCell.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentDetailDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var textView_description: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        textView_description.text = "";
    }
}
