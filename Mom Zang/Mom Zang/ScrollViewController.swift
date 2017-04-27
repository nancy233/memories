//
//  ScrollViewController.swift
//  Mom Zang
//
//  Created by nancy on 4/21/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ScrollViewController:UIViewController{
    
    var selectedPlace: String?
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var imageArray = [UIImage]()
        var imageDict=[UIImage:String]()
        UINavigationBar.appearance().isTranslucent = true
        
        let dbRef = FIRDatabase.database().reference()
        
        dbRef.child("FootMark").child(selectedPlace!).observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let imageSets = snapshot.value as! [String:[String:String]]
                for key in imageSets.keys{
                    print(key)
                    let loc = imageSets[key]?["image"]
                    let message = imageSets[key]?["message"]
                    let url = URL(string: loc!)
                    let imageData = NSData(contentsOf:url!)
                    let image = UIImage(data: imageData as! Data)
                    imageArray.append(image!)
                    imageDict[image!] = message
                }
                
                var yPos = CGFloat(0)
                for i in 0..<imageArray.count{
                    let imageView = UIImageView()
                    imageView.image = imageArray[i]
                    
                    let message = UILabel()
                    //imageView.contentMode = .scaleToFill
                    //let yPos = self.view.frame.height * CGFloat(i)
                    
                    // imageView setting
                    let image_w = imageView.image?.size.width
                    let image_h = imageView.image?.size.height
                    let new_h = image_h!/image_w!*self.view.frame.width
                    imageView.frame = CGRect(x: 0, y: yPos, width:self.view.frame.width,
                                             height:new_h)
                    yPos = yPos + new_h
                    
                    // label setting
                    message.text = imageDict[imageArray[i]]
                    message.textAlignment = .center
                    message.textColor = UIColor.white
                    message.backgroundColor = UIColor.black
                    
                    message.frame = CGRect(x: 0, y: yPos,
                                           width:self.view.frame.width, height:1/10*self.view.frame.height)
                    yPos = yPos + 1/10*self.view.frame.height

                    
                    self.scrollView.contentSize.height = yPos
                    self.scrollView.backgroundColor = UIColor.black
                    self.scrollView.addSubview(imageView)
                    self.scrollView.addSubview(message)
                    self.scrollView.bringSubview(toFront: message)
                    
                }
                
            }else{
                print("not exist")
                
            }
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
