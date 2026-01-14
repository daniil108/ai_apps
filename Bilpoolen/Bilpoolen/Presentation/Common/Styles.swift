import SwiftUI

enum AppColors {
    static let navy = Color(red: 0.05, green: 0.12, blue: 0.22)
    static let slate = Color(red: 0.27, green: 0.32, blue: 0.39)
    static let lightGray = Color(red: 0.95, green: 0.96, blue: 0.97)
    static let midGray = Color(red: 0.83, green: 0.84, blue: 0.86)
    static let accentGreen = Color(red: 0.1, green: 0.74, blue: 0.25)
    static let alertRed = Color(red: 0.93, green: 0.16, blue: 0.16)
    static let infoBlue = Color(red: 0.28, green: 0.52, blue: 0.97)
}

enum AppFonts {
    static func title(_ size: CGFloat) -> Font {
        Font.custom("AvenirNext-DemiBold", size: size)
    }

    static func body(_ size: CGFloat) -> Font {
        Font.custom("AvenirNext-Regular", size: size)
    }

    static func medium(_ size: CGFloat) -> Font {
        Font.custom("AvenirNext-Medium", size: size)
    }
}
