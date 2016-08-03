
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
        StandardEngine.sharedInstance.refreshRate = Double(slider.value)
    }
    
    @IBOutlet weak var toggleStatus: UILabel!
    @IBOutlet weak var colStepperOutlet: UIStepper!
    @IBOutlet weak var rowStepperOutlet: UIStepper!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    @IBOutlet weak var toggleSwitch: UISwitch!
    var rt = StandardEngine.sharedInstance.refreshRate
    
    @IBAction func timedRefreshToggle(sender: AnyObject) {
        var switchTrue: [String:AnyObject] = [ "switchTrue": "false"]
        if toggleSwitch.on {
            toggleStatus.text = "Timer ON"
            switchTrue = [ "switchTrue": "true"]
            StandardEngine.sharedInstance.refreshRate = Double(slider.value)
        } else {
            toggleStatus.text = "Timer OFF"
            StandardEngine.sharedInstance.refreshRate = 0
        }

        rt = StandardEngine.sharedInstance.refreshRate
        
        StandardEngine.sharedInstance.startTimerWithInterval(NSTimeInterval(rt))
        NSNotificationCenter.defaultCenter().postNotificationName("timerToggled",
                                                                      object: nil,
                                                                      userInfo: switchTrue)
    }
    
    @IBAction func refreshRateSlider(sender: UISlider) {
        let interval = String(format:"%.2f", sender.value)
        sliderValue.text = String(stringInterpolationSegment: interval)
        StandardEngine.sharedInstance.refreshRate = Double(slider.value)
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

