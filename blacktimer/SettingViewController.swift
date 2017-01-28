//
//  SettingViewController.swift
//  blacktimer
//
//  Created by hyuga on 3/15/16.
//  Copyright © 2016 CPS Lab. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var yearField: UITextField!
	@IBOutlet weak var monthField: UITextField!
	@IBOutlet weak var dayField: UITextField!
	@IBOutlet weak var hourField: UITextField!
	@IBOutlet weak var minField: UITextField!
	@IBOutlet weak var secField: UITextField!
	@IBOutlet weak var timeLabel: UILabel!
	
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
	var year = 0
	var month = 0
	var day = 0
	var hour = 23
    var min = 59
    var sec = 59
	var limitTime = Date()

	override func viewDidLoad() {
		super.viewDidLoad()
		yearField.delegate = self
		monthField.delegate = self
		dayField.delegate = self
		hourField.delegate = self
		minField.delegate = self
		secField.delegate = self
		
        dateFormatter.locale = Locale(identifier: "ja_JP")
		dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
		let date = Date(timeIntervalSinceNow: 60 * 60)
		year = calendar.component(.year, from: date)
		month = calendar.component(.month, from: date)
		day = calendar.component(.day, from: date)
        hour = 23
        min = 59
        sec = 59
        
		yearField.text = "\(year)"
		monthField.text = "\(month)"
		dayField.text = "\(day)"
        hourField.text = "23"
        minField.text = "59"
        secField.text = "59"
        
        
		if let date = calendar.date(from: DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hour, minute: min, second: sec)) {
            timeLabel.text = dateFormatter.string(from: date)
			limitTime = date
		} else {
			timeLabel.text = "Error"
		}
	}
	
	@IBAction func closeModalDialog(sender: UIButton) {
		let parent = self.presentingViewController as! ViewController
		parent.name = nameField.text
		parent.limitTime = limitTime
        dismiss(animated: true)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		let year = Int(yearField.text!) ?? self.year
		let month = Int(monthField.text!) ?? self.month
		let day = Int(dayField.text!) ?? self.day
		let hour = Int(hourField.text!) ?? 23
		let min = Int(minField.text!) ?? 59
		let sec = Int(secField.text!) ?? 59
        if let date = calendar.date(from: DateComponents(calendar: calendar, year: year, month: month, day: day, hour: hour, minute: min, second: sec)) {
            timeLabel.text = dateFormatter.string(from: date)
			limitTime = date
		} else {
			timeLabel.text = "Error"
		}
	}
	
}
