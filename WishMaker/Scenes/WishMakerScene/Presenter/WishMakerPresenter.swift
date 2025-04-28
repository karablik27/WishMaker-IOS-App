final class WishMakerPresenter: WishMakerPresentationLogic {
    weak var viewController: WishMakerDisplayLogic?
    func presentColor(_ response: WishMaker.Response) {
        viewController?.displayColor(WishMaker.ViewModel(bgColor: response.color))
    }
}
