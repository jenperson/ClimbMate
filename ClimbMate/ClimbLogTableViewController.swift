//
//  ViewController.swift
//  ClimbMate
//
//  Created by Jennifer Person on 1/29/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class ClimbLogTableViewController: UIViewController {

    let firebaseRef = FIRDatabase.database().reference()
    var dataSource: FUITableViewDataSource!
    var numberOfClimbs = 0
    var dataSnapshot: FIRDataSnapshot?
    var query: FIRDatabaseQuery
    
    @IBOutlet weak var climbLogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        climbLogTableView.dataSource = ClimbLogTableViewDataSource.init(query: query, tableView: climbLogTableView, populateCell: <#T##ClimbLogTableViewDataSource.PopulateCellBlock##ClimbLogTableViewDataSource.PopulateCellBlock##(UITableView, IndexPath, FIRDataSnapshot) -> UITableViewCell#>, commitEdit: <#T##ClimbLogTableViewDataSource.CommitEditBlock##ClimbLogTableViewDataSource.CommitEditBlock##(UITableView, UITableViewCellEditingStyle, IndexPath) -> Void#>)
        climbLogTableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        //configureDatabase()
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

    func configureDatabase() {
        self.dataSource = self.climbLogTableView.bind(to: self.firebaseRef) { tableView, indexPath, snapshot in
            self.numberOfClimbs = Int(snapshot.childrenCount)
            self.dataSnapshot = snapshot
            // Dequeue cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell", for: indexPath) as! ClimbLogTableViewCell
            /* populate cell */

            cell.populateCellWithClimb(snapshot: snapshot, indexPath: indexPath)
            
            return cell
        }

        self.climbLogTableView.dataSource = self.dataSource //as! ClimbLogTableViewDataSource

    }
    
    func editRows(sender: AnyObject) {
        if !isEditing {
            isEditing = true
            print("is editing")
            navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            climbLogTableView.setEditing(true, animated: true)
            
            if climbLogTableView.indexPathForSelectedRow != nil {
            climbLogTableView.deleteRows(at: [climbLogTableView.indexPathForSelectedRow!], with: .none)
                }

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
        configureDatabase()
        return numberOfClimbs
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configureDatabase()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell", for: indexPath) as! ClimbLogTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("is this even being called?")
        if editingStyle == .delete {
            firebaseRef.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        print("this is called")
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
    }
}


