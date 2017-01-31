//
//  ViewController.swift
//  ClimbMate
//
//  Created by Jennifer Person on 1/29/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase

class ClimbLogTableViewController: UIViewController {

    let firebaseRef = FIRDatabase.database().reference()
    var numberOfClimbs = 0
    var dataSnapshot: FIRDataSnapshot?
    var query: FIRDatabaseQuery?
    var _refHandle: FIRDatabaseHandle!
    var _delRefHandle: FIRDatabaseHandle!
    var climbs: [FIRDataSnapshot] = []
    var index = 0
    
    @IBOutlet weak var climbLogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureDatabase()
        configureTitle()
        
    }
    
    override func viewDidLayoutSubviews() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editRows(sender: )))
        self.navigationItem.setRightBarButton(editButton, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebaseRef.removeAllObservers()
    }
    
    func configureDatabase() {

        _refHandle = firebaseRef.child("userName").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            self.climbs.append(snapshot)
            self.climbLogTableView.insertRows(at: [IndexPath(row: self.climbs.count-1, section: 0)], with: .automatic)
        }
        _delRefHandle = firebaseRef.child("userName").observe(.childRemoved){ (snapshot: FIRDataSnapshot) in
            self.climbs.remove(at: self.index)
            self.climbLogTableView.reloadData()
            
        }
        
    }
    
    func editRows(sender: AnyObject) {
        if !isEditing {
            isEditing = true
            print("is editing")
            navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            climbLogTableView.setEditing(true, animated: true)

        } else {
            isEditing = false
            print("done editing")
            navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
            climbLogTableView.setEditing(false, animated: false)
        }
    }
    
    func configureTitle() {
        self.title = "My Climbs"
    }

}

extension ClimbLogTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return climbs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell", for: indexPath) as! ClimbLogTableViewCell
        
        /* populate cell */
        cell.populateCellWithClimb(snapshot: climbs[indexPath.item], indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("is this even being called?")
        if editingStyle == .delete {
            print(climbs[indexPath.item].key)
            index = indexPath.item
            firebaseRef.child("userName").child(climbs[indexPath.item].key).setValue(nil)            //climbs.remove(at: indexPath.item)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
    }
}


