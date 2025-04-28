import UIKit

extension WishEvent {
    var color: UIColor {
        get {
            guard
                let data = colorData,
                let uiColor = try? NSKeyedUnarchiver.unarchivedObject(
                    ofClass: UIColor.self,
                    from: data
                )
            else {
                return .systemBackground
            }
            return uiColor
        }
        set {
            let data = try? NSKeyedArchiver.archivedData(
                withRootObject: newValue,
                requiringSecureCoding: false
            )
            colorData = data
        }
    }
}
