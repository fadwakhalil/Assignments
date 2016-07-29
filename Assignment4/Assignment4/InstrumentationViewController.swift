//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Fadwa Khalil on 7/15/16.
//  Copyright © 2016 Fadwa Khalil. All rights reserved.
//

import UIKit

class InstrumentationViewController : UIViewController, EngineDelegate {
    
    var firsttab: EngineProtocol!
    var timer : StandardEngine?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.sharedInstance.rows = 10
        StandardEngine.sharedInstance.cols = 10
        firsttab = StandardEngine.sharedInstance
        firsttab.delegate = self

        let sel = #selector(StandardEngine.timerDidFire(_:))
        let center  = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "TimerNotification", object: nil)
        
        
    }
    
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBAction func timedRefreshToggle(sender: AnyObject) {
        
        if toggleSwitch.on {
            print("ON")
            timer?.refreshTimer
        } else {
            print("OFF")
                timer?.refreshTimer
            }
    }
    @IBAction func refreshRateSlider(sender: UISlider) {
        let interval = Double(sender.value)
        sliderValue.text = String(stringInterpolationSegment: interval)
    }

    func watchForNotifications(notification:NSNotification) {
        
    }
    
    @IBAction func incrementRows(sender: AnyObject) {
        firsttab?.rows += 10
        rows.text = String(firsttab!.rows)
    }
    
    @IBAction func incrementCols(sender: AnyObject) {
        firsttab!.cols += 10
        cols.text = String(firsttab!.cols)
    }
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
}

