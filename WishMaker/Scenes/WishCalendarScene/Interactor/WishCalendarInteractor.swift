final class WishCalendarInteractor: WishCalendarBusinessLogic {
    var presenter: WishCalendarPresentationLogic?
    private let worker = WishCalendarWorker()

    func fetchEvents(_ request: WishCalendar.FetchEvents.Request) {
        let events = worker.loadEvents()
        presenter?.presentFetchEvents(.init(events: events))
    }

    func deleteEvent(_ request: WishCalendar.DeleteEvent.Request) {
        let current = worker.loadEvents()
        guard request.index < current.count else { return }
        let updated = worker.delete(event: current[request.index])
        presenter?.presentDeleteEvent(.init(events: updated))
    }
}
