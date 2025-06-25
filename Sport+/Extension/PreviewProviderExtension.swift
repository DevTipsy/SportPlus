//
//  PreviewProviderExtension.swift
//  Sport+
//
//  Created by DevTipsy94 on 20/03/2025.
//

import SwiftUI
import SwiftData

// Extension pour faciliter la création de previews avec des données de test
extension PreviewProvider {
    static func previewWithTestData<Content: View>(@ViewBuilder content: @escaping (ActivityRepository, Person, [Activity]) -> Content) -> some View {
        let repo = ActivityRepository.previewInstance()
        let person = createTestPerson(in: repo)
        let activities = createTestActivities(in: repo, for: person)
        
        return content(repo, person, activities)
            .modelContainer(repo.modelContext.container)
    }
    
    private static func createTestPerson(in repo: ActivityRepository) -> Person {
        // Création d'une personne de test selon votre modèle
        let person = Person(
            id: 1,
            name: "Jean Dupont",
            city: "Paris",
            age: 32,
            height: 178.0,
            weight: 75.0,
            image: "profile_image1",
            describe: "Passionné de sport et de nature",
            level: .intermediaire,
            phoneNumber: "0123456789",
            preference: [] // Supposant que Preference est défini dans votre projet
        )
        
        repo.addPerson(person)
        return person
    }
    
    private static func createTestActivities(in repo: ActivityRepository, for person: Person) -> [Activity] {
        // Création d'activités de test selon votre modèle
        let activity1 = Activity(
            name: "Jogging matinal",
            sportType: .course,
            date: Date(),
            numberOfParticipant: 5,
            personsRecordedIDs: [person.id],
            authorID: person.id,
            cityActivity: person.city,
            activityDescription: "Session de course à pied dans le parc"
        )
        
        let activity2 = Activity(
            name: "Match de football",
            sportType: .foot,
            date: Date().addingTimeInterval(86400), // demain
            numberOfParticipant: 10,
            personsRecordedIDs: [person.id],
            authorID: 2, // Un autre auteur
            cityActivity: person.city,
            activityDescription: "Match amical de football",
            messageGroupID: 1
        )
        
        repo.addActivity(activity1)
        repo.addActivity(activity2)
        
        return [activity1, activity2]
    }
}
