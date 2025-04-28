protocol WishCalendarBusinessLogic {
    func fetchEvents(_ request: WishCalendar.FetchEvents.Request)
    func deleteEvent(_ request: WishCalendar.DeleteEvent.Request)
}
