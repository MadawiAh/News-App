//
//  UIViewController+Alerts.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 11/01/1444 AH.
//
import UIKit
import SVProgressHUD

extension UIViewController {
    
    // MARK: - Alert extention
    
    func presentAlert(title: String, message: String?, options: String..., style: UIAlertController.Style,completion: @escaping (Int) -> Void) {
       
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for (index, option) in options.enumerated() {
            
            var actionStyle: UIAlertAction.Style = .default
            if option.uppercased() == "CANCEL" {
                actionStyle = .cancel
            }
            
            alertController.addAction(UIAlertAction.init(title: option, style: actionStyle, handler: { (action) in
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
    
    // MARK: - Share URL extention
    
    func shareActivity (forURL url:String){
       
        guard let item = URL(string: url) else { return }
        
        let activityViewController = UIActivityViewController(
            activityItems: [item], applicationActivities: nil)
        
        activityViewController.isModalInPresentation = true
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - Open URL extention
    
    func openLink(forURL url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Show Error extension
    
    func showError(error: Error, completion: (()->Void)?){
        
        SVProgressHUD.setContainerView(view)
        if let apiError = error as? APIErrors {
            SVProgressHUD.show(UIImage(systemName: "xmark.circle")!, status: apiError.message)
        } else {
            SVProgressHUD.show(UIImage(systemName: "xmark.circle")!, status: error.localizedDescription)
        }
        completion?()
    }
}
