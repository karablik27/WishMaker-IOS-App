final class WishEventCreationPresenter: WishEventCreationPresentationLogic {
    weak var viewController: WishEventCreationDisplayLogic?

    func presentWishes(_ response: WishEventCreation.LoadWishes.Response) {
        let texts = response.wishes.compactMap { $0.text }
        viewController?.displayWishes(.init(texts: texts))
    }

    func presentSaveSuccess(_ response: WishEventCreation.SaveEvent.Response) {
        viewController?.displaySaveSuccess(.init())
    }
}
