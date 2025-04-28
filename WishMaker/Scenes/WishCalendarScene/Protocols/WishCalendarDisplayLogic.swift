protocol WishCalendarDisplayLogic: AnyObject {
    func displayFetchEvents(_ viewModel: WishCalendar.FetchEvents.ViewModel)
    func displayDeleteEvent(_ viewModel: WishCalendar.DeleteEvent.ViewModel)
}
