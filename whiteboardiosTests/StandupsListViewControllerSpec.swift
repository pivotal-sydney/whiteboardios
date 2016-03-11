import Quick
import Nimble
import UIKit
@testable import whiteboardios

class StandupsViewControllerSpec: QuickSpec {
    override func spec() {
        var subject : StandupsViewController! = nil
        
        beforeEach {
            
            subject = StandupsViewController()
            subject.initialize()
        }
        
        describe("StandupsViewController") {
            it("should have the correct title") {
                expect(subject.title).to(equal("All Standups"))
            }
            
            it("should get a list of standups") {
                expect(subject.standups).to(haveCount(0))
                subject.fetchStandups(FakeWhiteboardService())
                expect(subject.standups).to(haveCount(2))
                
                expect(subject.standups[0]["title"]).to(equal("Sydney"))
                expect(subject.standups[0]["id"]).to(equal(60))
            }
            
            it("tableView numberOfRowsInSection matches the standup count") {
                subject.fetchStandups(FakeWhiteboardService())
                let result = subject.tableView(subject.tableView, numberOfRowsInSection: 1)
                expect(result).to(equal(2))
            }
            
            it("bind StandupTableViewCell sets fields on cell") {
                subject.fetchStandups(FakeWhiteboardService())
                let bundle = NSBundle(forClass: StandupTableViewCell.self)
                let nibs = bundle.loadNibNamed("StandupTableViewCell", owner: self, options: nil)
                let cell = nibs[0] as! StandupTableViewCell
                subject.bindStandupDataToCell(cell, standup: subject.standups[0])
                expect(cell.name.text).to(equal("Sydney"))
            }
        }
    }
}