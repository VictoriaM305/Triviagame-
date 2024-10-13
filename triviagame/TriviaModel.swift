import Foundation

// Model for a trivia question
struct TriviaQuestion: Codable, Identifiable {
    var id = UUID() // Add an ID for SwiftUI List
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

// Model for the API response
struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}


