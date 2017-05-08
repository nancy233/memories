//
//  DailyScrollViewController.swift
//  Mom Zang
//
//  Created by nancy on 5/3/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DailyScrollViewController:UIViewController{

    var theDaily:String?
    var imageArray = [UIImage]()
    
    @IBOutlet weak var dailyScroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Daily").child(theDaily!).observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let myVals = snapshot.value as! [String:String]
                let sorted = myVals.keys.sorted()
                for key in sorted{
                    let url = URL(string: myVals[key]!)
                    let imageData = NSData(contentsOf:url!)
                    let image = UIImage(data: imageData as! Data)
                    self.imageArray.append(image!)
                }
                for i in 0..<self.imageArray.count{
                    let imageView = UIImageView()
                    imageView.image = self.imageArray[i]
                    
                    imageView.contentMode = .scaleAspectFit
                    let xPos = self.view.frame.width * CGFloat(i)
                    
                    // imageView setting

                    imageView.frame = CGRect(x: xPos, y: -30, width:self.view.frame.width,
                                             height:self.view.frame.height)
                    self.dailyScroll.contentSize.width = self.view.frame.width * CGFloat(i+1)
                    self.dailyScroll.backgroundColor = UIColor.black
                    self.dailyScroll.addSubview(imageView)
                }
                
            }else{
                print("chosen daily not exist")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
