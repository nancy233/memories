//
//  WishesViewController.swift
//  Mom Zang
//
//  Created by nancy on 5/6/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class WishesViewController:UIViewController{

    var thePeople:String?
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("People").child(thePeople!).observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                if self.thePeople=="于越Jocelyn"{
                    self.myLabel.removeFromSuperview()
                    let imageView = UIImageView()
                    imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                    imageView.contentMode = .scaleAspectFit
                    let url = URL(string: snapshot.value as! String)
                    let imageData = NSData(contentsOf:url!)
                    let image = UIImage(data: imageData as! Data)
                    imageView.image = image
                    
                    self.view.addSubview(imageView)
                }else{

                    self.myLabel.text = snapshot.value as! String
                    
                }
                self.background.image = #imageLiteral(resourceName: "background")
                self.view.bringSubview(toFront: self.myLabel)
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
