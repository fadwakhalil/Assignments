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

        let sel = #selector(timedRefreshToggle)
        let center  = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "TimerNotification", object: nil)
    }
    
    @IBOutlet weak var colStepperOutlet: UIStepper!
    @IBOutlet weak var rowStepperOutlet: UIStepper!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBAction func timedRefreshToggle(sender: AnyObject) {
        
        if toggleSwitch.on {
            print("ON")
            timer?.refreshTimer
            NSNotificationCenter.defaultCenter().postNotificationName("timerToggled",
                                                                      object: nil,
                                                                      userInfo: nil)
        } else {
            print("OFF")
            timer?.refreshTimer
            }
        

    }
    @IBAction func refreshRateSlider(sender: UISlider) {
        let interval = String(format:"%.2f", sender.value)
        sliderValue.text = String(stringInterpolationSegment: interval)
    }
    
    @IBAction func incrementRows(sender: AnyObject) {
        firsttab?.rows = Int(rowStepperOutlet.value)
        rows.text = String(firsttab!.rows)
    }
    
    @IBAction func incrementCols(sender: AnyObject) {
        firsttab?.cols = Int(colStepperOutlet.value)
        cols.text = String(firsttab!.cols)
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        
    }
}

