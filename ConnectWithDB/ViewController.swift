//
//  ViewController.swift
//  ConnectWithDB
//
//  Created by Taskeen Ashraf on 18/01/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let imagePicker : UIImagePickerController = UIImagePickerController()
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var clickToOpenGalleryButton : UIButton!
    @IBOutlet weak var titleTextField : UITextField!
    @IBOutlet weak var descriptionTextField : UITextField!
    @IBOutlet weak var spinner : UIActivityIndicatorView!
 
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openPhotoLibrary()
       {
           present(imagePicker, animated: true,completion: nil)
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           imagePicker.dismiss(animated: true)
           clickToOpenGalleryButton.titleLabel?.isHidden = true
           guard let image = info[.originalImage] as? UIImage else {
               return
           }
           imageView.image = image

       }
    
    func uploadMedia(completion : @escaping(_ url : String?)-> Void){
        let storageRef = Storage.storage().reference().child(Constants.id).child("image.png")
        if let data = self.imageView.image!.pngData() {
            storageRef.putData(data){(metadata, error) in
                if error != nil {
                    print("An error occured")
                    completion(nil)
                }else {
                    storageRef.downloadURL(completion: {(url,error) in
                        print(url?.absoluteString)
                        completion(url?.absoluteString)
                    })
                }
            }
        }
    }
    
    @IBAction func uploadData()
    {
        ref = Database.database().reference()
        
        uploadMedia() { url in
            guard let url = url else {
                return
            }
            
            let item = [ "title" : self.titleTextField.text,
                         "description" : self.descriptionTextField.text,
                         "image" : url] as [String: Any]
            
            self.ref?.child("Info").child(Constants.id).setValue(item)
            
        }
    }


    
}

