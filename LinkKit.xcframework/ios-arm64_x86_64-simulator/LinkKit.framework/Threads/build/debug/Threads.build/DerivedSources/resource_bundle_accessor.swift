import class Foundation.Bundle

extension Foundation.Bundle {
    static var module: Bundle = {
        let bundlePath = Bundle.main.bundlePath + "/" + "Threads_Threads.bundle"
        guard let bundle = Bundle(path: bundlePath) else {
            fatalError("could not load resource bundle: \(bundlePath)")
        }
        return bundle
    }()
}