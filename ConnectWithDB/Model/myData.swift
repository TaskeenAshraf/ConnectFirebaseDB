//
//  MyData.swift
//  ConnectWithDB
//
//  Created by Taskeen Ashraf on 22/01/2023.
//

import Foundation


class MyData {
    
    var imageURl : String
    var titleText : String
    var descText : String
    
    
    init()
    {
        imageURl = ""
        titleText = ""
        descText = ""
    }
    
    func setData(url : String, title : String, description : String){
        
        imageURl = url
        titleText = title
        descText = description
        
    }
    
}
