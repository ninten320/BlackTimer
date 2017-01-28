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
	
	let dateFormatter = DateFormatter()
	let random = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 1, highestValue: 6)
	
	var timer: Timer!
	var imageCount = 0
	
	var currentTime = Date() {
		didSet {
            timeLabel.text = "Time: " + dateFormatter.string(from: currentTime)
		}
	}
	
	var limitTime = Date() {
		didSet {
            limitLabel.text = "Limit: " + dateFormatter.string(from: limitTime)
		}
	}
	
	var name: String! {
		didSet(newValue) {
			nameLabel.text = name
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dateFormatter.locale = Locale(identifier: "ja_JP")
		dateFormatter.dateFormat = "MM-dd HH:mm:ss"
		currentTime = Date()
		limitTime = Date()
		name = ""
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
	}
	
	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		timerLabel.text = ""
        limitTime = Date(timeInterval: 0, since: limitTime)
		imageCount = 0
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func timerEvent() {
		imageCount += 1
		if imageCount % 5 == 0 {
			umaruImage.image = UIImage(named: "umaru\(random.nextInt())")
		}
		currentTime = Date()
        var sec = Int(ceil(limitTime.timeIntervalSince(currentTime)))
		var str = ""
		if sec < 0 {
			sec *= -1
            timerLabel.textColor = .red
		} else {
            timerLabel.textColor = .cyan
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

