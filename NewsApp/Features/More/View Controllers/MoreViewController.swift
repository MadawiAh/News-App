//
//  MoreViewController.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 18/01/1444 AH.
//

import UIKit

class MoreViewController: UIViewController{
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editImageBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logOut: UIButton!
    
    let theme: AppTheme = NewsAppTheme()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleElements()
        setUpElements()
        
    }
    
    private func styleElements(){
        view.backgroundColor = theme.color.viewsBackgroundColor
        
        profileImage.makeRounded()
        
        editImageBtn.makeRounded()
        editImageBtn.backgroundColor = theme.color.orangeDarkColorEB652B
        editImageBtn.layer.borderColor = UIColor.white.cgColor
        editImageBtn.layer.borderWidth = 3
        editImageBtn.imageView?.tintColor = .white
        
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowPath = UIBezierPath(roundedRect:shadowView.layer.frame ,cornerRadius:shadowView.layer.frame.width/2).cgPath;
        shadowView.layer.shadowColor = theme.color.grayDarkColor343B3C.cgColor
        shadowView.layer.shadowOffset = CGSize(width: -139, height:-80)
        shadowView.layer.shadowOpacity = 0.4
        
        
        emailLabel.textColor = theme.color.grayMediumColor546062
        emailLabel.font = theme.font.titleThreeFont
        
        theme.styleSecondaryButton(logOut)
        logOut.backgroundColor = theme.color.grayLightColor9fa1a1.withAlphaComponent(0.2)
    }
    
    private func setUpElements(){
        emailLabel.text = UserDefaults.standard.string(forKey:"email")
        // set up the profile image
        
        imagePicker.delegate = self
    }
    
    // MARK: User Actions
    
    @IBAction func editImageTapped(_ sender: Any) {
        editImage()
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        /// 1. update defaults
        UserDefaults.standard.set(false, forKey: "isLogged")
        
        /// 2. navigation
        let landingVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LandingViewController")
        landingVC.hidesBottomBarWhenPushed = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(landingVC, animated: true)
    }
}

extension MoreViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    
    // MARK: UIImagePicker Methods
    
    func editImage() {
        self.view.window?.rootViewController?.presentAlert(title: "Choose an Image", message: nil, options: "Camera", "Photo Album", "Cancel", style: .actionSheet) { option in
            if option == 0 {
                self.openCamera()
            }
            if option == 1 {
                self.openPhotoAlbum()
            }
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            self.view.window?.rootViewController?.presentAlert(title: "Warning", message: "NewsApp don't have permission to access camera", options: "OK", style: .alert) { (_) in }
        }
    }
    
    func openPhotoAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            self.view.window?.rootViewController?.presentAlert(title: "Warning", message:  "NewsApp don't have permission to access photo album", options: "OK", style: .alert) { (_) in }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        profileImage.image = image
    }
}
