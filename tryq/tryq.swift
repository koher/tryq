public func tryq<T>(@autoclosure f: () throws -> T) -> T? {
	do {
		return try f()
	} catch {
		return nil
	}
}
