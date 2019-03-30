//
//  ViewController.swift
//  TaskTracker
//
//  Created by Grant Watson on 3/29/19.
//  Copyright © 2019 Grant Watson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var taskEntry: NSTextField!
    @IBOutlet weak var dateOfTaskEntry: NSDatePicker!
    
    @IBAction func dateOfTaskEntry(sender: NSDatePicker) {
        let formatter = DateFormatter()
        let myString = (String(describing: Date.self))
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let yourDate: Date? = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        print(yourDate as Any)
    }
    
    @IBAction func saveTaskButtonClicked(_ sender: NSButton) {
        //save task function
        taskEntry.stringValue = sender.stringValue;
        do {
            // get the documents folder url
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = documentDirectory.appendingPathComponent("msrTasks.txt")
                // define the string/text to be saved
                let text = taskEntry.stringValue;
                // writing to disk
                // Note: if you set atomically to true it will overwrite the file if it exists without a warning
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                print("saving was successful")
                // any posterior code goes here
                // reading from disk
                let savedText = try String(contentsOf: fileURL)
                print("savedText:", savedText)   // "Hello World !!!\n"
            }
        } catch {
            print("error:", error)
        }
    }
    
    @IBAction func clearTaskButtonClicked(_ sender: NSButton) {
        //clear all fields function
        taskEntry.stringValue = "";
        dateOfTaskEntry.minDate = Date();
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = NSDate()  //5 -  get the current date
        dateOfTaskEntry.minDate = currentDate as Date  //6- set the current date/time as a minimum
        dateOfTaskEntry.dateValue = Date() //7 - defaults to current time but shows how to use it.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

