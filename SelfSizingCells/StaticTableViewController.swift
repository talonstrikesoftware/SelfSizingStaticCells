//
//  StaticTableViewController.swift
//  SelfSizingCells
//
//  Created by Mark Astin on 7/8/15.
//  Copyright (c) 2015 Talon Strike Software. All rights reserved.
//

import UIKit

class StaticTableViewController: UITableViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var pickerCell: UITableViewCell!
    
    var datePickerHidden = true {
        didSet {
            if (!datePickerHidden) {
                datePickerButton.setTitle("Hide Date Picker", forState: UIControlState.Normal)
            }
            else {
                datePickerButton.setTitle("Show Date Picker", forState: UIControlState.Normal)
            }
        }
    }
    
    var pickerHidden = false {
        didSet {
            if (!pickerHidden) {
                pickerButton.setTitle("Hide Picker", forState: UIControlState.Normal)
            }
            else {
                pickerButton.setTitle("Show Picker", forState: UIControlState.Normal)
            }
        }
    }
    
    var items = ["Item 1", "Item 2", "Item 3"]
    
    @IBAction func toggleDatePicker(sender: AnyObject) {
        datePickerHidden = !datePickerHidden
        //        updateUI()
        if (datePickerHidden) {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                // Hide the picker
                self.datePicker.alpha = 0
                }, completion: { (success) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.datePickerCell.frame.size.height = 0
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                    }, completion: { (success) -> Void in
                        self.datePickerCell.hidden = true
                    })
            })
        }
        else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.datePickerCell.hidden = false
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                }, completion: { (success) -> Void in
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.datePicker.alpha = 1
                    })
            })
        }
    }
    
    @IBAction func togglePicker(sender: AnyObject) {
        pickerHidden = !pickerHidden
        if (pickerHidden) {
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                // Hide the picker
                self.picker.alpha = 0
                }, completion: { (success) -> Void in
                    UIView.animateWithDuration(1.0) { () -> Void in
                        // Animate table changes
                        self.pickerCell.hidden = true
                        
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                    }
            })
        }
        else {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                // Animate table changes
                self.pickerCell.hidden = false
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                }, completion: { (success) -> Void in
                    UIView.animateWithDuration(2.0) { () -> Void in
                        // show the date picker
                        self.picker.alpha = 1
                    }
            })
        }
//
//        updateUI()
//        UIView.animateWithDuration(2.0) { () -> Void in
//            self.picker.alpha = self.pickerHidden ? 0 : 1
//            self.tableView.beginUpdates()
//            self.tableView.endUpdates()
//        }

    }

    func updateUI() {
        datePickerCell.hidden = datePickerHidden
        pickerCell.hidden = pickerHidden
    }
    
    override func viewWillAppear(animated: Bool) {
        datePickerHidden = true
        pickerHidden = false
        datePicker.alpha = 0
        updateUI()
    }
    
    override func viewDidLoad() {
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 2 && datePickerHidden) {
            return 0
        }
        if (indexPath.row == 3 && pickerHidden) {
            return 0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    // UIPickerViewDataSource methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    // MARK: UIPickerViewDelegate methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return items[row]
    }
}
