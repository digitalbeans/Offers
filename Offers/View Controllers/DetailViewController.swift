//
//  DetailViewController.swift
//  Offers
//
//  Created by Dean Thibault on 10/18/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

// Delegate protocol for observers to be notified when an offer is liked

protocol DidLikeOfferProtocol {
	
	func didLikeOffer()
}

// Offer details view
class DetailViewController: UIViewController {
	
	var offer: Offer?
	var likeDelegate: DidLikeOfferProtocol?
	private var nameLabel: UILabel?
	private var descriptionLabel: UILabel?
	private var termsLabel: UILabel?
	private var amountLabel: UILabel?
	private var imageView: UIImageView?
	private var mainStackView: UIStackView?
	private var scrollView: UIScrollView?
	private var likeButton: UIButton?
	private let addImage: UIImage? = UIImage(named: Constants.Image.addButton)
	private let deleteImage: UIImage? = UIImage(named: Constants.Image.deleteButton)
	
    override func viewDidLoad() {
		
        super.viewDidLoad()

		navigationItem.title = Constants.offer
		view.backgroundColor = .white
		
		setupViews()
		setFonts()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		setupData()
	}

	// setup subviews and autolayout constraints
	
	func setupViews() {
		
		scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
		let rect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30)
		nameLabel = UILabel(frame: rect)
		descriptionLabel = UILabel(frame: rect)
		termsLabel = UILabel(frame: rect)
		amountLabel = UILabel(frame: rect)
		imageView = UIImageView(frame: rect)
		likeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
		
		guard let id = offer?.id,
			  let nameLabel = nameLabel,
			  let descriptionLabel = descriptionLabel,
			  let termsLabel = termsLabel,
			  let amountLabel = amountLabel,
			  let imageView = imageView,
			  let button = likeButton else { return }
		
		button.layer.cornerRadius = button.frame.size.width
		button.tintColor = .black
		button.addTarget(self, action: #selector(handleAdd(sender:)), for: .touchUpInside)
		setButtonImage(isLiked: Favorites.shared.isFavorite(id: id))
		
		let labels = [nameLabel, descriptionLabel, amountLabel, termsLabel]
		mainStackView = UIStackView(arrangedSubviews:  [imageView, nameLabel, descriptionLabel, amountLabel, termsLabel])
		mainStackView?.axis = .vertical
		mainStackView?.alignment = .fill
		mainStackView?.distribution = .fillProportionally
		mainStackView?.spacing = 10.0
		
		if let scrollView = scrollView,
		   let mainStackView = mainStackView {
			
			view.addSubview(scrollView)
			scrollView.addSubview(button)
			scrollView.addSubview(mainStackView)
			
			button.translatesAutoresizingMaskIntoConstraints = false
			mainStackView.translatesAutoresizingMaskIntoConstraints = false

			scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

			button.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
			button.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
			button.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
			button.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 20).isActive = true

			mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
			mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
			mainStackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10).isActive = true
			mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
			mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
			mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20).isActive = true

			imageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
			imageView.contentMode = .scaleAspectFit
			
			labels.forEach({
				$0.widthAnchor.constraint(equalToConstant: view.frame.width - 50).isActive = true
				$0.numberOfLines = 0
				$0.sizeToFit()
			})
			
			button.widthAnchor.constraint(equalToConstant: 25).isActive = true
		}
	}
	
	// set up label fonts
	func setFonts() {
		
		nameLabel?.font = UIFont.avenirNextBold(ofSize: 15)
		descriptionLabel?.font = UIFont.avenirNextRegular(ofSize: 15)
		amountLabel?.font = UIFont.avenirNextRegular(ofSize: 12)
		termsLabel?.font = UIFont.avenirNextItalic(ofSize: 12)
	}
	
	// set offer data in view
	func setupData() {
		
		nameLabel?.text = offer?.name
		descriptionLabel?.text = offer?.description
		termsLabel?.text = offer?.terms
		amountLabel?.text = offer?.currentValue
		
		if let urlString = offer?.url, let url = URL(string: urlString) {
			imageView?.image(from: url)
		}
		
		view.setNeedsLayout()
		view.layoutIfNeeded()
	}
}

// Handle offer favoriting

extension DetailViewController {
	
	// add/delete favorite offer
	@objc func handleAdd(sender: UIButton) {
		
		guard let id = offer?.id else { return }
		
		if Favorites.shared.isFavorite(id: id) {
			Favorites.shared.removeFavorite(id: id)
			setButtonImage(isLiked: false)
		}
		else {
			Favorites.shared.addFavorite(id: id)
			setButtonImage(isLiked: true)
		}
		likeDelegate?.didLikeOffer()
	}
	
	// update the favorite button image based on whether offer is favorited
	func setButtonImage(isLiked: Bool) {
		
		if isLiked {
			likeButton?.setImage(deleteImage, for: .normal)
		}
		else {
			likeButton?.setImage(addImage, for: .normal)
		}
	}
}
