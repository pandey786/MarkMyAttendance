//
//  UserRecognitionModel.swift
//  MarkMyAttendance
//
//  Created by Durgesh Pandey on 21/11/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserRecognitionModel: Mappable {
    
    var images: [UserRecognitionImagesModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        images     <- map["images"]
    }
}

struct UserRecognitionImagesModel: Mappable {
    
    var candidates: [UserRecognitionCandidatesModel]?
    var transaction: UserRecognitionTransactionModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        candidates       <- map["candidates"]
        transaction     <- map["transaction"]
    }
}

struct UserRecognitionCandidatesModel: Mappable {
    
    var confidence: Double?
    var enrollment_timestamp: String?
    var face_id: String?
    var subject_id: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        confidence       <- map["confidence"]
        enrollment_timestamp     <- map["enrollment_timestamp"]
        face_id       <- map["face_id"]
        subject_id     <- map["subject_id"]
    }
}

struct UserRecognitionTransactionModel: Mappable {
    
    var confidence: Double?
    var eyeDistance: Double?
    var face_id: String?
    var gallery_name: String?
    var height: Double?
    var pitch: Double?
    var quality: Double?
    var roll: Double?
    var status: String?
    var subject_id: String?
    var enrollment_timestamp: String?
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
        pitch       <- map["pitch"]
        quality     <- map["quality"]
        roll       <- map["roll"]
        status     <- map["status"]
        subject_id       <- map["subject_id"]
        enrollment_timestamp     <- map["enrollment_timestamp"]
        topLeftX       <- map["topLeftX"]
        topLeftY     <- map["topLeftY"]
        width       <- map["width"]
        yaw     <- map["yaw"]
    }
}
