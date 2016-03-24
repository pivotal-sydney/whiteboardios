import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logInWithOktaPressed(sender: AnyObject) {
        let loginController = OktaViewController(nibName: "OktaViewController", bundle: nil)
        presentViewController(loginController, animated: true, completion: nil)
    }
}
