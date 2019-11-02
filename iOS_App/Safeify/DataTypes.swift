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
    
    func getImageForData(type:String)->Icon{
        let types:[String:Icon] = [
            "Plumbing fault":Icon.water,
            "Electric fault":Icon.energy,
            "Ground fault":Icon.earth,
            "Structural fault":Icon.structure,
            "Biohazard":Icon.biohazard,
            "Fire hazard":Icon.fire,
            "Other":Icon.other
        ];
        
        return types[type] ?? Icon.other;
    }
    
    static func getData()-> [MarkerItem] {
        let sampleData:[MarkerItem] = [
            MarkerItem(Category: "Electrical fault", Comment: "This utility poll is on fire!", Img: "https://news.images.itv.com/image/file/908885/stream_img.jpg", Lat: 78.9382, Long: 36.0014, Timestamp: "2016-11-01T21:10:56Z", User: "jakechasan")
        ]
        
        return sampleData;
    }
}
