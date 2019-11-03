//
//  IncidentReportTextInputTableViewCell.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentReportTextInputTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse();
        
        textField.text = "";
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder();
        
        textField.becomeFirstResponder();
        
        return true;
    }
}
