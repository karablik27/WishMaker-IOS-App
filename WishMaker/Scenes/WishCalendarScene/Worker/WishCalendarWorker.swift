import CoreData

final class WishCalendarWorker {
    let ctx = CoreDataStack.shared.context

    func loadEvents() -> [WishEvent] {
        let req: NSFetchRequest<WishEvent> = WishEvent.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        return (try? ctx.fetch(req)) ?? []
    }

    func delete(event: WishEvent) -> [WishEvent] {
        ctx.delete(event)
        try? ctx.save()
        return loadEvents()
    }
}
