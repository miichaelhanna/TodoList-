import SwiftUI

enum Theme {
    static let backgroundPrimary = Color(hex: "#FFFFFF")
    static let backgroundSecondary = Color(hex: "#F7F7F5")
    static let textPrimary = Color(hex: "#37352F")
    static let accentHover = Color(hex: "#EFEFEF")
}

extension Color {
    init(hex: String) {
        let value = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: value).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255
        let green = Double((rgb >> 8) & 0xFF) / 255
        let blue = Double(rgb & 0xFF) / 255

        self.init(red: red, green: green, blue: blue)
    }
}
