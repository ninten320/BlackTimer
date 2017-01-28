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
	
	let dateFormatter = NSDateFormatter()
	let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
	var y = 0
	var m = 0
	var d = 0
	var h = 0
	var limitTime = NSDate()

	override func viewDidLoad() {
		super.viewDidLoad()
		yearField.delegate = self
		monthField.delegate = self
		dayField.delegate = self
		hourField.delegate = self
		minField.delegate = self
		secField.delegate = self
		
		dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
		dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
		let date = NSDate(timeIntervalSinceNow: 60 * 60)
		y = calendar.component(.Year, fromDate: date)
		m = calendar.component(.Month, fromDate: date)
		d = calendar.component(.Day, fromDate: date)
		h = calendar.component(.Hour, fromDate: date)
		yearField.text = "\(y)"
		monthField.text = "\(m)"
		dayField.text = "\(d)"
		if let date = calendar.dateWithEra(1, year: y, month: m, day: d, hour: h, minute: 0, second: 0, nanosecond: 0) {
			timeLabel.text = dateFormatter.stringFromDate(date)
			limitTime = date
		} else {
			timeLabel.text = "Error"
		}
	}
	
	@IBAction func closeModalDialog(sender: UIButton) {
		let parent = self.presentingViewController as! ViewController
		parent.name = nameField.text
		parent.limitTime = limitTime
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		let year = Int(yearField.text!) ?? y
		let month = Int(monthField.text!) ?? m
		let day = Int(dayField.text!) ?? d
		let hour = Int(hourField.text!) ?? 0
		let min = Int(minField.text!) ?? 0
		let sec = Int(secField.text!) ?? 0
		if let date = calendar.dateWithEra(1, year: year, month: month, day: day, hour: hour, minute: min, second: sec, nanosecond: 0) {
			timeLabel.text = dateFormatter.stringFromDate(date)
			limitTime = date
		} else {
			timeLabel.text = "Error"
		}
	}
	
}