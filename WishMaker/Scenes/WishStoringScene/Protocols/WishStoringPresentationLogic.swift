protocol WishStoringPresentationLogic: AnyObject {
    func presentFetch(_ response: WishStoring.Fetch.Response)
    func presentAdd(_ response: WishStoring.Add.Response)
}
