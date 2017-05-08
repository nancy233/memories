//
//  HomeViewController.swift
//  Mom Zang
//
//  Created by nancy on 5/7/17.
//  Copyright © 2017 nan. All rights reserved.
//

import AVFoundation
import UIKit

class HomeViewController:UIViewController{
    var player = AVAudioPlayer()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBAction func playMusic(_ sender: Any) {
        if player.isPlaying{
            player.pause()
            playButton.setImage(#imageLiteral(resourceName: "noMusic"), for: .normal)
        }else{
            player.play()
            playButton.setImage(#imageLiteral(resourceName: "music"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubview(toFront: playButton)
        image.image = #imageLiteral(resourceName: "BTD")
        image.contentMode = .scaleAspectFill
        
        do{
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "m4a")!))
            player.prepareToPlay()
            player.play()
            player.numberOfLoops = -1
        }catch{
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
