//
//  AddItemViewController.swift
//  JewelleryShop
//
//  Created by user217572 on 5/8/22.
//

import UIKit
import Gallery
//import JGProgressHUB
import NVActivityIndicatorView
import CoreMedia

class AddItemViewController: UIViewController {

    //MARK: IBOutlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: Vars
    
    var category: Category!
    var itemImages: [UIImage?] = []
    var gallery: GalleryController!
//    let hud = JGProgressHUD
    var activityIndicator: NVActivityIndicatorView?
    
    //MARK: View lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x:
            self.view.frame.width / 2 - 30,
                                                                  y:
                                                                    self.view.frame.height / 2 - 30, width: 60, height: 60),
                                                    type: .ballPulse, color: #colorLiteral(red: 0.999, green: 0.49, blue: 0.47, alpha: 1), padding: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: IBActions
    
    @IBAction func doneBarButtonItemPressed(_ sender: Any) {
        dismissKeyboard()
        
        if fieldsAreCompleted(){
            saveToFirebase()
        }else{
            print("Error all fields are required")
            
        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        itemImages = []
//      showImageGallery()  // functionalitate indiponibila
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
    }
    private func fieldsAreCompleted() -> Bool {
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    
    //MARK: Helper func
    
    private func dismissKeyboard(){
        self.view.endEditing(false)
    }
    
    private func popTheView(){
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: Save Item
    private func saveToFirebase(){
        
        showLoadingIndicator()
        
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.categoryId = category.id
        item.description = descriptionTextView.text
        item.price = Double(priceTextField.text!)
        
        if itemImages.count > 0{
            self.hideLoadingIndicator()
            self.popTheView()

        }else{
            saveItemToFirestore(item)
            
            popTheView()
            
        }
    }
}

extension AddItemViewController: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                self.itemImages = resolvedImages
            }
        }
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)

    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Activity Indicator
    private func showLoadingIndicator(){
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
        
    }
    
    private func hideLoadingIndicator(){
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
    
    //MARK: Show Gallery
    private func showImageGallery(){
        self.gallery = GalleryController()
        self.gallery.delegate = self
        
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        
        self.present(self.gallery, animated: true, completion: nil)
    }
}
