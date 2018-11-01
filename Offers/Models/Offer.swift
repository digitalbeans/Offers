//
//  Offer.swift
//  Offers
//
//  Created by Dean Thibault on 10/18/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation

// Struct to represent the values of an Offer
// Subclasses Decodable for use in decoding json

struct Offer: Decodable {
	
	// maps to json elements
	enum CodingKeys: String, CodingKey {
		case id
		case url
		case name
		case description
		case terms
		case currentValue = "current_value"
	}

	
	let id: String?
	let url: String?
	let name: String?
	let description: String?
	let terms: String?
	let currentValue: String?
	
}


