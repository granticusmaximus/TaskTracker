//
//  ViewController.swift
//  TaskTracker
//
//  Created by Grant Watson on 3/29/19.
//  Copyright © 2019 Grant Watson. All rights reserved.
//

import Cocoa

enum FileWriteError: Error {
    case directoryDoesntExist
    case convertToDataIssue
}

class ViewController: NSViewController {

    @IBOutlet weak var taskEntry: NSTextField!
    @IBOutlet weak var dateOfTaskEntry: NSDatePicker!
   
    
    @IBAction func dateOfTaskEntry(sender: NSDatePicker) {
        let formatter = DateFormatter()
        let myString = (String(describing: Date.self))
        formatter.dateFormat = "dd-MMM-yyyy"
        let yourDate: Date? = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        print(yourDate as Any)
    }
    
    @IBAction func saveTaskButtonClicked(_ sender: NSButton) {
        //save task function
        do {
            // get the documents folder url
            if let documentDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = documentDirectory.appendingPathComponent("msrfile.txt")
                // define the string/text to be saved
                let text = taskEntry.stringValue + " " + dateOfTaskEntry.stringValue + "\n"
                let encoding = String.Encoding.utf8
                
                guard let data = text.data(using: encoding) else {
                    throw FileWriteError.convertToDataIssue
                }
                if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                } else {
                    try text.write(to: fileURL, atomically: false, encoding: encoding)
                }
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

