//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Christopher Ponce Mendez on 6/30/19.
//  Copyright © 2019 none. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
    
    struct Meme {
        let topText: String
        let bottomText: String
        let originalImage: UIImageView
        let memedImage: UIImage
        
        init(top: String, bottom: String, original: UIImageView, memed: UIImage) {
            topText = top
            bottomText = bottom
            originalImage = original
            memedImage = memed
        }
        
    }
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let memeTextAtributes:[NSAttributedString.Key:Any] = [
            
            NSAttributedString.Key.strokeColor:UIColor.black,
            NSAttributedString.Key.foregroundColor:UIColor.white,
            NSAttributedString.Key.font:UIFont(name: "Impact", size: 40)!,
            NSAttributedString.Key.strokeWidth:NSNumber(value: -3.0)
        ]
        //TOP textfield
        self.topTextField.delegate = self
        topTextField.text = "TOP"
        topTextField.defaultTextAttributes = memeTextAtributes
        topTextField.textAlignment = .center
        //BOTTOM text field
        self.bottomTextField.delegate = self
        bottomTextField.text = "BOTTOM"
        bottomTextField.defaultTextAttributes = memeTextAtributes
        bottomTextField.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        if imagePickerView.image == nil{
            shareButton.isEnabled = false
        }else{
            shareButton.isEnabled = true
        }
        
    }
    //saving the meme
    func save() {
        _ = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imagePickerView, memed: generateMemedImage())
    }
    
    //generating meme
    func generateMemedImage() -> UIImage {
        // hiding the toolbar and share button
        bottomToolBar.isHidden = true
        shareButton.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // showing the toolbar
        bottomToolBar.isHidden = false
        shareButton.isHidden = false
        return memedImage
    }
    
    
    
    //keyboard notification
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // getting keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    //showing the keyboard
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    //hiding keyboard
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    //actions
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let memedImage = generateMemedImage()
        
        let memeActivity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        
        memeActivity.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed == true {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Cancel was pressed")
            }
        }
        present(memeActivity,animated: true, completion: nil)
    }
    
    
    @IBAction func takeAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true, completion: nil)
    }
    
    @IBAction func grabImageWithCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker,animated: true, completion: nil)
    }
    
    // image picker functions
    
    //Tells the delegate that the user cancelled the pick operation
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerView.image = image
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text!.isEmpty{
            textField.text = ""
        }
        
        if textField.isSelected == topTextField.isSelected{
            print("something")
            unsubscribeFromKeyboardNotifications()
            bottomTextField.isSelected = true
        }else if textField.isSelected == bottomTextField.isSelected{
            print("not something")
            subscribeToKeyboardNotifications()
            topTextField.isSelected = true
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
}


