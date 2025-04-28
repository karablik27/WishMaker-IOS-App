import UIKit
protocol WishMakerRoutingLogic { func routeToStore(); func routeToCalendar() }
final class WishMakerRouter: WishMakerRoutingLogic {
    weak var viewController: UIViewController?
    func routeToStore() {
        let vc = WishStoringViewController()
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    func routeToCalendar() {
        let vc = WishCalendarViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
