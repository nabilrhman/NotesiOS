//
//  CoreDataManager.swift
//  NotesiOS
//
//  Created by Nabil Rahman on 10/24/19.
//  Copyright © 2019 Nabil Rahman. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesiOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of the stores failed: \(err)")
            }
        })
        return container
    }()
    
    func createNoteFolder(title: String) -> NoteFolder {
        let context = persistentContainer.viewContext
        let newNoteFolder = NSEntityDescription.insertNewObject(forEntityName: "NoteFolder", into: context) as! NoteFolder
        newNoteFolder.title = title
//        newNoteFolder.setValue(title, forKey: "title")
        do {
            try context.save()
            return newNoteFolder
        } catch let err{
            print("Failed to save new note folder.", err)
            return newNoteFolder
        }
    }
    
    func fetchNoteFolders() -> [NoteFolder] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NoteFolder>(entityName: "NoteFolder")
        do {
            let noteFolders = try context.fetch(fetchRequest)
            return noteFolders
        } catch let err {
            print("Failed to fetch more folders: ", err)
            return []
        }
    }
    
    func deleteNoteFolder(noteFolder: NoteFolder) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(noteFolder)
        do {
            try context.save()
            return true
        } catch let err {
            print("Error deleting note folder entity instance", err)
            return false
        }
    }
}
