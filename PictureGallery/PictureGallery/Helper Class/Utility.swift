//
//  Utility.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit


extension UIColor {
    
    class func randomColor() -> UIColor {
        return UIColor(red: (Int.randomNumberLessThan250() / 255.0),
                       green: (Int.randomNumberLessThan250() / 255.0),
                       blue: (Int.randomNumberLessThan250() / 255.0),
                       alpha: 0.9)
    }
    
    class func colorFromHex(rgbValue:UInt32, alpha:Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

extension Int {
    static func randomNumberLessThan250() -> CGFloat {
        return CGFloat(Int.random(in: 0...250))
    }
}

extension UIStoryboard {
    
    class func instantiateViewcontroller<T>(ofType type: T.Type,
                                            fromStoryboard storyBoardName: String = "Main",
                                            andBundle bundle: Bundle = .main) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: bundle).instantiateViewController(withIdentifier: String(describing: type))
    }
}

protocol AddableRemovable {
    func addAsSubView(in parentView: UIView)
    func removeAsSubView()
}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension Result where Success == Data {
    func decoded<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
}

extension UIImageView {
    
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}

