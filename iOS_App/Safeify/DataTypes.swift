//
//  MarkerItem.swift
//  Safeify
//
//  Created by Jake Chasan on 11/2/19.
//  Copyright © 2019 Jake Chasan. All rights reserved.
//

import Foundation
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

class AppData {
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
    
    static var markers:[MarkerItem] = [];
    
    static var username = "jakechasan";
    
    static func uploadImg(image:UIImage, filename:String, callback: @escaping (String)->()){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let riversRef = storageRef.child("images/\(filename).jpeg")
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return  };
        
        _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print(error.debugDescription);
                
                return
            }
            
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                
                callback(url!.absoluteString);
                
                guard url != nil else {
                    // Uh-oh, an error occurred!
                    return
                }
            }
        }
    }
  
    static func uploadNewMarker(marker: MarkerItem){
        var ref: DatabaseReference!;
        
        ref = Database.database().reference();
        
        ref.child("\(markers.count)").setValue(
            ["Category":marker.Category,
             "Comment":marker.Comment,
             "Img": marker.Img,
             "Lat":marker.Lat,
             "Lon":marker.Long,
             "Timestamp":marker.Timestamp,
             "User":AppData.username]);
    }
    
    static func getImageForData(_ item:MarkerItem)->Icon{
        return types[item.Category] ?? Icon.other;
    }
    
    static func pullFromCloud(_ callback: @escaping ()->()){
        var ref: DatabaseReference!;

        ref = Database.database().reference();
        ref.observeSingleEvent(of: .value) { ( snapshot) in

            markers.removeAll();
            
            if let values = snapshot.value as? [Any] {
                let number = values.count;
                
                print("Number of items from the cloud: \(number)");
                
                for value in values {
                    if let name = value as? [String:Any] {
                        var tmpMarker = MarkerItem(Category: "", Comment: "", Img: "", Lat: 0, Long: 0, Timestamp: "", User: "");
                        
                        if let comment = name["Comment"] as? String {
                            tmpMarker.Comment = comment;
                        }
                        if let category = name["Category"] as? String {
                            tmpMarker.Category = category;
                        }
                        if let img = name["Img"] as? String {
                            tmpMarker.Img = img;
                        }
                        if let lat = name["Lat"] as? Double {
                            tmpMarker.Lat = lat;
                        }
                        if let long = name["Lon"] as? Double {
                            tmpMarker.Long = long;
                        }
                        if let timestamp = name["Timestamp"] as? String {
                            tmpMarker.Timestamp = timestamp;
                        }
                        if let user = name["User"] as? String {
                            tmpMarker.User = user;
                        }
                        
                        markers.append(tmpMarker);
                    }
                }
                
                print("Number of items loaded: \(markers.count)");
                
                callback();
            }
            else{
                print("there has been an error");
            }
        }
    }
}
