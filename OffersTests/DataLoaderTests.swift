//
//  DataLoaderTests.swift
//  OffersTests
//
//  Created by Dean Thibault on 10/20/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import XCTest
@testable import Offers

class DataLoaderTests: XCTestCase {
	
	let testFileFull = "OffersTest1"
	let testId = "110579"
	let testUrl = "https://product-images.ibotta.com/offer/dUxYcQPeq391-DiywFZF8g-normal.png"
	let testName = "Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges"
	let testDescription = "Any variety - 2 ct. pack or larger"
	let testTerms = "Rebate valid on Scotch-Brite® Scrub Dots Non-Scratch Scrub Sponges for any variety, 2 ct. pack or larger."
	let testCurrentValue = "$0.75 Cash Back"
	
	// test the data loader
    func testDataLoader() {

		// validate that the json file can be opened and data loaded
		guard let filePath = Bundle(for: type(of: self)).url(forResource: testFileFull, withExtension: Constants.defaultFileExtension) else {
			
			XCTFail("could not get path to json file")
			return
		}

		DataLoader.loadDataFrom(url: filePath, completion: { (result) in
			
			guard let offers = result else {
				
				XCTFail("offers should not be nil")
				return
			}
			
			// validate offers array is not empty
			XCTAssertFalse(offers.isEmpty, "offers should not be empty")
			
			// validate that the offers array is fully poplated
			XCTAssertEqual(132, offers.count, "count should match")
			
			// Validate offer data is correctly set
			XCTAssertEqual(testId, offers[0].id, "id should match")
			XCTAssertEqual(testUrl, offers[0].url, "id should match")
			XCTAssertEqual(testName, offers[0].name, "id should match")
			XCTAssertEqual(testDescription, offers[0].description, "id should match")
			XCTAssertEqual(testTerms, offers[0].terms, "id should match")
			XCTAssertEqual(testCurrentValue, offers[0].currentValue, "id should match")

			
		})
	}
}
