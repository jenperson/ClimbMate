//
//  ClimbLogTableViewDataSource.swift
//  ClimbMate
//
//  Created by Jennifer Person on 1/29/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class ClimbLogTableViewDataSource: FUITableViewDataSource {
        
        /// Called to populate each cell in the UITableView.
        typealias PopulateCellBlock = (UITableView, IndexPath, FIRDataSnapshot) -> UITableViewCell
        
        /// Called to commit an edit to the UITableView.
        typealias CommitEditBlock = (UITableView, UITableViewCellEditingStyle, IndexPath) -> Void
        
        private var commitEditBlock: CommitEditBlock?
        
        /// A wrapper around FUITableViewDataSource.init(query:view tableView:populateCell:), with the
        /// addition of a CommitEditBlock.
        public convenience init(query: FIRDatabaseQuery,
                    tableView: UITableView,
                    populateCell: @escaping PopulateCellBlock,
                    commitEdit: @escaping CommitEditBlock)
        {
            
            self.init(query: query, view: tableView, populateCell: populateCell)
            commitEditBlock = commitEdit
        }
        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        override func tableView(_ tableView: UITableView,
                                commit editingStyle: UITableViewCellEditingStyle,
                                forRowAt indexPath: IndexPath)
        {
            if (commitEditBlock != nil) {
                commitEditBlock!(tableView, editingStyle, indexPath)
            }
        }
        
}
