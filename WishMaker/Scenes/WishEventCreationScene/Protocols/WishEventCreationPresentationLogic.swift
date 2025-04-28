protocol WishEventCreationPresentationLogic: AnyObject {
    func presentWishes(_ response: WishEventCreation.LoadWishes.Response)
    func presentSaveSuccess(_ response: WishEventCreation.SaveEvent.Response)
}
