import SwiftyJSON
import UIKit

class StandupsViewController: UITableViewController {

    var standups: SwiftyJSON.JSON = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    func initialize() {
        self.title = "All Standups"
        self.tableView.registerNib(UINib(nibName: "StandupTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: StandupTableViewCell.cellIdentifier)
        fetchStandups()
    }

    func fetchStandups(whiteboardService: WhiteboardService = RealWhiteboardService()) {
        whiteboardService.getStandups(onGetStandups)
    }

    func onGetStandups(response: SwiftyJSON.JSON?) {
        if (response != nil) {
            standups = response!
            self.tableView.reloadData()
        } else {
            showLogin()
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standups.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StandupTableViewCell.cellIdentifier) as! StandupTableViewCell
        bindStandupDataToCell(cell, standup: standups[indexPath.row])
        return cell
    }

    func bindStandupDataToCell(cell: StandupTableViewCell, standup: SwiftyJSON.JSON) {
        cell.name.text = standup["title"].string
    }

    func showLogin() {
        let loginController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        presentViewController(loginController, animated: true, completion: nil)
    }
}
