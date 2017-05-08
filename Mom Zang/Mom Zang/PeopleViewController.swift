//
//  PeopleViewController.swift
//  Mom Zang
//
//  Created by nancy on 5/3/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PeopleViewController:UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var PeopleTable: UITableView!
    var chosenPeople:String?
    var peopleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PeopleTable.delegate = self
        PeopleTable.dataSource = self
        
        let dbRef = FIRDatabase.database().reference()
        dbRef.child("People").observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists(){
                let people = snapshot.value as! [String:String]
                for key in people.keys{
                    self.peopleArray.append(key)
                }
                self.PeopleTable.reloadData()
            }else{
                print("people not exist")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PeopleTable.dequeueReusableCell(withIdentifier: "peopleCell") as! PoepleTableViewCell
        cell.name.text = peopleArray[indexPath.row]
        cell.profile.image = UIImage(named: peopleArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenPeople = peopleArray[indexPath.row]
        performSegue(withIdentifier: "PeopleToWishes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WishesViewController{
            print(chosenPeople!)
            destination.thePeople = chosenPeople!
        }
    }


}
