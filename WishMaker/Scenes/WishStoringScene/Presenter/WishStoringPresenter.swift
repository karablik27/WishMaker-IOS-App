final class WishStoringPresenter: WishStoringPresentationLogic {
    weak var viewController: WishStoringDisplayLogic?
    func presentFetch(_ response: WishStoring.Fetch.Response) {
        viewController?.displayFetch(WishStoring.Fetch.ViewModel(items: response.wishes))
    }
    func presentAdd(_ response: WishStoring.Add.Response) {
        viewController?.displayAdd(WishStoring.Fetch.ViewModel(items: response.wishes))
    }
}
