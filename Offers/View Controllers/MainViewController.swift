//
//  MainViewController.swift
//  Offers
//
//  Created by Dean Thibault on 10/18/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

// This is the main view for the app.Displays available offers in a collection view.

class MainViewController: UIViewController {
	
	private var collectionView: UICollectionView?
	private var offers: [Offer]?
	private var isFiltered = false
	
	override func viewDidLoad() {
		
        super.viewDidLoad()
		
		navigationItem.title = Constants.appDisplayName
		setupViews()
		loadData()
    }
	
	// load offer data
	fileprivate func loadData() {
		
		if let filePath = Bundle.main.url(forResource: Constants.defaultDataFileName, withExtension: Constants.defaultFileExtension) {
			
			DataLoader.loadDataFrom(url: filePath, completion: { [weak self] (result) in
				self?.offers = result
				self?.collectionView?.reloadData()
			})
		}

	}
	
	// Add subviews and autolayout constraints
	fileprivate func setupViews() {
		
		let collectionViewLayout = UICollectionViewFlowLayout()
		collectionViewLayout.minimumInteritemSpacing = 8
		collectionViewLayout.minimumLineSpacing = 24
		collectionViewLayout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
		
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
		view.addSubview(collectionView)
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		collectionView.backgroundColor = .white
		collectionView.register(OfferCollectionViewCell.self,
								forCellWithReuseIdentifier: OfferCollectionViewCell.identifier)
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		self.collectionView = collectionView
		
		view.addSubview(collectionView)
		
		// Add filter button
		let filterButton = UIBarButtonItem(title: Constants.ButtonText.filter, style: .plain, target: self, action: #selector(handleFilter(sender:)))
		filterButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.avenirNextDemiBold(ofSize: 20.0)], for: .normal)
		navigationItem.rightBarButtonItem = filterButton
	}
	
	var backgroundView: UIView {
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
		label.font = UIFont.avenirNextRegular(ofSize: 20)
		label.tintColor = UIColor.offerGray
		label.text = Constants.Message.emptyList
		label.textAlignment = .center
		
		return label
	}
}

// Collection view datastore and delegate functions

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		// get number of offers or number of liked offers, based on filtering flag
		var count = 0
		if isFiltered {
			count = Favorites.shared.favorites.count
		}
		else {
			count = offers?.count ?? 0
		}
		
		collectionView.backgroundView = count == 0 ? backgroundView : nil
		return count
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 100.0, height: 100.0) }
		let collectionViewInset = flowLayout.sectionInset.left + flowLayout.sectionInset.right
		let spacing = flowLayout.minimumInteritemSpacing
		let width = (collectionView.frame.size.width - spacing - collectionViewInset)/2
		
		return CGSize(width: width, height: width)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferCollectionViewCell.identifier, for: indexPath) as? OfferCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		// get coreect offer based on filtering flag
		if isFiltered {
			let id = Favorites.shared.favorites[indexPath.row]
			if let offer = offers?.filter( { $0.id == id}).first {
				cell.setupCell(offer: offer)
			}
		}
		else {
			if let offer = offers?[indexPath.row] {
				cell.setupCell(offer: offer)
			}
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		// get coreect offer based on filtering flag
		var offer: Offer?
		if isFiltered {
			let id = Favorites.shared.favorites[indexPath.row]
			offer = offers?.filter( { $0.id == id}).first
		}
		else {
			offer = offers?[indexPath.row]
		}

		guard let _ = offer else { return }
		
		let viewController = DetailViewController()
		viewController.offer = offer
		viewController.likeDelegate = self
		navigationController?.pushViewController(viewController, animated: true)
	}
}

// delegate function for notification when an offer is liked

extension MainViewController: DidLikeOfferProtocol {
	
	func didLikeOffer() {
		
		collectionView?.reloadData()
	}
}

// handle filtering

extension MainViewController {
	
	// when filter button is tapped set the flag, button text and reload the collection view
	@objc func handleFilter(sender: UIButton) {
		
		isFiltered = !isFiltered
		navigationItem.rightBarButtonItem?.title = isFiltered ? Constants.ButtonText.all : Constants.ButtonText.filter
		collectionView?.reloadData()
	}
}

