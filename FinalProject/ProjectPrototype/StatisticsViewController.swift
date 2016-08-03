
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

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        engine.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        let alivecount = engine.grid.alive
        let emptycount = engine.grid.empty
        let borncount = engine.grid.born
        let deadcount = engine.grid.died
        
            aliveCount.text = "\(alivecount)"
            emptyCount.text = "\(emptycount)"
            bornCount.text = "\(borncount)"
            deadCount.text = "\(deadcount)"
    }
    
    func engineDidUpdate(withConfigurations: Array<GridData>) {
        
    }
}
