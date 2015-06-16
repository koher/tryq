import tryq
import XCTest

class tryqTests: XCTestCase {
    func testBasic() {
		do { try foo(0); XCTFail() } catch FooError.Qux {} catch { XCTFail() }
		do { try foo(1) } catch { XCTFail() }
		do { try foo(2); XCTFail() } catch FooError.Bar {} catch { XCTFail() }
		do { try foo(3); XCTFail() } catch FooError.Baz {} catch { XCTFail() }
		do { try foo(4); XCTFail() } catch FooError.Bar {} catch { XCTFail() }
		do { try foo(5) } catch { XCTFail() }
		do { try foo(6); XCTFail() } catch FooError.Qux {} catch { XCTFail() }
		do { try foo(7) } catch { XCTFail() }
		
		XCTAssert(tryq(try foo(0)) == nil)
		XCTAssert(tryq(try foo(1)) == 1)
		XCTAssert(tryq(try foo(2)) == nil)
		XCTAssert(tryq(try foo(3)) == nil)
		XCTAssert(tryq(try foo(4)) == nil)
		XCTAssert(tryq(try foo(5)) == 5)
		XCTAssert(tryq(try foo(6)) == nil)
		XCTAssert(tryq(try foo(7)) == 7)
    }
	
	func testExample() {
		repeat {
			let result: Int?
			do {
				result = try foo(42)
			} catch {
				result = nil
			}
			
			print(result)
		} while false
		
		repeat {
			// let result: Int? = try? foo(42)
			let result: Int? = tryq(try foo(42))
			
			print(result)
		} while false
		
		repeat {
			// let result = tryq(try foo(42)).map { $0 * $0 }
			let result = tryq(try foo(42)).map { $0 * $0 }
			
			print(result)
		} while false
	}
}

func foo(x: Int) throws -> Int {
	if x % 2 == 0 && x % 3 == 0 { throw FooError.Qux }
	if x % 2 == 0 { throw FooError.Bar }
	if x % 3 == 0 { throw FooError.Baz }
	return x
}

enum FooError: ErrorType {
	case Bar, Baz, Qux
}
