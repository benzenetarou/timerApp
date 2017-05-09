//
//  ViewController.swift
//  timerApp
//
//  Created by benzentarou on 2017/05/07.
//  Copyright © 2017年 benzentarou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    
    var isRunning: Bool = false
    var counter: Int = 0
    var startTime: TimeInterval? = nil
    var timer = Timer()
    
       override func viewDidLoad() {
        super.viewDidLoad()
        tapButton.layer.masksToBounds = true
        tapButton.layer.cornerRadius = tapButton.bounds.width / 2
        retryButton.isHidden = true
        retryButton.layer.masksToBounds = true
        retryButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func update(){
//        print(Date.timeIntervalSinceReferenceDate)
        if let startTime = self.startTime {
            let t: Double = startTime + 10 - Date.timeIntervalSinceReferenceDate
            print(t)
            if(t>=0){
                let sec = Int(t)
                let msec = Int((t - Double(sec)) * 100.0)
                self.timerLabel.text = String(format: "%02d:%02d", sec, msec)
            }else{
                self.timerLabel.text = "00:00"
                timer.invalidate()
                retryButton.isHidden = false
                tapButton.isEnabled = false
            }
        }
    }
    @IBAction func Retry(_ sender: Any) {
        self.timerLabel.text = "10:00"
        tapButton.setTitle("START", for: .normal)
        isRunning = false
        retryButton.isHidden = true
        tapButton.isEnabled = true
        counter = 0
    }
    
    @IBAction func startTimeOrCountUp(_ sender: Any) {
        if(isRunning){
            counter += 1
            tapButton.setTitle(String(counter), for: .normal)
        }else{
            tapButton.setTitle(String(counter), for: .normal)
            self.startTime = Date.timeIntervalSinceReferenceDate
            self.timer = Timer.scheduledTimer(timeInterval: 0.01,
                                 target: self,
                                 selector: #selector(self.update),
                                 userInfo: nil,
                                 repeats: true)
            isRunning = true
        }
    }
}

