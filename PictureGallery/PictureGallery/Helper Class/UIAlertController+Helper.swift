//
//  UIAlertController+Helper.swift
//  PictureGallery
//
//  Created by Anuj Rai on 29/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit

extension UIAlertController {

    class func showNoRecordsPrompt(inParent parentController: UIViewController) {
       let title = "No Records"
       let message = "No record / records found."
       let switchBackToOnlineModeAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
       
       UIAlertController.showAlert(inParent: parentController,
                                   preferredStyle: .alert,
                                   withTitle: title,
                                   alertMessage: message,
                                   andAlertActions: [switchBackToOnlineModeAction])
   }
    
    private class func showAlert(inParent parent: UIViewController,
                                 preferredStyle style: Style,
                                 withTitle title: String,
                                 alertMessage message: String,
                                 andAlertActions actions: [UIAlertAction]?) {
        
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: style)
        
        if let alertActions = actions {
            _ = alertActions.map{ alertVC.addAction($0) }
        }
        
        parent.popoverPresentationController?.sourceView = parent.view
        parent.popoverPresentationController?.sourceRect = CGRect(x: parent.view.bounds.width / 2.0,
                                                                  y: parent.view.bounds.height / 2.0,
                                                                  width: 1.0,
                                                                  height: 1.0)
        
        parent.present(alertVC, animated: true, completion: nil)
    }

}
