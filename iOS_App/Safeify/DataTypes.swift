//
//  MarkerItem.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import Foundation

struct MarkerItem: Codable {
    var Img: String
    var Lat: Double
    var Long: Double
    var Category: String
    var Timestamp: String
    var Description: String
}


class Data {
    static func getData()-> [MarkerItem] {
        let sampleData:[MarkerItem] = [
            MarkerItem(Img: "https://news.images.itv.com/image/file/908885/stream_img.jpg", Lat: 36.0014, Long: 78.9382, Category: "Utility Poll", Timestamp: "1997-07-16T19:20+01:00", Description: "This utility poll is on fire!")
        ]
        
        return sampleData;
    }
}