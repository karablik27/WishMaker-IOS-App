import Foundation

enum WishCalendar {
    struct FetchEvents {
        struct Request {}
        struct Response { let events: [WishEvent] }
        struct ViewModel { let events: [WishEvent] }
    }
    struct DeleteEvent {
        struct Request { let index: Int }
        struct Response { let events: [WishEvent] }
        struct ViewModel { let events: [WishEvent] }
    }
}
