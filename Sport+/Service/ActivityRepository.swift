//
//  SwiftData.swift
//  Sport+
//
//  Created by Mouhamadou SALL on 13/03/2025.
//

import Foundation
import SwiftData

@MainActor
class ActivityRepository {
    // Propriété publique pour accéder au contexte depuis l'extérieur
    private(set) var modelContext: ModelContext
    
    static let shared = ActivityRepository()
    
    // Initialisation avec option pour les previews
    init(inMemory: Bool = false) {
        let schema = Schema([Activity.self, Person.self, Message.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.modelContext = ModelContext(modelContainer)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    // Méthode pour créer une instance spécifique aux previews
    static func previewInstance() -> ActivityRepository {
        return ActivityRepository(inMemory: true)
    }
    
    // MARK: - Fonctions pour Activity
    
    func fetchActivity() -> [Activity] {
        do {
            return try modelContext.fetch(FetchDescriptor<Activity>())
        } catch {
            print("Erreur lors du fetch des activities : \(error.localizedDescription)")
            return []
        }
    }
    
    func addActivity(_ activity: Activity) {
        modelContext.insert(activity)
        save()
    }
    
    func updateActivity(_ activity: Activity) {
        save()
    }
    
    func deleteActivity(_ activity: Activity) {
        modelContext.delete(activity)
        save()
    }
    
    // MARK: - Fonctions pour Person
    
    func fetchPersons() -> [Person] {
        do {
            return try modelContext.fetch(FetchDescriptor<Person>())
        } catch {
            print("Erreur lors du fetch des persons : \(error.localizedDescription)")
            return []
        }
    }
    
    func addPerson(_ person: Person) {
        modelContext.insert(person)
        save()
    }
    
    // MARK: - Fonctions pour Message
    
    func fetchMessages() -> [Message] {
        do {
            return try modelContext.fetch(FetchDescriptor<Message>())
        } catch {
            print("Erreur lors du fetch des messages : \(error.localizedDescription)")
            return []
        }
    }
    
    func addMessage(_ message: Message) {
        modelContext.insert(message)
        save()
    }
    
    // Méthode utilitaire pour éviter la duplication de code
    private func save() {
        do {
            try modelContext.save()
        } catch {
            print("Erreur lors de la sauvegarde de la data : \(error.localizedDescription)")
        }
    }
}
