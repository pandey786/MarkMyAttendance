//
//  UserRegistrationModel.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserRegistrationModel: Mappable {
    
    var faceId: String?
    var images: [UserRegistrationImagesModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        faceId       <- map["face_id"]
        images     <- map["images"]
    }
}

struct UserRegistrationImagesModel: Mappable {
    
    var attributes: UserRegistrationAttributesModel?
    var transaction: UserRegistrationTransactionModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        attributes       <- map["attributes"]
        transaction     <- map["transaction"]
    }
}

struct UserRegistrationAttributesModel: Mappable {
    
    var age: Double?
    var asian: Double?
    var black: Double?
    var glasses: String?
    var hispanic: Double?
    var lips: String?
    var other: Double?
    var white: Double?
    var gender: UserGenderAttributesModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        age       <- map["age"]
        asian     <- map["asian"]
        black       <- map["black"]
        glasses     <- map["glasses"]
        hispanic       <- map["hispanic"]
        lips     <- map["lips"]
        other       <- map["other"]
        white       <- map["white"]
        gender       <- map["gender"]
    }
}

struct UserGenderAttributesModel: Mappable {
    
    var femaleConfidence: Double?
    var maleConfidence: Double?
    var type: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        femaleConfidence       <- map["femaleConfidence"]
        maleConfidence     <- map["maleConfidence"]
        type       <- map["type"]
    }
}

struct UserRegistrationTransactionModel: Mappable {
    
    var confidence: Double?
    var eyeDistance: Double?
    var face_id: String?
    var gallery_name: String?
    var height: Double?
    var image_id: Double?
    var pitch: Double?
    var quality: Double?
    var roll: Double?
    var status: String?
    var subject_id: String?
    var timestamp: String?
    var topLeftX: Double?
    var topLeftY: Double?
    var width: Double?
    var yaw: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        confidence       <- map["confidence"]
        eyeDistance     <- map["eyeDistance"]
        face_id       <- map["face_id"]
        gallery_name     <- map["gallery_name"]
        height       <- map["height"]
        image_id     <- map["image_id"]
        pitch       <- map["pitch"]
        quality     <- map["quality"]
        roll       <- map["roll"]
        status     <- map["status"]
        subject_id       <- map["subject_id"]
        timestamp     <- map["timestamp"]
        topLeftX       <- map["topLeftX"]
        topLeftY     <- map["topLeftY"]
        width       <- map["width"]
        yaw     <- map["yaw"]
    }
}
