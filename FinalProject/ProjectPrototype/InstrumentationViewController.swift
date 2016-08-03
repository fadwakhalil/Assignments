
import UIKit

class InstrumentationViewController: UIViewController, EngineDelegate {
    
    var firsttab: EngineProtocol!
    var timer : StandardEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.sharedInstance.rows = 10
        StandardEngine.sharedInstance.cols = 10
        firsttab = StandardEngine.sharedInstance
        firsttab.delegate = self
        
        //        let sel = #selector(refreshRateSlider)
        //        let center  = NSNotificationCenter.defaultCenter()
        //        center.addObserver(self, selector: sel, name: "TimerNotification", object: nil)
    }
    
    @IBOutlet weak var toggleStatus: UILabel!
    @IBOutlet weak var colStepperOutlet: UIStepper!
    @IBOutlet weak var rowStepperOutlet: UIStepper!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBAction func timedRefreshToggle(sender: AnyObject) {
        
        if toggleSwitch.on {
            StandardEngine.sharedInstance.count += 1
            toggleStatus.text = "Timer ON"
            let newValue = slider.value
            let mySwitchBool = toggleSwitch.on
            print(mySwitchBool)
            let switchTrue: [String:AnyObject] = [ "switchTrue": "true"]
            StandardEngine.sharedInstance.startTimerWithInterval(NSTimeInterval(0))
            NSNotificationCenter.defaultCenter().postNotificationName("timerToggled",
                                                                      object: nil,
                                                                      userInfo: switchTrue)

        } else {
            toggleStatus.text = "Timer OFF"
            let newValue = 0
            print(newValue)
            StandardEngine.sharedInstance.startTimerWithInterval(NSTimeInterval(0))
        }
        
        
    }
    
    @IBAction func refreshRateSlider(sender: UISlider) {
        let interval = String(format:"%.2f", sender.value)
        sliderValue.text = "Refresh Rate: " + String(stringInterpolationSegment: interval)
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
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
    }
    
    
}

