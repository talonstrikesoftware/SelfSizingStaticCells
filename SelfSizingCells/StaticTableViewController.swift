//
//  StaticTableViewController.swift
//  SelfSizingCells
//
//  Created on 7/8/15.
//  Copyright (c) 2015 Talon Strike Software. All rights reserved.
//

import UIKit

class StaticTableViewController: UITableViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var pickerButton: UIButton!
    
    // Hold a reference to the cells we want to control
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var pickerCell: UITableViewCell!
    
    // Flag to indicate whether the date picker row is hidden or not
    // In the didSet method we update the title of the datePickerButton to represent
    // the current state
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
    
    // Flag to indicate whether the picker row is hidden or not
    // In the didSet method we update the title of the pickerButton to represent
    // the current state
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
    
    // Some items for our picker control
    var items = ["Item 1", "Item 2", "Item 3"]
    
    /**
    Toggles the visibility of a cell
    
    - Parameter hidden set to true if the cell should be hidden or false if it should be shown
    - Parameter view The view component in the cell, will have it's alpha value toggled depending on whether the cell is being shown or hidden
    - Parameter cell The cell to hide/show
    */
    func toggleRow(hidden:Bool, view:UIView, cell:UITableViewCell) {
        if (hidden) {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                // Hide the picker
                view.alpha = 0
                }, completion: { (success) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        // Now collapse the cell
                        cell.frame.size.height = 0
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                        }, completion: { (success) -> Void in
                            cell.hidden = true
                    })
            })
        }
        else {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                // unhide the cell
                cell.hidden = false
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                }, completion: { (success) -> Void in
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        // show the cell's contents
                        view.alpha = 1
                    })
            })
        }
    }

    /**
        Toggles the date picker row from it's current state to the next state
    */
    @IBAction func toggleDatePicker(sender: AnyObject) {
        // Set the new hidden state
        datePickerHidden = !datePickerHidden
        // Animate the new state
        toggleRow(datePickerHidden, view: datePicker, cell: datePickerCell)
    }
    
    /**
        Toggles the picker row from it's current state to the next state
    */
    @IBAction func togglePicker(sender: AnyObject) {
        // Set the new hidden state
        pickerHidden = !pickerHidden
        // Animate the new state
        toggleRow(pickerHidden, view: picker, cell: pickerCell)
    }

    /**
        Updates the controls in the view
    */
    func updateUI() {
        datePickerCell.hidden = datePickerHidden
        pickerCell.hidden = pickerHidden
    }
    
    override func viewWillAppear(animated: Bool) {
        datePickerHidden = true
        pickerHidden = false
        datePicker.alpha = 0
        
        // This is broken out as in a real app we may want to do other things
        // besides just hiding the cells.  In this test app this is the only place
        // this method is called.
        updateUI()
    }
    
    override func viewDidLoad() {
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    // UITableViewDelegate
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
