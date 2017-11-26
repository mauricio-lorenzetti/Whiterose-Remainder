//
//  ViewController.swift
//  Whiterose-Remainder
//
//  Created by Mauricio Lorenzetti on 25/11/17.
//  Copyright © 2017 Mauricio Lorenzetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var actionButton: UIButton!
    
    let time:[Int] = [60,90,120,180,300,600]
    let scheduler:Scheduler = Scheduler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.delegate = self
        timePicker.dataSource = self
        updateStatus()
    }
    
    func updateStatus() {
        if UserDefaults.standard.bool(forKey: "status") {
            statusLabel.text = "-Active: "
            actionButton.setTitle("Stop", for: .normal)
        } else {
            statusLabel.text = "-Inactive-"
            actionButton.setTitle("Start", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performAction(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "status") {
            scheduler.removeAllNotifications()
            UserDefaults.standard.set(false, forKey: "status")
        } else {
            let alarmInterval = TimeInterval(time[timePicker.selectedRow(inComponent: 0)])
            scheduler.scheduleWith(timeInterval: alarmInterval)
            UserDefaults.standard.set(true, forKey: "status")
        }
        updateStatus()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: time[row])
    }
}

