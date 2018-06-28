//
//  GatewayTests.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

import XCTest
@testable import UberFlickr

class GatewayTests: XCTestCase {
    
    var session: URLSessionMock!
    var gateway: Gateway!
    var request : NetworkRequest!
    
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        gateway = NetworkProvider(session: session)
        request = NetworkRequest(
            method: .GET,
            url: String(format: "http://mock"),
            parameters: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        
        session.data = nil
        session.errorResponse = nil
    }
    
    func testSuccessfulResponse() {
        session.data = "{\"status\": \"ok\"}".data(using: .utf8)
        
        let expectation = self.expectation(description: "successfulResponse")
        
        var responseJSON : [String: Any]?
        let _ = gateway.makeJSONRequest(request: request, success: { (json) in
            responseJSON = json
            expectation.fulfill()
        }, failure: { (error) in
            
        })
        
        waitForExpectations(timeout: 4, handler: nil)
        
        XCTAssertEqual(responseJSON?["status"] as! String, "ok")
    }
    
    func testInvalidResponse() {
        session.data = "<invalid json>".data(using: .utf8)
        
        let expectation = self.expectation(description: "InvalidData")
        
        var responseError : UberFlickr.Error?
        let _ = gateway.makeJSONRequest(request: request, success: { (json) in
            
        }, failure: { (error) in
            responseError = error
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4, handler: nil)
        
        XCTAssertEqual(responseError, Error.gateway(.invalidJSON))
    }
    
    func testUnSuccessfulResponse() {
        session.errorResponse = NSError(domain: "TEST",
                                        code: 999,
                                        userInfo: [NSLocalizedDescriptionKey : "Error description"])
        
        let expectation = self.expectation(description: "UnSuccessfulResponse")
        
        var responseError : UberFlickr.Error?
        let _ = gateway.makeJSONRequest(request: request, success: { (json) in
            
        }, failure: { (error) in
            responseError = error
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4, handler: nil)
        
        XCTAssertEqual(responseError?.localizedDescription, "Error description")
    }
    
    func testEmptyErrorResponse() {
        session.errorResponse = nil
        session.data = nil
        
        let expectation = self.expectation(description: "EmptyError")
        
        var responseError : UberFlickr.Error?
        let _ = gateway.makeJSONRequest(request: request, success: { (json) in
            
        }, failure: { (error) in
            responseError = error
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 4, handler: nil)
        
        XCTAssertEqual(responseError, Error.gateway(.unknown))
    }
    
}
