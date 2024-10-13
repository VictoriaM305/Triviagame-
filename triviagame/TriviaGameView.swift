import SwiftUI

struct TriviaGameView: View {
    @State private var triviaQuestions = [TriviaQuestion]()
    @State private var selectedAnswers = [String: String]() // Keeps track of user answers
    @State private var showScore = false
    @State private var score = 0

    var body: some View {
        VStack {
            if triviaQuestions.isEmpty {
                Text("Loading questions...") // Shows a message while loading
                    .onAppear {
                        fetchQuestions() // Fetch questions when view appears
                    }
            } else {
                List(triviaQuestions) { question in
                    VStack(alignment: .leading) {
                        Text(question.question)

                        ForEach([question.correct_answer] + question.incorrect_answers, id: \.self) { answer in
                            Button(action: {
                                selectedAnswers[question.question] = answer
                            }) {
                                HStack {
                                    Text(answer)
                                    Spacer()
                                    if selectedAnswers[question.question] == answer {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Trivia Game")
        .toolbar {
            Button("Submit") {
                calculateScore()
                showScore = true
            }
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text("Your Score"), message: Text("You scored \(score) out of \(triviaQuestions.count)"), dismissButton: .default(Text("OK")))
        }
    }

    // Simplified fetchQuestions function with fixed parameters
    func fetchQuestions() {
        print("Fetching trivia questions...") // Debug print
        TriviaAPI().fetchTriviaQuestions { questions in
            print("API call successful")
            self.triviaQuestions = questions
            print("Trivia questions loaded: \(questions.count)") // Debug print
            if questions.isEmpty {
                print("No questions were fetched.")
            }
        }
    }

    func calculateScore() {
        score = 0
        for question in triviaQuestions {
            if selectedAnswers[question.question] == question.correct_answer {
                score += 1
            }
        }
    }
}

