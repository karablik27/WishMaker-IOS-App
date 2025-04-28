final class WishStoringInteractor: WishStoringBusinessLogic {
    var presenter: WishStoringPresentationLogic?
    private let worker = WishStoringWorker()

    func fetch() {
        let data = worker.load()
        presenter?.presentFetch(WishStoring.Fetch.Response(wishes: data))
    }
    func add(_ request: WishStoring.Add.Request) {
        let data = worker.save(request.text)
        presenter?.presentAdd(WishStoring.Add.Response(wishes: data))
    }
}
