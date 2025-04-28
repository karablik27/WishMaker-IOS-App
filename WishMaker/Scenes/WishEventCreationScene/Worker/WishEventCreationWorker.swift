import CoreData
import UIKit

final class WishEventCreationWorker {
    let ctx = CoreDataStack.shared.context

    func fetchWishes() -> [Wish] {
        let req: NSFetchRequest<Wish> = Wish.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return (try? ctx.fetch(req)) ?? []
    }

    func saveEvent(from wish: Wish, start: Date, end: Date, color: UIColor) {
        let ev = WishEvent(context: ctx)
        ev.title = wish.text
        ev.details = ""
        ev.startDate = start
        ev.endDate = end
        ev.colorData = try? NSKeyedArchiver.archivedData(
            withRootObject: color, requiringSecureCoding: false
        )
        try? ctx.save()
    }
}
