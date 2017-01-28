//
//  ViewController.swift
//  blacktimer
//
//  Created by hyuga on 2/25/16.
//  Copyright © 2016 CPS Lab. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
	
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var limitLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var umaruImage: UIImageView!
	
	let dateFormatter = NSDateFormatter()
	let random = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 1, highestValue: 6)
	
	var timer: NSTimer!
	var imageCount = 0
	
	var currentTime = NSDate() {
		didSet(newValue) {
			timeLabel.text = "Time: " + dateFormatter.stringFromDate(newValue)
		}
	}
	
	var limitTime = NSDate() {
		didSet(newValue) {
			limitLabel.text = "Limit: " + dateFormatter.stringFromDate(newValue)
		}
	}
	
	var name: String! {
		didSet(newValue) {
			nameLabel.text = name
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
		dateFormatter.dateFormat = "MM-dd HH:mm:ss"
		currentTime = NSDate()
		limitTime = NSDate()
		name = ""
		timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerEvent", userInfo: nil, repeats: true)
	}
	
	override func viewWillAppear(animated: Bool) {
		timerLabel.text = ""
		limitTime = NSDate(timeInterval: 0, sinceDate: limitTime)
		imageCount = 0
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func timerEvent() {
		imageCount++
		if imageCount % 5 == 0 {
			umaruImage.image = UIImage(named: "umaru\(random.nextInt())")
		}
		currentTime = NSDate()
		var sec = Int(round(limitTime.timeIntervalSinceDate(currentTime)))
		var str = ""
		if sec < 0 {
			sec *= -1
			timerLabel.textColor = UIColor.redColor()
		} else {
			timerLabel.textColor = UIColor.cyanColor()
		}
		let day = Int(sec / (24 * 60 * 60))
		sec -= day * 24 * 60 * 60
		str += "\(day)days "
		let hour = Int(sec / (60 * 60))
		sec -= hour * 60 * 60
		if hour < 10 {
			str += "0"
		}
		str += "\(hour):"
		let min = Int(sec / 60)
		sec -= min * 60
		if min < 10 {
			str += "0"
		}
		str += "\(min):"
		if sec < 10 {
			str += "0"
		}
		str += "\(sec)"
		timerLabel.text = str
	}
	
}

