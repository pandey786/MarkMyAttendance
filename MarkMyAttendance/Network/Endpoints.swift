//
//  Endpoints.swift
//  ViperSwiftSampleApp
//
//  Created by Durgesh Pandey on 30/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

struct API {
    static let railwaysBaseUrl = "http://api.railwayapi.com/v2"
    static let railwaysAPIKey = "gtcweb49l6"
    static let railwaysAPIKeyPath = "/apikey/\(railwaysAPIKey)"
    static let iTunesBaseUrl = "https://itunes.apple.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum ITunesMusicSearch: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/search?media=music&entity=song&term="
            }
        }
        
        public var url: String {
            
            switch self {
            case .fetch:
                return "\(API.iTunesBaseUrl)\(path)"
            }
        }
    }
    
    enum RailwaysRunningStatus: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/live/train/"
            }
        }
        
        public var url: String {
            
            switch self {
            case .fetch:
                return "\(API.railwaysBaseUrl)\(path)"
            }
        }
    }
    
    enum RailwaysRoute: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/route/train/"
            }
        }
        
        public var url: String {
            
            switch self {
            case .fetch:
                return "\(API.railwaysBaseUrl)\(path)"
            }
        }
    }
}
