protocol WishEventCreationBusinessLogic {
    func loadWishes(_ request: WishEventCreation.LoadWishes.Request)
    func saveEvent(_ request: WishEventCreation.SaveEvent.Request)
}
