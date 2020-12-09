//
//  PackageTableViewCell.swift
//  FightCamp-Homework
//
//  Created by Edgar Delgado on 12/4/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {
    
    var imageViewDelegate: ImageViewTappedProtocol?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .brandRed
        label.font = .title
        label.textAlignment = .left
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .body
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .redraw
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        return imageView
    }()
    
    /// Small Image Views contain a tapGestureRecognizer
    lazy var firstSmallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 0
        imageView.contentMode = .redraw
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        imageView.layer.borderWidth = CGFloat.thumbnailBorderWidth
        imageView.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(firstImageViewSelected))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    lazy var secondSmallImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.tag = 1
        imageView.contentMode = .redraw
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        imageView.layer.borderWidth = CGFloat.thumbnailBorderWidth
        imageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(secondImageViewSelected))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    lazy var thirdSmallImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 2
        imageView.contentMode = .redraw
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        imageView.layer.borderWidth = CGFloat.thumbnailBorderWidth
        imageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(thirdImageViewSelected))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    lazy var fourthSmallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 3
        imageView.contentMode = .redraw
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat.thumbnailRadius
        imageView.layer.borderWidth = CGFloat.thumbnailBorderWidth
        imageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(fourthImageViewSelected))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    
    let punchTrackersLabel = UILabel()
    let quickWrapsLabel = UILabel()
    let freeStandingBagLabel = UILabel()
    let heavyWorkoutMatLabel = UILabel()
    let premiumBoxingGlovesLabel = UILabel()
    let additionalPremiumBoxingGlovesLabel = UILabel()
    let additionalQuickWrapsLabel = UILabel()
    let kidsBoxingGlovesLabel = UILabel()
    
    let paymentLabel = UILabel()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .price
        label.textAlignment = .center
        return label
    }()
    let viewPackageButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.buttonTitle, for: .normal)
        button.backgroundColor = .buttonBackground
        button.titleLabel?.font = .button
        button.layer.cornerRadius = CGFloat.buttonRadius
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .primaryBackground
        
        setupLabel(label: punchTrackersLabel)
        setupLabel(label: quickWrapsLabel)
        setupLabel(label: freeStandingBagLabel)
        setupLabel(label: heavyWorkoutMatLabel)
        setupLabel(label: premiumBoxingGlovesLabel)
        setupLabel(label: additionalPremiumBoxingGlovesLabel)
        setupLabel(label: additionalQuickWrapsLabel)
        setupLabel(label: kidsBoxingGlovesLabel)
        setupLabel(label: paymentLabel)
        addViewsToContentView()
        
        /// Assigns constraints and layout with the help of the anchor method
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: CGFloat.packageSpacing, paddingLeft: CGFloat.packageSpacing, paddingBottom: CGFloat.packageSpacing, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: CGFloat.packageSpacing, paddingLeft: CGFloat.packageSpacing, paddingBottom: CGFloat.packageSpacing, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        thumbnailImageView.anchor(top: descriptionLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: CGFloat.packageSpacing, paddingLeft: CGFloat.packageSpacing, paddingBottom: CGFloat.thumbnailSpacing, paddingRight: CGFloat.packageSpacing, width: 0, height: CGFloat.thumbnailHeight, enableInsets: false)
        
        /// Creates a stack view for the different image views to lay them out evenlly
        let imageViewsStackView = UIStackView(arrangedSubviews: [firstSmallImageView, secondSmallImageView, thirdSmallImageview, fourthSmallImageView])
        imageViewsStackView.distribution = .fillEqually
        imageViewsStackView.axis = .horizontal
        imageViewsStackView.spacing = CGFloat.thumbnailSpacing
        imageViewsStackView.backgroundColor = .black
        contentView.addSubview(imageViewsStackView)
        imageViewsStackView.anchor(top: thumbnailImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: CGFloat.thumbnailSpacing, paddingLeft: CGFloat.packageSpacing, paddingBottom: CGFloat.packageSpacing, paddingRight: CGFloat.packageSpacing, width: 0, height: CGFloat.thumbnailHeight/3, enableInsets: false)
        
        let labelsStackView = UIStackView(arrangedSubviews: [punchTrackersLabel, quickWrapsLabel, freeStandingBagLabel, heavyWorkoutMatLabel, premiumBoxingGlovesLabel, additionalPremiumBoxingGlovesLabel, additionalQuickWrapsLabel, kidsBoxingGlovesLabel])
        labelsStackView.distribution = .fillEqually
        labelsStackView.axis = .vertical
        labelsStackView.spacing = CGFloat.thumbnailSpacing
        contentView.addSubview(labelsStackView)
        labelsStackView.anchor(top: imageViewsStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: CGFloat.packageSpacing, paddingLeft: CGFloat.packageSpacing, paddingBottom: CGFloat.packageSpacing, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        let priceLabelsStackView = UIStackView(arrangedSubviews: [paymentLabel, priceLabel])
        priceLabelsStackView.distribution = .fillEqually
        priceLabelsStackView.axis = .vertical
        contentView.addSubview(priceLabelsStackView)
        priceLabelsStackView.anchor(top: labelsStackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: CGFloat.packageSpacing, paddingLeft: 0, paddingBottom: CGFloat.packageSpacing, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        priceLabelsStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        viewPackageButton.anchor(top: priceLabelsStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: leftAnchor, paddingTop: CGFloat.packageSpacing, paddingLeft: CGFloat.packageSpacing, paddingBottom: CGFloat.packageSpacing, paddingRight: CGFloat.packageSpacing, width: 0, height: CGFloat.buttonHeight, enableInsets: false)
        viewPackageButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel(label: UILabel) {
        label.textColor = .label
        label.font = .body
        label.textAlignment = .left
    }
    
    func addViewsToContentView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(firstSmallImageView)
        contentView.addSubview(secondSmallImageView)
        contentView.addSubview(thirdSmallImageview)
        contentView.addSubview(fourthSmallImageView)
        contentView.addSubview(punchTrackersLabel)
        contentView.addSubview(quickWrapsLabel)
        contentView.addSubview(freeStandingBagLabel)
        contentView.addSubview(heavyWorkoutMatLabel)
        contentView.addSubview(premiumBoxingGlovesLabel)
        contentView.addSubview(additionalPremiumBoxingGlovesLabel)
        contentView.addSubview(additionalQuickWrapsLabel)
        contentView.addSubview(kidsBoxingGlovesLabel)
        contentView.addSubview(paymentLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(viewPackageButton)
    }
    
    /// Every image view updates the border color if needed and delegates the tag number of the image view to the PackageViewController
    @objc func firstImageViewSelected() {
        firstSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
        secondSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        thirdSmallImageview.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        fourthSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor

        imageViewDelegate?.imageViewSelected(num: firstSmallImageView.tag)
    }
    
    @objc func secondImageViewSelected() {
        firstSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        secondSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
        thirdSmallImageview.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        fourthSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        
        imageViewDelegate?.imageViewSelected(num: secondSmallImageView.tag)
    }
    
    @objc func thirdImageViewSelected() {
        firstSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        secondSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        thirdSmallImageview.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
        fourthSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        
        imageViewDelegate?.imageViewSelected(num: thirdSmallImageview.tag)
    }

    @objc func fourthImageViewSelected() {
        firstSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        secondSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        thirdSmallImageview.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        fourthSmallImageView.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
        
        imageViewDelegate?.imageViewSelected(num: fourthSmallImageView.tag)
    }
}
