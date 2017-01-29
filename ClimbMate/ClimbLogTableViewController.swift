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
    
    @IBOutlet weak var climbLogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureDatabase()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureDatabase() {
        self.dataSource = self.climbLogTableView.bind(to: self.firebaseRef) { tableView, indexPath, snapshot in
            // Dequeue cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell", for: indexPath) as! ClimbLogTableViewCell
            /* populate cell */

            cell.populateCellWithClimb(snapshot: snapshot, indexPath: indexPath)
            
            return cell
        }
    }

}

extension ClimbLogTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

