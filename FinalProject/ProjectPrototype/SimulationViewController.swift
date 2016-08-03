
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    var switchTrue: [String:AnyObject] = [ "switchTrue": "false"]
    
    let engine = StandardEngine.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshGridWithTimer), name: "timerToggled", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        engine.configuration = nil
        engine.delegate = self
        gridView.setNeedsDisplay()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.setNeedsDisplay()
        StandardEngine.sharedInstance.startTimerWithInterval(StandardEngine.sharedInstance.refreshRate * 20)
    }
    
    func refreshGridWithTimer(notification: NSNotification) {
        switchTrue = (notification.userInfo as? [String:AnyObject])!
        if (switchTrue["switchTrue"]! as! String == "true") {
            engine.grid = StandardEngine.sharedInstance.step()
            gridView.setNeedsDisplay()
        }
    }
    
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
    }
    
    @IBAction func buttonPushed(sender: AnyObject) {
        
        engine.grid = StandardEngine.sharedInstance.step()
        gridView.setNeedsDisplay()
        
        if (switchTrue["switchTrue"]! as! String == "true") {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NextTimerNoticationFunction(_:)), name:"NextTimerNotification", object: nil)
        }
        else {
            StandardEngine.sharedInstance.startTimerWithInterval(0)
            StandardEngine.sharedInstance.refreshRate = 0
        }
    }
    
    func NextTimerNoticationFunction(notification: NSNotification){

        engine.grid = StandardEngine.sharedInstance.step()
        gridView.setNeedsDisplay()
        
    }
    
    
    @IBAction func refreshGrid(sender: AnyObject) {
        gridView.engine.grid = Grid(engine.rows, engine.cols) { _,_ in .Empty }
        gridView.setNeedsDisplay()
        
    }
    @IBAction func addName(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.engine.configurations.append(GridData(title: textField!.text!, contents: self.gridView.points ))
                                        //self.engine.configurations.append(GridData(title: textField!.text!, contents: self.gridView.points))

        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }

}

