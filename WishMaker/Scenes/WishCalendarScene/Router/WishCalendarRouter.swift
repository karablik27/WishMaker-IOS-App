import UIKit

protocol WishCalendarRoutingLogic {
    func routeToCreateEvent(initialColor: UIColor)
}

final class WishCalendarRouter: WishCalendarRoutingLogic {
    weak var viewController: UIViewController?

    func routeToCreateEvent(initialColor: UIColor) {
        let vc = WishEventCreationViewController()
        vc.initialColor = initialColor
        vc.onSave = { [weak viewController] in
            (viewController as? WishCalendarDisplayLogic)?
                .displayFetchEvents(.init(events: []))
        }
        viewController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
