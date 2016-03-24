import SwiftyJSON
import Alamofire

protocol WhiteboardService {
    func getStandups(callback: (response: SwiftyJSON.JSON?) -> Void)
}

class RealWhiteboardService: WhiteboardService {

    func getStandups(callback: (response: SwiftyJSON.JSON?) -> Void) {
        let baseUrl = NSBundle.mainBundle().objectForInfoDictionaryKey("WHITEBOARD_BASE_URL") as! String
        let url = NSURL(string: "/standups", relativeToURL: NSURL(string: baseUrl))
        retrieveData(Alamofire.Method.GET, url: (url?.absoluteString)!, callback: callback)
    }

    func retrieveData(method: Alamofire.Method, url: String, callback: (response: SwiftyJSON.JSON?) -> Void) {
        Alamofire.request(method, url)
            .responseJSON {
                response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling " + method.rawValue + " for: " + url)
                    print(response.result.error!)
                    callback(response: nil)
                    return
                }
                if let value: AnyObject = response.result.value {
                    let responseObject = JSON(value)
                    debugPrint(responseObject)
                    callback(response: responseObject)
                }
        }
    }

}