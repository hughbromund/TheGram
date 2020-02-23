//
//  CameraViewController.swift
//  TheGram
//
//  Created by Hugh Bromund on 2/23/20.
//  Copyright © 2020 Hugh Bromund. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let orange = UIColor(red:1.00, green:0.45, blue:0.08, alpha:1.0)
    let white = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    let grey = UIColor(red:0.23, green:0.21, blue:0.21, alpha:1.0)
    let darkGrey = UIColor(red:0.14, green:0.13, blue:0.13, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.backgroundColor = orange
        submitButton.tintColor = orange
        submitButton.setTitleColor(white, for: UIControl.State.normal)
        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
        
        self.view.backgroundColor = darkGrey
        
        commentTextField.backgroundColor = white
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentTextField.text
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()!
        
        let file = PFFileObject(name: "image.png", data: imageData)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if (success) {
                print("Saved")
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error!)
            }
            
        }
        
        
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
