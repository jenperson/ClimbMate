//
//  ClimbObject.swift
//  ClimbMate
//
//  Created by Jennifer Person on 1/31/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit


/* sportPickerData = ["5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10.d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13", "5.14", "5.15"]
boulderPickerData = ["V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8"]
 */


struct ClimbObject {
    let climbName: String
    let isSport: Bool
    let climbLevel: Int
    
    init(climbName: String, isSport: Bool, climbLevel: Int) {
        self.climbName = climbName
        self.isSport = isSport
        self.climbLevel = climbLevel
    }
}
