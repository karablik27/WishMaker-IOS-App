import Foundation
import UIKit
enum WishEventCreation {
    struct LoadWishes {
        struct Request {}
        struct Response { let wishes: [Wish] }
        struct ViewModel { let texts: [String] }
    }
    struct SaveEvent {
        struct Request {
            let selectedIndex: Int
            let start: Date
            let end: Date
            let color: UIColor
        }
        struct Response {}
        struct ViewModel {}
    }
}
