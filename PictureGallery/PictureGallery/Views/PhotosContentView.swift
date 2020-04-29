//
//  PhotosContentView.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import Foundation
import UIKit

final class PhotosContentView: UIView {

    private var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let photoView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let photoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 18)
        label.textColor = UIColor.lightGray
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSubViews()
    }

    private func initSubViews() {
        self.addContentView()
        self.addTitleLabel()
        self.addPhotoView()
        self.addDescription()
    }

    private func addContentView() {
        self.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    func addTitleLabel() {
        self.contentView.addSubview(titleLabel)
        let marginGuide = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:marginGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            marginGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    func addPhotoView() {
        self.contentView.addSubview(photoView)
        let marginGuide = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            photoView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            marginGuide.trailingAnchor.constraint(equalTo: photoView.trailingAnchor),
            photoView.heightAnchor.constraint(equalToConstant: 150.0),

        ])
    }

    func addDescription() {
        self.contentView.addSubview(photoDescriptionLabel)
        let marginGuide = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            photoDescriptionLabel.topAnchor.constraint(equalTo:self.photoView.bottomAnchor, constant: 20),
            photoDescriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            marginGuide.trailingAnchor.constraint(equalTo: photoDescriptionLabel.trailingAnchor),
            marginGuide.bottomAnchor.constraint(greaterThanOrEqualTo: photoDescriptionLabel.bottomAnchor, constant: 20)
        ])
    }
}

extension PhotosContentView: CellChildViewConfigurable {
    
    func resetCell() {
        self.titleLabel.text = nil
        self.photoDescriptionLabel.text = nil
        self.photoView.cancelImageLoad()
        self.photoView.image = UIImage(named: "no-image-available-icon")!
    }
    
    func configure(with photo: Photos) {
        self.titleLabel.text = photo.title
        self.photoDescriptionLabel.text = photo.description
        self.updateThumbnail(with: photo)
    }
    
    private func updateThumbnail(with photo: Photos) {
        if let urlString = photo.imageUrl,
            let url = URL(string: urlString) {
            self.photoView.loadImage(at: url)
        }
    }
}

