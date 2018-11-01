//
//  File.swift
//  Offers
//
//  Created by Dean Thibault on 10/20/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

// convenience functions for returning app specific fonts
extension UIFont {
	
	static func avenirNextBold(ofSize size: CGFloat) -> UIFont {
		
		return UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
	}

	static func avenirNextDemiBold(ofSize size: CGFloat) -> UIFont {
		
		return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
	}

	static func avenirNextRegular(ofSize size: CGFloat) -> UIFont {

		return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
	}
	
	static func avenirNextItalic(ofSize size: CGFloat) -> UIFont {

		return UIFont(name: "AvenirNext-Italic", size: size) ?? UIFont.systemFont(ofSize: size)
	}
}
