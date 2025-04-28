import CoreData
final class WishStoringWorker {
    let ctx = CoreDataStack.shared.context
    func load() -> [String] {
        let req: NSFetchRequest<Wish> = Wish.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return (try? ctx.fetch(req))?.compactMap { $0.text } ?? []
    }
    func save(_ text: String) -> [String] {
        let w = Wish(context: ctx); w.text = text; w.date = Date()
        try? ctx.save()
        return load()
    }
}
