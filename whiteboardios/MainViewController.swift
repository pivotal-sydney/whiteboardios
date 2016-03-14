import UIKit
import Alamofire

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func button(sender: AnyObject) {
        let loginController = OktaLoginViewController(nibName: "OktaLoginViewController", bundle: nil)
        presentViewController(loginController, animated: true, completion: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn(pickView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func checkIfLoggedIn(callback: (success: Bool) -> Void) {
        let url = NSURL(string: "http://whiteboard.pivotallabs.com")
        let mutableUrlRequest = NSMutableURLRequest(URL: url!)
        mutableUrlRequest.HTTPMethod = "GET"

        let whiteboardToken = NSUserDefaults.standardUserDefaults().stringForKey("kAuthToken");
        if (whiteboardToken != nil) {
            mutableUrlRequest.setValue("_whiteboard_session=" + whiteboardToken!, forHTTPHeaderField: "Cookie")
        }

        print("\n\n>>>REQUEST\n\n")
        print("---request: \(mutableUrlRequest)\n")
        let rc = mutableUrlRequest.valueForHTTPHeaderField("Cookie")
        if (rc != nil) {
            print("---cookie: \(rc)\n")
        }

        print("\n\n>>>RESPONSE\n\n")


        Alamofire.request(mutableUrlRequest).response { response in
            let content = String(data: response.2!, encoding: NSUTF8StringEncoding)!
            print("---error:\n\(response.3)\n\n")
            print("---content:\n\(content)\n\n")
            print("---response:\n\(response.1!)\n\n")

            let error = response.3
            print("---error:\n\(response.3)\n\n")
            callback(success: (error == nil))
        }
    }

    func pickView(success: Bool) {
        if (success) {
            print("*** already logged in")
            showStandups()
        } else {
            print("*** NOT logged in")
            showLogin()
        }
    }

    func showLogin() {
        let loginController = OktaLoginViewController(nibName: "OktaLoginViewController", bundle: nil)
        presentViewController(loginController, animated: true, completion: nil)
    }

    func showStandups() {
        let whiteboardController = WhiteboardViewController(nibName: "WhiteboardViewController", bundle: nil)
        presentViewController(whiteboardController, animated: true, completion: nil)
    }
}
