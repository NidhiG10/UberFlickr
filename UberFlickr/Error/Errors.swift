//
//  Errors.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    
    case gateway(GatewayError)
    enum GatewayError {
        case invalidJSON
        case network(description: String)
        case unknown
    }
    
    case api(APIError)
    enum APIError {
        case noImage
        case invalidImageData
    }
}

extension Error {
    var localizedDescription: String {
        switch self {
            
        case .gateway(.invalidJSON):
            return NSLocalizedString("JSON in response is not valid.", comment: "Invalid JSON error message")
        case .gateway(.network(description: let description)):
            return description
            
            
        case .api(.noImage):
            return NSLocalizedString("No image.", comment: "Not enought images error message")
            
            
        default:
            return NSLocalizedString("Something went wrong.", comment: "Unknown error message")
        }
    }
}

extension Error: Equatable {
    static func == (l: Error, r: Error) -> Bool {
        switch (l, r) {
        case (.gateway(let lError), .gateway(let rError)):
            return lError == rError
            
        case (.api(let lError), .api(let rError)):
            return lError == rError
            
        default:
            return false
        }
    }
}

extension Error.GatewayError: Equatable {
    static func == (l: Error.GatewayError, r: Error.GatewayError) -> Bool {
        switch (l, r) {
        case (.invalidJSON, .invalidJSON),
             (.unknown, unknown):
            return true
            
        case let (.network(lDescription), .network(rDescription)):
            return lDescription == rDescription
            
        default:
            return false
        }
    }
}
