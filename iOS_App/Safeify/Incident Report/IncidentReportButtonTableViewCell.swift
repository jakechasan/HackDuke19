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
    
    var buttonTappedAction:(()->())!;
    
    @IBAction func button_tapped(_ sender: UIButton) {
        buttonTappedAction();
    }
}
