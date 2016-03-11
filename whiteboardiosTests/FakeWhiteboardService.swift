import SwiftyJSON
import Foundation

@testable import whiteboardios


class FakeWhiteboardService: WhiteboardService {
    func getStandups(callback: (response: SwiftyJSON.JSON?) -> Void) {
        let standups = loadJsonData("sample_standups")
        callback(response: standups)
    }

    func loadJsonData(filename: String) -> SwiftyJSON.JSON {
        var jsonString: String
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource(filename, ofType: "json")
        do {
            try jsonString = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        } catch {
            jsonString = "{}"
        }
        
        return SwiftyJSON.JSON.parse(jsonString)
    }
}

