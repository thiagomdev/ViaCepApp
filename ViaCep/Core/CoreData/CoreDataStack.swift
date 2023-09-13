import Foundation
import CoreData

final class CoreDataStack {
    
    static let shared: CoreDataStack = .init()
    
    private init() { }
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ViewCepCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var mainContext = persistenceContainer.viewContext
    
    @discardableResult
    func saveContext() -> Bool {
        let context = mainContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let error = error as NSError
                NetworkingLogger.logError(error: error, url: nil)
                return false
            }
        }
        return true
    }
}
