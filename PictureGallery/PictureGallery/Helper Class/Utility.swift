//
//  Utility.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func instantiateViewcontroller<T>(ofType type: T.Type,
                                            fromStoryboard storyBoardName: String = "Main",
                                            andBundle bundle: Bundle = .main) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: bundle).instantiateViewController(withIdentifier: String(describing: type))
    }
}

