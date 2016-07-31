
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var gridView: GridView!
    
    let engine = StandardEngine.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        engine.configuration = nil
        engine.delegate = self
        gridView.setNeedsDisplay()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        gridView.setNeedsDisplay()
    }
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
    }

    @IBAction func refreshGrid(sender: AnyObject) {
        engine.configuration = nil
        engine.configurations = []
        gridView.engine.grid = Grid(engine.rows, engine.cols) { _,_ in .Empty }
        gridView.setNeedsDisplay()
        
    }

    func refreshView() ->() {
        
        // Calling the viewDidLoad and viewWillAppear methods to "refresh" the VC and run through the code within the methods themselves
        engine.configuration = nil
        engine.configurations = []
        gridView.setNeedsDisplay()
    }
}

