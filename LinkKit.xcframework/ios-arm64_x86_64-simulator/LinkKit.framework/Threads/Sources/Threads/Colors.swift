#if canImport(UIKit)

    import UIKit

    extension UIColor {
        class func with(rgb: UInt) -> UIColor {
            let r = (rgb & 0xFF0000) >> 16
            let g = (rgb & 0x00FF00) >> 8
            let b = (rgb & 0x0000FF)
            return UIColor(
                red: CGFloat(r) / 0xFF,
                green: CGFloat(g) / 0xFF,
                blue: CGFloat(b) / 0xFF,
                alpha: 1
            )
        }
    }

    /// Colors that represent a Threads Button in its supported states
    internal struct ButtonColors {
        let textColor: UIColor
        let textColorHighlighted: UIColor
        let textColorDisabled: UIColor

        let backgroundColor: UIColor
        let backgroundColorHighlighted: UIColor
        let backgroundColorDisabled: UIColor

        let borderColor: UIColor?
        let borderColorHighlighted: UIColor?
        let borderColorDisabled: UIColor?
    }

    /// All Threads colors
    internal struct ColorPalette {
        static let white: UIColor = .white
        static let black: UIColor = .black
        static let clear: UIColor = .clear

        static let black100 = UIColor.with(rgb: 0xF6F6F6)
        static let black200 = UIColor.with(rgb: 0xEBEBEB)
        static let black300 = UIColor.with(rgb: 0xD7D7D7)
        static let black400 = UIColor.with(rgb: 0xCACACA)
        static let black500 = UIColor.with(rgb: 0xB9B9B9)
        static let black600 = UIColor.with(rgb: 0x9B9B9B)
        static let black700 = UIColor.with(rgb: 0x878787)
        static let black800 = UIColor.with(rgb: 0x696969)
        static let black900 = UIColor.with(rgb: 0x4B4B4B)
        static let black1000 = UIColor.with(rgb: 0x111111)
        static let blue200 = UIColor.with(rgb: 0xD4F9FF)
        static let blue400 = UIColor.with(rgb: 0xB1EEFC)
        static let blue600 = UIColor.with(rgb: 0x63DAFF)
        static let blue800 = UIColor.with(rgb: 0x0A85EA)
        static let blue900 = UIColor.with(rgb: 0x0977D1)
        static let purple200 = UIColor.with(rgb: 0xE1E1FF)
        static let purple400 = UIColor.with(rgb: 0xC6BEFC)
        static let purple600 = UIColor.with(rgb: 0x9986F7)
        static let purple800 = UIColor.with(rgb: 0x7646EC)
        static let red200 = UIColor.with(rgb: 0xF9D9D9)
        static let red400 = UIColor.with(rgb: 0xFFAAB9)
        static let red600 = UIColor.with(rgb: 0xFF7885)
        static let red800 = UIColor.with(rgb: 0xF44E66)
        static let yellow200 = UIColor.with(rgb: 0xFEFBB8)
        static let yellow400 = UIColor.with(rgb: 0xFBF1A0)
        static let yellow600 = UIColor.with(rgb: 0xFCE76B)
        static let yellow800 = UIColor.with(rgb: 0xF2D211)
        static let green200 = UIColor.with(rgb: 0xD0FCE4)
        static let green400 = UIColor.with(rgb: 0xABFFDB)
        static let green600 = UIColor.with(rgb: 0x5BEFBD)
        static let green800 = UIColor.with(rgb: 0x23D09C)
    }

    /// Provides colors scoped to components
    internal protocol ComponentColors {
        var primaryButtonColors: ButtonColors { get }
        var secondaryButtonColors: ButtonColors { get }
        var tertiaryButtonColors: ButtonColors { get }
    }

    /// Component-scoped colors for Light Mode
    internal struct LightModeColors: ComponentColors {
        let primaryButtonColors = ButtonColors(
            textColor: ColorPalette.white,
            textColorHighlighted: ColorPalette.white,
            textColorDisabled: ColorPalette.black,
            backgroundColor: ColorPalette.black1000,
            backgroundColorHighlighted: ColorPalette.blue900,
            backgroundColorDisabled: ColorPalette.black400,
            borderColor: nil,
            borderColorHighlighted: nil,
            borderColorDisabled: nil
        )

        let secondaryButtonColors = ButtonColors(
            textColor: ColorPalette.black,
            textColorHighlighted: ColorPalette.blue900,
            textColorDisabled: ColorPalette.black400,
            backgroundColor: ColorPalette.white,
            backgroundColorHighlighted: ColorPalette.white,
            backgroundColorDisabled: ColorPalette.white,
            borderColor: ColorPalette.black1000,
            borderColorHighlighted: ColorPalette.blue900,
            borderColorDisabled: ColorPalette.black400
        )

        let tertiaryButtonColors = ButtonColors(
            textColor: ColorPalette.black900,
            textColorHighlighted: ColorPalette.blue900,
            textColorDisabled: ColorPalette.black600,
            backgroundColor: ColorPalette.clear,
            backgroundColorHighlighted: ColorPalette.clear,
            backgroundColorDisabled: ColorPalette.clear,
            borderColor: nil,
            borderColorHighlighted: nil,
            borderColorDisabled: nil
        )
    }

// TODO: DarkMode!

#endif  // canImport(UIKit)
