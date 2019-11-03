//
//  MarkerItem.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import Foundation

struct MarkerItem: Codable {
    var Category: String
    var Comment: String
    var Img: String
    var Lat: Double
    var Long: Double
    var Timestamp: String
    var User: String
}

enum Icon: String {
    case biohazard = "biohazard"
    case earth = "earth"
    case energy = "energy"
    case fire = "fire"
    case structure = "structure"
    case water = "water"
    case other = "other"
}

class Data {
    
    static func getImageForData(_ item:MarkerItem)->Icon{
        let types:[String:Icon] = [
            "Plumbing Fault":Icon.water,
            "Electric Fault":Icon.energy,
            "Ground Fault":Icon.earth,
            "Structural Fault":Icon.structure,
            "Biohazard":Icon.biohazard,
            "Fire Hazard":Icon.fire,
            "Other":Icon.other
        ];
        
        return types[item.Category] ?? Icon.other;
    }
    
    static func getData()-> [MarkerItem] {
        let sampleData:[MarkerItem] = [
            MarkerItem(Category: "Electric Fault", Comment: "This utility poll is on fire!", Img: "https://news.images.itv.com/image/file/908885/stream_img.jpg", Lat: 78.9382, Long: 36.0014, Timestamp: "2016-11-01T21:10:56Z", User: "jakechasan")
        ]
        
        return sampleData;
    }
}
