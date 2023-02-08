//
//  DataCell.swift
//  ConnectWithDB
//
//  Created by Taskeen Ashraf on 22/01/2023.
//

import Foundation
import UIKit
import FirebaseStorage


class DataCell : UITableViewCell {
    
    @IBOutlet weak var dataImageView : UIImageView!
    @IBOutlet weak var dataTitleText : UILabel!
    @IBOutlet weak var dataDescText : UILabel!
    @IBOutlet weak var cellSpinner : UIActivityIndicatorView!
    

    func setValues(data : MyData)
    {
        cellSpinner.startAnimating()
        cellSpinner.isHidden = false
        dataTitleText.text = data.titleText
        dataDescText.text = data.descText
        let storageRef = Storage.storage().reference(forURL: data.imageURl)
        
        storageRef.getData(maxSize: 28060876) {(data,error) in
            self.cellSpinner.stopAnimating()
            self.cellSpinner.isHidden = true
            if let err = error {
                print(err)
            }else {
                if let image = data {
                    let myImage : UIImage! = UIImage(data:image)
                    self.dataImageView.image = myImage
                }
            }
            
            
        }
      
}
    
}
