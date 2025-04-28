protocol WishCalendarPresentationLogic: AnyObject {
    func presentFetchEvents(_ response: WishCalendar.FetchEvents.Response)
    func presentDeleteEvent(_ response: WishCalendar.DeleteEvent.Response)
}
