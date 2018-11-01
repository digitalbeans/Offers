//
//  DataLoader.swift
//  Offers
//
//  Created by Dean Thibault on 10/18/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation

// Functions for processing json file
class DataLoader {
	
	// Load and decode json from file and decode it
	static func loadDataFrom(url: URL, completion: (_ result: [Offer]?) -> Void) {

		do {
			
			// read the file from specified URL
			let data = try Data.init(contentsOf: url)
			
			do {
				let decoder = JSONDecoder()
				let offers = try decoder.decode([Offer].self, from: data)
				completion(offers)
			} catch {
				print("Error decoding type \([Offer].self);\n  \(error)")
				completion(nil)
			}
		} catch let error {
			print("Couldn't read to file: \(error)")
			completion(nil)
		}
	}
}
