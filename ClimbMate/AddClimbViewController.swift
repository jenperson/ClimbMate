//
//  AddClimbViewController.swift
//  ClimbMate
//
//  Created by Jennifer Person on 1/30/17.
//  Copyright © 2017 Jennifer Person. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddClimbViewController: UIViewController {

    var firebaseRef: FIRDatabaseReference = FIRDatabase.database().reference()
    let sportPickerData = ["5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10.d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13", "5.14", "5.15"]
    let boulderPickerData = ["V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8"]
    var currentClimbList: [ClimbObject] = []
    
    @IBOutlet weak var doneClimbingButton: UIButton!
    @IBOutlet weak var todaysDatePicker: UIDatePicker!
    @IBOutlet weak var climbLocationTextField: UITextField!
    @IBOutlet weak var climbListTableView: UITableView!
    @IBOutlet weak var climbNameTextField: UITextField!
    @IBOutlet weak var climbLevelPickerView: UIPickerView!
    @IBOutlet weak var sportOrBoulderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addClimbButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        climbLevelPickerView.delegate = self
        climbLevelPickerView.dataSource = self
        climbLocationTextField.delegate = self
        climbNameTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func toggleSportOrBoulder(_ sender: Any) {
        climbLevelPickerView.reloadAllComponents()
        print(climbLevelPickerView.numberOfRows(inComponent: 0))
    }
    
    @IBAction func addClimb(_ sender: Any) {
        let climbName = climbNameTextField.text
        let climbType = isSportClimb()
        let climbLevel = climbLevelPickerView.selectedRow(inComponent: 0)
        
        let currentClimb = ClimbObject(climbName: climbName!, isSport: climbType, climbLevel: climbLevel)
        climbNameTextField.text = ""
        currentClimbList.append(currentClimb)
    }
    
    @IBAction func doneClimbing(_ sender: Any) {
        let climbDate = todaysDatePicker.date
        let climbLocaiton = climbLocationTextField.text
        
        addClimb(climbDate: climbDate.description,data: currentClimbList)
        
    }
    
    func addClimb(climbDate: String, data: [ClimbObject]) {
        for climb in data {
            let thisClimb : [String:String] = [
                Constants.climbName: climb.climbName,
                Constants.climbValue:climb.climbLevel.description,
                Constants.climbType: climb.isSport.description
                ]
            print(thisClimb[Constants.climbName])
            print(thisClimb[Constants.climbValue])
            print(thisClimb[Constants.climbType])
            firebaseRef.child("userID").child(climbDate.description).childByAutoId().setValue(thisClimb)
        }
        
        currentClimbList = []
    }
    
    // returns true if climb is sport/top rope and false if climb is bouldering
    func isSportClimb() -> Bool {
        if sportOrBoulderSegmentedControl.selectedSegmentIndex == 0 {
            return true
        }
        
        return false
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension AddClimbViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // sport climbing segment
        if sportOrBoulderSegmentedControl.selectedSegmentIndex == 0 {
            return sportPickerData.count
        }
            // boulder climbing segment
        else {
            return boulderPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // sport climbing segment
        if sportOrBoulderSegmentedControl.selectedSegmentIndex == 0 {
            return sportPickerData[row]
        }
            // boulder climbing segment
        else {
            return boulderPickerData[row]
        }
    }
}

extension AddClimbViewController: UITextFieldDelegate {

}
