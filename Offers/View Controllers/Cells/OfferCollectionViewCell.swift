//
//  OfferCollectionViewCell.swift
//  Offers
//
//  Created by Dean Thibault on 10/18/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

// Collection view cell for displaying offer
class OfferCollectionViewCell: UICollectionViewCell {
	
	private var imageView: UIImageView?
	private var imageBackgroundView: UIView?
	private var nameLabel: UILabel?
	private var amountLabel: UILabel?
	private var likedImageView: UIImageView?
	var offer: Offer?

	let defaultCornerRadios: CGFloat = 5.0
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		
		// add subviews
		contentView.layer.cornerRadius = defaultCornerRadios

		let rect = CGRect(x: 0, y: 0, width: frame.size.width, height: 30)
		nameLabel = UILabel(frame: rect)
		amountLabel = UILabel(frame: rect)
		imageView = UIImageView(frame: rect)
		imageView?.clipsToBounds = true
		imageView?.contentMode = .scaleAspectFit
		imageBackgroundView = UIView(frame: rect)
		imageBackgroundView?.backgroundColor = UIColor.offerLightGray
		imageBackgroundView?.layer.cornerRadius = defaultCornerRadios
		likedImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0))
		likedImageView?.clipsToBounds = true
		likedImageView?.contentMode = .scaleAspectFit
		likedImageView?.layer.cornerRadius = defaultCornerRadios

		// setup autolayout constraints for subviews
		contentView.translatesAutoresizingMaskIntoConstraints = false
		imageView?.translatesAutoresizingMaskIntoConstraints = false
		nameLabel?.translatesAutoresizingMaskIntoConstraints = false
		amountLabel?.translatesAutoresizingMaskIntoConstraints = false
		imageBackgroundView?.translatesAutoresizingMaskIntoConstraints = false
		likedImageView?.translatesAutoresizingMaskIntoConstraints = false

		setupLabels()

		guard let nameLabel = nameLabel,
			let amountLabel = amountLabel,
			let imageBackgroundView = imageBackgroundView,
			let imageView = imageView,
			let likedImageView = likedImageView else { return }
		
		contentView.addSubview(imageBackgroundView)
		contentView.addSubview(imageView)
		contentView.addSubview(amountLabel)
		contentView.addSubview(nameLabel)
		contentView.addSubview(likedImageView)

		imageBackgroundView.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
		imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		imageBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
		imageBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		imageBackgroundView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height - 44.0).isActive = true

		imageView.widthAnchor.constraint(equalToConstant: frame.size.width - 12).isActive = true
		imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 6).isActive = true
		imageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: 6).isActive = true
		imageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: -6).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height - 56.0).isActive = true

		amountLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 8).isActive = true
		amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
		amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		amountLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true

		nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 3).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
		nameLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true

		likedImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		likedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
		likedImageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
		likedImageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

		
		backgroundColor = .white
	}
	
	required init?(coder aDecoder: NSCoder) {
		
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		imageView?.image = nil
		nameLabel?.text = ""
		amountLabel?.text = ""
		offer = nil
	}
	
	// set offer data in cell
	func setupCell(offer: Offer) {
		
		self.offer = offer
		nameLabel?.text = offer.name
		amountLabel?.text = offer.currentValue
		
		contentView.setNeedsLayout()
		contentView.layoutIfNeeded()

		if let id = offer.id {
			setFavoriteIndicator(isLiked: Favorites.shared.isFavorite(id: id))
		}

		guard let urlString = offer.url, let url = URL(string: urlString) else { return }
		
		imageView?.image(from: url)
	}
	
	// setup label appearance
	func setupLabels() {
		
		nameLabel?.numberOfLines = 1
		nameLabel?.tintColor = .offerGray
		nameLabel?.font = UIFont.avenirNextRegular(ofSize: 11)

		amountLabel?.numberOfLines = 1
		amountLabel?.tintColor = .offerGray
		amountLabel?.font = UIFont.avenirNextDemiBold(ofSize: 12)
	}
	
	// convience method for returning reuse identifier same as class name
	override var reuseIdentifier: String? {
		
		return OfferCollectionViewCell.identifier
	}
	
	static var identifier: String {
		
		return String(describing: self)
	}
	
	// set favorite indicator 
	func setFavoriteIndicator(isLiked: Bool) {
		
		if isLiked {
			likedImageView?.image = UIImage(named: Constants.Image.greenLiked)
		}
		else {
			likedImageView?.image = nil
		}
	}
}
