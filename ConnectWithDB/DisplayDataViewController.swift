//
//  DisplayDataViewController.swift
//  ConnectWithDB
//
//  Created by Taskeen Ashraf on 22/01/2023.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class DisplayDataViewController : UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var spinner : UIActivityIndicatorView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var noDataLabel : UILabel!
    var dataArray : [MyData] = []
    let reuseIdentifier = "DataCell"
    
    var ref : DatabaseReference!

    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        spinner.startAnimating()
        spinner.isHidden = false
        name.text = "Hello "+Constants.username

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        noDataLabel.isHidden = true
        fetchDataFromFirebase()


    }
    @IBAction func onLogOutButtonTapped(){
        do{
            try Auth.auth().signOut()
        
        } catch let error as NSError {
            print(error)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DataCell else {
            return UITableViewCell()
        }
        
        
        cell.setValues(data: dataArray[indexPath.row])
        
        return cell
        
    }
    
    func fetchDataFromFirebase()
    {
        self.dataArray=[]
        ref.child("Info/\(Constants.id)").observeSingleEvent(of: .value, with: {snapshot in
            let value = (snapshot as! DataSnapshot).value as? NSDictionary
            if value != nil {
                self.noDataLabel.isHidden = true
                var data = MyData.init()
            let url = value?["image"] as? String ?? ""
            let title = value?["title"] as? String ?? ""
            let description = value?["description"] as? String ?? ""
                data.setData(url: url, title: title, description: description)
                self.dataArray.append(data)
            } else
            {
                self.noDataLabel.isHidden = false
            }
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.tableView.reloadData()
            
        }) {error in
            print (error.localizedDescription)
            
        }
   
    }
    
    
}
