#if canImport(UIKit)

    import UIKit

    extension Icon {
        public var image: UIImage? {
            return UIImage(named: rawValue, in: .module, compatibleWith: nil)
        }
    }

#endif  // canImport(UIKit)
