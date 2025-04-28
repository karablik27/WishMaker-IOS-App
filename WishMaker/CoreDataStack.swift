import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    let container: NSPersistentContainer
    private init() {
        container = NSPersistentContainer(name: "WishModel")
        container.loadPersistentStores { _, error in if let e = error { fatalError(e.localizedDescription) }}
    }
    var context: NSManagedObjectContext { container.viewContext }
    func save() {
        guard context.hasChanges else { return }
        try? context.save()
    }
}
