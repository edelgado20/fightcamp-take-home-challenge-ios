//
//  PackagesViewController.swift
//  FightCamp-Homework
//
//  Created by Edgar Delgado on 12/4/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit
/// Protocol used to identify which image thumbnail is selected
protocol ImageViewTappedProtocol {
    func imageViewSelected(num: Int)
}

class PackagesViewController: UIViewController {

    let tableView = UITableView()
    var safeArea = UILayoutGuide()
    var packages = [Package]() /// Packages loaded from the JSON file
    var imageViewSelected = 0 /// Index of the image currently displaying in the large ImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryBackground
        safeArea = view.layoutMarginsGuide
        
        tableView.dataSource = self
        setupTableView()
        tableView.rowHeight = 800.0
        tableView.layer.cornerRadius = CGFloat.packageRadius
        
        if let packages = loadJSON() {
            self.packages = packages
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        /// Constraints for the tableview
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24.0).isActive = true
        /// Register our custom table view cell
        tableView.register(PackageTableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension PackagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PackageTableViewCell else { fatalError("Unexpected Table View Cell") }
        cell.imageViewDelegate = self /// Assigns the delegate
        
        let viewModel = PackageViewModel(withPackage: packages[indexPath.row])
        
        cell.titleLabel.text = viewModel.title.uppercased()
        cell.descriptionLabel.text = viewModel.description.capitalized
        
        /// Displays image base on what imageView is selected
        switch imageViewSelected {
        case 0:
            cell.thumbnailImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[0])
        case 1:
            cell.thumbnailImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[1])
        case 2:
            cell.thumbnailImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[2])
        default:
            cell.thumbnailImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[3])
        }
        
        cell.firstSmallImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[0])
        cell.secondSmallImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[1])
        cell.thirdSmallImageview.image = viewModel.createImage(from: viewModel.thumbnailUrls[2])
        cell.fourthSmallImageView.image = viewModel.createImage(from: viewModel.thumbnailUrls[3])
        
        cell.punchTrackersLabel.text = viewModel.included[0].capitalized
        cell.quickWrapsLabel.text = viewModel.included[1].capitalized

        /// Displays the appropriate text and text format if its included in the package or not
        if viewModel.included.contains("free-standing bag") {
            cell.freeStandingBagLabel.text = viewModel.included[2].capitalized
        } else {
            cell.freeStandingBagLabel.attributedText = viewModel.createStrykeThroughString(with: "Free-Standing Bag")
            cell.freeStandingBagLabel.textColor = .disabledLabel
        }
        if viewModel.included.contains("heavy workout mat") {
            cell.heavyWorkoutMatLabel.text = viewModel.included[3].capitalized
        } else {
            cell.heavyWorkoutMatLabel.attributedText = viewModel.createStrykeThroughString(with: "Heavy Workout Mat")
            cell.heavyWorkoutMatLabel.textColor = .disabledLabel
        }
        if viewModel.included.contains("premium boxing gloves") {
            cell.premiumBoxingGlovesLabel.text = viewModel.included[4].capitalized
        } else {
            cell.premiumBoxingGlovesLabel.attributedText = viewModel.createStrykeThroughString(with: "Premium Boxing Gloves")
            cell.premiumBoxingGlovesLabel.textColor = .disabledLabel
        }
        if viewModel.included.contains("additional premium boxing gloves") {
            cell.additionalPremiumBoxingGlovesLabel.text = viewModel.included[5].capitalized
        } else {
            cell.additionalPremiumBoxingGlovesLabel.attributedText = viewModel.createStrykeThroughString(with: "Additional Premium Boxing Gloves")
            cell.additionalPremiumBoxingGlovesLabel.textColor = .disabledLabel
        }
        if viewModel.included.contains("additional quick wraps") {
            cell.additionalQuickWrapsLabel.text = viewModel.included[6].capitalized
        } else {
            cell.additionalQuickWrapsLabel.attributedText = viewModel.createStrykeThroughString(with: "Additional Quick Wraps")
            cell.additionalQuickWrapsLabel.textColor = .disabledLabel
        }
        if viewModel.included.contains("kids boxing gloves") {
            cell.kidsBoxingGlovesLabel.text = viewModel.included[7].capitalized
        } else {
            cell.kidsBoxingGlovesLabel.attributedText = viewModel.createStrykeThroughString(with: "Kids Boxing Gloves")
            cell.kidsBoxingGlovesLabel.textColor = .disabledLabel
        }

        cell.paymentLabel.text = viewModel.payment.capitalized
        cell.priceLabel.text = "$\(viewModel.price)"
        cell.viewPackageButton.setTitle(viewModel.action.capitalized, for: .normal)
        
        return cell
    }
}

extension PackagesViewController: ImageViewTappedProtocol {
    /// Retrives the index of image view that was selected and updates the tableview
    func imageViewSelected(num tagNumber: Int) {
        imageViewSelected = tagNumber
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
