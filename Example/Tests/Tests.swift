// https://github.com/Quick/Quick

import Quick
import Nimble
import GSSwiftKit
@testable import GSSwiftKit

class GSSwiftKitSpec: QuickSpec {
    override func spec() {
        describe("StringChecker") {
            
            context("these will pass") {

                it("can do maths") {
                    expect(23) == 23
                }
            }
        }
    }
}
