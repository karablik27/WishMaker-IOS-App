final class WishCalendarPresenter: WishCalendarPresentationLogic {
    weak var viewController: WishCalendarDisplayLogic?

    func presentFetchEvents(_ response: WishCalendar.FetchEvents.Response) {
        viewController?.displayFetchEvents(.init(events: response.events))
    }

    func presentDeleteEvent(_ response: WishCalendar.DeleteEvent.Response) {
        viewController?.displayDeleteEvent(.init(events: response.events))
    }
}
