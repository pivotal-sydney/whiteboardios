import UIKit

class WhiteboardViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let whiteboardUrl = "http://whiteboard.pivotallabs.com/standups/60/items"
        let requestURL = NSURL(string: whiteboardUrl)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
