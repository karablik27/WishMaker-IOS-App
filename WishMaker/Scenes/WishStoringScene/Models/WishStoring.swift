import Foundation
enum WishStoring {
    struct Fetch { struct Request {}; struct Response { let wishes: [String] }; struct ViewModel { let items: [String] } }
    struct Add { struct Request { let text: String }; struct Response { let wishes: [String] } }
}
