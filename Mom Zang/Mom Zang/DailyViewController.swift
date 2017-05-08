//
//  DailyViewController.swift
//  Mom Zang
//
//  Created by nancy on 5/3/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DailyViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var DailyTable: UITableView!
    
    var chosenDaily:String?
    var dailyArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DailyTable.delegate = self
        DailyTable.dataSource = self
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("Daily").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let dailyVals = snapshot.value as! [String:Any]
                for key in dailyVals.keys{
                    self.dailyArray.append(key)
                }
                self.DailyTable.reloadData()
            }else{
                print("Daily child not exist")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DailyTable.dequeueReusableCell(withIdentifier: "dailyCell") as! DailyTableViewCell
        cell.name.text = dailyArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenDaily = dailyArray[indexPath.row]
        performSegue(withIdentifier: "DailyToScroll", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DailyScrollViewController{
            destination.theDaily = chosenDaily
        }
    }
    
}
