//
//  UIViewController+Alerts.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 11/01/1444 AH.
//

import UIKit
extension UIViewController {
    
    func presentAlertWithTitleAndMessage(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
    
    func shareActivity (forURL url:String){
       
        guard let item = URL(string: url) else { return }
        
        let activityViewController = UIActivityViewController(
            activityItems: [item], applicationActivities: nil)
        
        activityViewController.isModalInPresentation = true
        present(activityViewController, animated: true, completion: nil)
    }
    
}
