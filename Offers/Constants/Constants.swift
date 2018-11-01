//
//  Constants.swift
//  Offers
//
//  Created by Dean Thibault on 10/18/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import Foundation

// Static strings for accessing the json file

struct Constants {
	
	static let appDisplayName = "Offers"
	static let offer = "Offer"
	static let defaultDataFileName = "Offers"
	static let defaultFileExtension = "json"
	
	struct ButtonText {
		static let filter = "Liked"
		static let all = "All"
	}
	
	struct Message {
		static let emptyList = "No offers to display at this time."
	}

	struct Image {
		static let greenLiked = "GreenLiked"
		static let addButton = "AddButton"
		static let deleteButton = "DeleteButton"
		static let placeHolder = "OfferDefault"
	}
}
