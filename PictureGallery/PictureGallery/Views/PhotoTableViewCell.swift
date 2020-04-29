//
//  PhotoTableViewCell.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit

protocol CellChildViewConfigurable where Self : UIView {
    func configure(with photo: Photos)
    func resetCell()
}

protocol CellConfigurable where Self : UITableViewCell {
    var childView: CellChildViewConfigurable { get }
    func addChildViewAsSubview()
}

class VAPhotoGalleryCell: UITableViewCell, CellConfigurable, ReusableView {
    
    lazy var childView: CellChildViewConfigurable = PhotosContentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addChildViewAsSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented!!!")
    }
    
    func addChildViewAsSubview() {

        self.contentView.addSubview(self.childView)
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            childView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: childView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: childView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        childView.resetCell()
    }

}

