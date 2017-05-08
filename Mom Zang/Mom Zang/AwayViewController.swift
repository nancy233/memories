//
//  AwayViewController.swift
//  Mom Zang
//
//  Created by nancy on 5/3/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit

class AwayViewController:UIViewController{

    @IBOutlet weak var msg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msg.text = "本来这页想放你抛弃我出去玩的照骗，但是来不及了哈哈哈哈。其他两个bar其实也没做好哈哈哈哈，而且load图有延迟。不要嫌弃你就将就一下吧，有空我再fix哈哈哈。做一天你的酱小二吧，happy birthday 老女人！"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
