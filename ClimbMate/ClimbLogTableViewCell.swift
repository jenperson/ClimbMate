//
//  ClimbLogTableViewCell.swift
//  ClimbMate
//
//  Created by Jennifer Person on 1/29/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase

class ClimbLogTableViewCell: UITableViewCell {

    @IBOutlet weak var climbValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCellWithClimb(snapshot: FIRDataSnapshot, indexPath: IndexPath) {
        let climbValue = snapshot.childSnapshot(forPath: Constants.climbValue).value as? String ?? "0.00"
        let climbDate = snapshot.childSnapshot(forPath: Constants.climbDate).value as? String ?? "1/1/00"
        
        self.textLabel?.text = climbDate as? String
        climbValueLabel.text = climbValue as? String
    }

}
