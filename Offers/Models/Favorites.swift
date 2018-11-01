//
//  Favorites.swift
//  Offers
//
//  Created by Dean Thibault on 10/20/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit


// Singleton class that holds a list of liked offers
class Favorites {
	
	static let shared = Favorites()
	var favorites: [String] = []
	
	// private instructor to prevent instantiation outiside of file
	private init () {
		
		// initializer
	}
	
	// add a favorite offer by id
	func addFavorite(id: String) {
		
		if !favorites.contains(id) {
			favorites.append(id)
		}
	}
	
	// remove a favorite offer by id
	func removeFavorite(id: String) {
		
		favorites = favorites.filter( { $0 != id } )
	}
	
	// Check if an offer is liked by id
	func isFavorite(id: String) -> Bool {
		
		return !favorites.filter( { $0 == id }).isEmpty
	}
}
