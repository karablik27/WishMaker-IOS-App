import UIKit
protocol WishStoringRoutingLogic { func close() }
final class WishStoringRouter: WishStoringRoutingLogic {
    weak var viewController: UIViewController?
    func close() { viewController?.dismiss(animated: true) }
}
