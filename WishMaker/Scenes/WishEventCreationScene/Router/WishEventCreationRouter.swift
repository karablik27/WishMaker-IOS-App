import UIKit

final class WishEventCreationRouter: WishEventCreationRoutingLogic {
    weak var viewController: UIViewController?
    func routeBack() {
        viewController?.dismiss(animated: true)
    }
}
