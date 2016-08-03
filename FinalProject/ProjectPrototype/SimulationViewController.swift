
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    
    let engine = StandardEngine.sharedInstance
    
    @IBAction func saveSimulationGrid(sender: AnyObject) {
        
        print("save")
        //navigationController!.popViewControllerAnimated(true)
    }
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
        StandardEngine.sharedInstance.startTimerWithInterval(10)
        
    }
    
    func refreshGridWithTimer(notification: NSNotification) {
        if let mySwitchBool = notification.userInfo as? [String:AnyObject] {
            print("hello1")
            print(mySwitchBool)
            
            engine.grid = StandardEngine.sharedInstance.step()
            gridView.setNeedsDisplay()
        }
    }
    
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
    }
    
    @IBAction func buttonPushed(sender: AnyObject) {
        
        engine.grid = StandardEngine.sharedInstance.step()
        
        
        gridView.setNeedsDisplay()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.NextTimerNoticationFunction(_:)), name:"NextTimerNotification", object: nil)
        
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

