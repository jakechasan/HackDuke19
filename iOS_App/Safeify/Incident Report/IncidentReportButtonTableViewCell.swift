//
//  IncidentReportButtonTableViewCell.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentReportButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_title: UILabel!
    @IBOutlet weak var cell_button: UIButton!
    
    var buttonTappedAction:(()->())!;
    
    @IBAction func button_tapped(_ sender: UIButton) {
        buttonTappedAction();
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        cell_title.text = "";
        cell_button.titleLabel?.text = "";
        buttonTappedAction = nil;
    }
}
