//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by student7 on 4/23/19.
//  Copyright © 2019 student7. All rights reserved.
//

import Foundation
import UIKit

class ToDoViewController: UITableViewController {
    
    var todo: ToDo?
    //var isPickerHidden = true //hide date picker until tapped
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //handle presence or lack of data
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            //change starting date of due date to 24 hours from today
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateSaveButtonState() //changes button state when pressed
        updateDueDateLabel(date: dueDatePickerView.date) //updates date label
    } //end viewDidLoad()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text ?? "No Title"
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    } //end prepare
    
    //disable save button if title text field empty
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    } //end updateSaveButtonState()
    
    //update date label
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    } //end updateDueDateLabel
    
    //call updateSaveButtonState after each keyboard tap in title text field
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    } //end textEditingChanged
    
    //dismiss keyboard on return
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    } //end returnPressed
    
    //changed button image when tapped
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    } //end isCompleteButtonTapped
    
    //update due date label when user changes date using date picker
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    } //end datePickerChanged
    


    
} //end ToDoViewController


/*
 //set sizing for date picker
 override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 let normalCellHeight = CGFloat(44)
 let largetCellHeight = CGFloat(200)
 
 switch(indexPath) {
 case [1,0]: //Due Date Cell
 return isPickerHidden ? normalCellHeight : largetCellHeight
 case [2, 0] : //Notes Cell
 return largetCellHeight
 default: return normalCellHeight
 } //end switch
 
 } //end heightForRowAt
 
 
 //update text color of due date label based on whether the picker is hidden
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 switch (indexPath) {
 case [2,0] : isPickerHidden = !isPickerHidden
 dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
 tableView.beginUpdates()
 tableView.endUpdates()
 default: break
 } //end switch
 } //end didSelectRowAt
 */
