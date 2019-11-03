//
//  IncidentReportSelectImageTableViewCell.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit

class IncidentReportSelectImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_imageView: UIImageView!
    @IBOutlet weak var cell_imageStatus: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        cell_imageView.image = nil;
        cell_imageStatus.alpha = 0.0;
    }
}
