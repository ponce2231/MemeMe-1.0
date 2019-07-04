//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Christopher Ponce Mendez on 6/30/19.
//  Copyright © 2019 none. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
//    MARK: Meme structure model
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
    //MARK: outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTextField(textfield: topTextField, text: "TOP")
        setupTextField(textfield: bottomTextField, text: "BOTTOM")
        
        shareButton.isEnabled = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
        
        if imagePickerView.image == nil{
            changingBGcolorView(color: .white)
        }else{
            changingBGcolorView(color: .black)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    func changingBGcolorView(color: UIColor) {
        imagePickerView.backgroundColor = color
    }
    
    //MARK: setting up textfields
    func setupTextField(textfield:UITextField, text: String){
        
        let memeTextAtributes:[NSAttributedString.Key:Any] = [
            
            NSAttributedString.Key.strokeColor:UIColor.black,
            NSAttributedString.Key.foregroundColor:UIColor.white,
            NSAttributedString.Key.font:UIFont(name: "Impact", size: 40)!,
            NSAttributedString.Key.strokeWidth:NSNumber(value: -3.0)
        ]
        
        textfield.delegate = self
        textfield.defaultTextAttributes = memeTextAtributes
        textfield.textAlignment = .center
        textfield.text = text
        
    }
    
    
    
    //MARK: saving the meme
    func save() {
        _ = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imagePickerView, memed: generateMemedImage())
    }
    
    //MARK generating meme
    func generateMemedImage() -> UIImage {
        // hiding the toolbar and share button
        bottomToolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // showing the toolbar
        bottomToolBar.isHidden = false
        return memedImage
    }
    
    
    
    //MARK: keyboard notification
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
        if bottomTextField.isFirstResponder{
            print("height")
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    //hiding keyboard
    @objc func keyboardWillHide(_ notification:Notification){
        if bottomTextField.isFirstResponder{
            print("0")
            view.frame.origin.y = 0
        }
        
    }
    
    //Mark: actions
    
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
        pickingImageWithCameraOrLibrary(source: .photoLibrary)
    }
    
    @IBAction func grabImageWithCamera(_ sender: Any) {
        pickingImageWithCameraOrLibrary(source: .camera)
    }
    
    func pickingImageWithCameraOrLibrary(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker,animated: true, completion: nil)
    }
    
    
    
    // MARK: image picker functions
    
    //Tells the delegate that the user cancelled the pick operation
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePickerView.image = image
            shareButton.isEnabled = true
        }
    }
    //MARK: textfield delegate functions
    //Tells the delegate that editing began in the specified text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text!.isEmpty{
            textField.text = ""
        }
    }
    // Asks the delegate if the text field should process the pressing of the return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
}


