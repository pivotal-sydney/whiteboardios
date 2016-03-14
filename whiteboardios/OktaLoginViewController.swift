import UIKit
import Alamofire

class OktaLoginViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let whiteboardUrl = "http://whiteboard.pivotallabs.com"
        let requestURL = NSURL(string: whiteboardUrl)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        let stringUrl = self.webView.request!.URL!.absoluteString
        if (stringUrl.containsString("pivotal.okta.com") || stringUrl.containsString("http://whiteboard.pivotallabs.com/login")) {
            print("!!!! wrong url - not trying to authenticate")
            return
        }

        print("??? trying to authenticate...")

        var whiteboardSessionCookie: NSHTTPCookie?

        let cookieJar : NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in cookieJar.cookies! {
            if (cookie.name == "_whiteboard_session") {
                print("\n\n>>>COOKIE SET\n\n")
                whiteboardSessionCookie = cookie
                print("---cookie found: \(whiteboardSessionCookie)\n")
                break;
            }
        }

        if (whiteboardSessionCookie != nil) {
            print("**setting auth token in defaults: \(whiteboardSessionCookie!.value)")
            let defaults = NSUserDefaults.standardUserDefaults();
            defaults.setObject(whiteboardSessionCookie!.value, forKey:"kAuthToken");
            defaults.synchronize()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
