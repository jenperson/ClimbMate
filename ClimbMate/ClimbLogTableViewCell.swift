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
        let climbValue = snapshot.value(forKey: Constants.climbValue) ?? "0.00"
        let climbDate = snapshot.value(forKey: Constants.climbDate) ?? "1/1/00"
        
        self.textLabel?.text = climbDate as? String
        climbValueLabel.text = climbValue as? String
    }

}
