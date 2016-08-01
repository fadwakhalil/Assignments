
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshtime), name: "gridUpdated", object: nil)
    }
    
    func refreshtime(notification: NSNotification) {

        
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
        
//        let alivecount = gridView.cal_live()
//        let emptycount = gridView.cal_live()
//        let borncount = gridView.cal_live()
//        let deadcount = gridView.cal_live()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshtime), name: "timerToggled", object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
    }
    
    func addGridInfo(notification: NSNotification) {
        //print("Catch notification")
        
        guard let userInfo = notification.userInfo,
            let alivecount = userInfo["alivecount"] as? Int,
            let emptycount = userInfo["emptycount"] as? Int,
            let borncount = userInfo["borncount"] as? Int,
            let deadcount = userInfo["deadcount"] as? Int

        else {
                print("No Update found")
            
                return
        }
        //aliveCount.text = "\(bef)"
        aliveCount.text = "\(alivecount)"
        emptyCount.text = "\(emptycount)"
        bornCount.text = "\(borncount)"
        deadCount.text = "\(deadcount)"
        
    }

    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
        }
    }
