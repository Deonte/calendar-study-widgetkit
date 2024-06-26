//
//  Persistence.swift
//  CalendarStudy
//
//  Created by Deonte Kilgore on 4/29/24.
//
//
//import CoreData
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//    private let databaseName = "CalendarStudy.sqlite"
//    
//    var oldStoreURL: URL {
//        let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
//        
//        return directory.appending(path: databaseName)
//    }
//    
//    var sharedStoreURL: URL {
//        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.io.compilery.CalendarStudy")!
//        return container.appending(path: databaseName)
//    }
//    
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        
//        let startDate = Calendar.current.dateInterval(of: .month, for: .now)!.start
//        
//        for dayOffset in 0..<30 {
//            let newDay = Day(context: viewContext)
//            newDay.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)
//            newDay.didStudy = Bool.random()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//    
//    let container: NSPersistentContainer
//    
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "CalendarStudy")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        } else if !FileManager.default.fileExists(atPath: oldStoreURL.path) {
//            container.persistentStoreDescriptions.first!.url = sharedStoreURL
//        }
//        
//        print("Container URL = \(container.persistentStoreDescriptions.first!.url!)")
//        
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        
//        migrateStore(for: container)
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//    
//    func migrateStore(for container: NSPersistentContainer) {
//        let coordinator = container.persistentStoreCoordinator
//        
//        guard let oldStore = coordinator.persistentStore(for: oldStoreURL) else { return }
//        print("😰 went into migrate store")
//        
//        do {
//            let _ = try coordinator.migratePersistentStore(oldStore, to: sharedStoreURL, type: .sqlite)
//            print("🏁 migration successful")
//        } catch {
//            fatalError("Unable to migrate to shared store.")
//        }
//        
//        do {
//            try FileManager.default.removeItem(at: oldStoreURL)
//            print("🗑️ old store deleted.")
//        } catch {
//            print("Unable to delete oldStore")
//        }
//    }
//}
