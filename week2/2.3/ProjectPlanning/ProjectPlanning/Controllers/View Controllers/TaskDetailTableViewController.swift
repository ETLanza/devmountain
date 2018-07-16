//
//  TaskDetailTableViewController.swift
//  ProjectPlanning
//
//  Created by Eric Lanza on 7/11/18.
//  Copyright © 2018 ETLanza. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    //MARK: - Properties
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    //MARK: - Actions
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateTask()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        taskDueTextField.text = sender.date.stringValue()
        dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder
        notesTextView.resignFirstResponder
        taskDueTextField.resignFirstResponder()
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDueTextField.inputView = dueDatePicker
        updateViews()
    }
    
    //MARK: - Private Methods
    private func updateTask() {
        guard let name = nameTextField.text else { return }
        let due = dueDateValue
        let notes = notesTextView.text
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDateValue)
        }
    }
    
    private func updateViews() {
        guard let task = task, isViewLoaded else { return }
        title = task.name
        nameTextField.text = task.name
        notesTextView.text = task.notes
        taskDueTextField.text = (task.due as Date?)?.stringValue()
    }
}
