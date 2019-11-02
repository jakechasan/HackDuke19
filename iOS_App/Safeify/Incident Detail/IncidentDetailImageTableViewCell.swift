//
//  IncidentDetailImageTableViewCell.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentDetailImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_image: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        self.cell_image.image = UIImage();
    }
}
