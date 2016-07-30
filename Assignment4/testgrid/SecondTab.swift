
import UIKit

class SecondTab: UIViewController, EngineDelegate {
    var firsttab: EngineProtocol?
    
    @IBOutlet weak var viewForLayer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firsttab = FirstTab.sharedInstance
        firsttab!.grid = Grid(rows: firsttab!.rows, cols: firsttab!.cols)
        firsttab!.delegate = self
        let barViewControllers = self.tabBarController?.viewControllers
        let vc2 = barViewControllers![1] as! SecondTab
        vc2.setUpLayer(firsttab!.grid!)
    }
//    override func drawRect(rect: CGRect) {
//        let path = UIBezierPath(rect: rect)
//        fillColor.setFill()
//        path.fill()
//    }

    func setUpLayer(grid:GridProtocol) {
        //print (grid[1,1])
        let l = CAShapeLayer()
        //let pa = l.path!
        l.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        l.path = UIBezierPath(roundedRect: l.bounds, cornerRadius: 20).CGPath
        l.fillColor = UIColor.greenColor().CGColor


        //l.backgroundColor = UIColor.redColor().CGColor
        
        // 1
        //l.backgroundColor = UIColor.redColor().CGColor
        //l.cornerRadius = 20
        // 2
        // 3
        //l.fillColor = UIColor.blueColor().CGColor
        //l.path = UIBezierPath(roundedRect: l.bounds, byRoundingCorners: .BottomLeft, cornerRadii: CGSize(width: 20, height: 20)).CGPath
        self.view.layer.addSublayer(l)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func incrementRows(sender: AnyObject) {
        firsttab!.rows += 10
        rows.text = String(firsttab!.rows)
    }
    
    @IBAction func incrementCols(sender: AnyObject) {
        firsttab!.cols += 10
        cols.text = String(firsttab!.cols)
    }
    @IBOutlet weak var rows: UITextField!
    @IBOutlet weak var cols: UITextField!
    func engineDidUpdate(firsttab: FirstTab, didUpdateRows modelRows: Int) {
    }
    func engineDidUpdate(firsttab: FirstTab, didUpdateCols modelCols: Int) {
    }
}

class GridView: UIView {
    var fillColor = UIColor.greenColor()
    var grid:GridProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        fillColor.setFill()
        path.fill()
    }
}


/*
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    firsttab!.grid![0,4] = .Living
}
*/

//FirstTab.sharedInstance.rows = firsttab.rows
//FirstTab.sharedInstance.cols = firsttab.cols
//rows.text = "10"
//cols.text = "10"


/*
func engineDidUpdate(firsttab: FirstTab, didUpdateRows modelRows: Int) {
    //rows.text  = String(modelRows)
    //firsttab.grid = Grid(rows: 10,cols: 10)
    //firsttab.grid?.cols = 0
    //print(modelRows)
}

//print (firsttab!.grid![0,4])
*/

