final class WishEventCreationInteractor: WishEventCreationBusinessLogic {
    var presenter: WishEventCreationPresentationLogic?
    var router: WishEventCreationRoutingLogic?
    private let worker = WishEventCreationWorker()
    private var wishes: [Wish] = []

    func loadWishes(_ request: WishEventCreation.LoadWishes.Request) {
        wishes = worker.fetchWishes()
        presenter?.presentWishes(.init(wishes: wishes))
    }

    func saveEvent(_ request: WishEventCreation.SaveEvent.Request) {
        guard request.selectedIndex < wishes.count else { return }
        let wish = wishes[request.selectedIndex]
        worker.saveEvent(from: wish,
                         start: request.start,
                         end: request.end,
                         color: request.color)
        presenter?.presentSaveSuccess(.init())
        router?.routeBack()
    }
}
