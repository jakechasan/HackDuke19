//
//  MarkerItem.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

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
    static let typesStrings = [
        "Plumbing Fault",
        "Electric Fault",
        "Ground Fault",
        "Structural Fault",
        "Biohazard",
        "Fire Hazard",
        "Other"
    ];
    
    static let types:[String:Icon] = [
        "Plumbing Fault":Icon.water,
        "Electric Fault":Icon.energy,
        "Ground Fault":Icon.earth,
        "Structural Fault":Icon.structure,
        "Biohazard":Icon.biohazard,
        "Fire Hazard":Icon.fire,
        "Other":Icon.other
    ];
    
    static var username = "jakechasan";
    static func uploadImg(image:UIImage){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mountainImagesRef = storageRef.child("images/mountains.jpg")
        let data = Data()

    }
    
    static func startAFire() {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
              ref.child("M2").setValue(["Category":"Fire Hazard", "Comment":"My Mixtape yo gang gang", "Img": "imageaddr","Lat":0.0,"Lon":0.0,"Timestamp":"1997-07-16T19:20+01:00","User":"Aparimeya"])
              ref.child("M2").observeSingleEvent(of: .value) { ( snapshot) in
                  let name = snapshot.value as? [String:Any]
                  print(name)
                  
                  let comment = name!["Comment"] as! String;
                  let category = name!["Category"] as! String;
                  let img = name!["Img"] as! String;
                  let lat = name!["Lat"] as! Double;
                  let long = name!["Lon"] as! Double;
                  let timestamp = name!["Timestamp"] as! String;
                  let user = name!["User"] as! String;
                  
                  let newMarker = MarkerItem(Category: category, Comment: comment, Img: img, Lat: lat, Long: long, Timestamp: timestamp, User: user)
              }
    }
    static func getImageForData(_ item:MarkerItem)->Icon{
       
        
        return types[item.Category] ?? Icon.other;
    }
    
    static func getData()-> [MarkerItem] {
        let sampleData:[MarkerItem] = [
            MarkerItem(Category: "Electric Fault", Comment: "This utility pole is on fire!", Img: "https://news.images.itv.com/image/file/908885/stream_img.jpg", Lat: 78.9382, Long: 36.0014, Timestamp: "2016-11-01T21:10:56Z", User: "jakechasan")
        ]
        
        return sampleData;
    }
}
