
import UIKit

class StatisticsViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    
    let engine = StandardEngine.sharedInstance
    
    @IBOutlet weak var emptyCount: UITextField!
    @IBOutlet weak var aliveCount: UITextField!
    @IBOutlet weak var bornCount: UITextField!
    @IBOutlet weak var deadCount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(statisticsValues), name: "gridUpdated", object: nil)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    func statisticsValues(notification: NSNotification) {
        if let myDict = notification.userInfo as? [String:AnyObject] {
            if let alivecount = myDict["alivecount"] as? Int {
                aliveCount.text = "\(alivecount)"
            }
            if let emptycount = myDict["emptycount"] as? Int {
                emptyCount.text = "\(emptycount)"
            }
            if let borncount = myDict["borncount"] as? Int {
                bornCount.text = "\(borncount)"
            }
            if let deadcount = myDict["deadcount"] as? Int {
                deadCount.text = "\(deadcount)"
            }
            
        }
        
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
    }
    
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
    }
}
