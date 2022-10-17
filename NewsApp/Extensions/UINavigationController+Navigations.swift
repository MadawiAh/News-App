//
//  UINavigationController+Navigations.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 12/01/1444 AH.
//

import UIKit

extension UINavigationController {
    
    func pushVC(storyboard: UIStoryboard, VCIdetifier: String, animated: Bool){
        let vc = storyboard.instantiateViewController(withIdentifier: VCIdetifier)
        pushViewController(vc, animated: animated)
    
    }
    
    func popToVC(VCIdetifier: String, animated: Bool){

        var vc = UIViewController()
        let viewControllersArray = self.viewControllers
        var i = 0

        while (i < viewControllersArray.count){

            // TODO: IF Duplicated VC which one will it take?
            if String(describing:type(of: viewControllersArray[i])) == VCIdetifier {
                vc = (viewControllersArray[i])
                popToViewController(vc, animated: animated)
            }
            i+=1
        }
    }
    
    // MARK: For Debugging
    // Printing the stack
        //    var controllers = self.viewControllers.compactMap({ String(describing: type(of: $0.self)) }).joined(separator: "_")
        //    print(controllers) //Output: "VC1_VC2_VC3"
}
