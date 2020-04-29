//
//  PhotoTableView.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit

class PhotoTableView: UITableView {
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func showTableView(in parentView: UIView) {
        self.register(VAPhotoGalleryCell.self)
        if self.superview == nil {
            self.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(self)
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
                self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                parentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                parentView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
        self.layoutIfNeeded()
    }
    
    private func removeTableView() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }
}

extension PhotoTableView: AddableRemovable {
    
    func addAsSubView(in parentView: UIView) {
        self.showTableView(in: parentView)
    }
    
    func removeAsSubView() {
        self.removeTableView()
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
