protocol WishEventCreationDisplayLogic: AnyObject {
    func displayWishes(_ viewModel: WishEventCreation.LoadWishes.ViewModel)
    func displaySaveSuccess(_ viewModel: WishEventCreation.SaveEvent.ViewModel)
}
