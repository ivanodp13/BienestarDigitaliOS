import UIKit


class AppInfo_Table_ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        totalUse.text = global_totalUseString
        todayUse.text = global_todayUseString
        yesterdayUse.text = global_yesterdayUseString
        BYUse.text = global_byUseString
        
        self.detailsTable.reloadData()
    }
    @IBOutlet weak var totalUse: UILabel!
    @IBOutlet weak var todayUse: UILabel!
    @IBOutlet weak var yesterdayUse: UILabel!
    @IBOutlet weak var BYUse: UILabel!
    

    @IBOutlet var detailsTable: UITableView!
    
}
