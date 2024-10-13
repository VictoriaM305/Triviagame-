import SwiftUI

// Define a struct for each question and its possible answers
struct Question {
    let questionText: String
    let answers: [String]
    let correctAnswer: String
}

struct QuestionsView: View {
    // Array of 3 science-related questions with multiple-choice answers
    let questions: [Question] = [
        Question(
            questionText: "How do plants use sunlight, carbon dioxide, and water to produce glucose during photosynthesis?",
            answers: ["By converting sunlight into food", "By using chlorophyll", "Through cellular respiration"],
            correctAnswer: "By using chlorophyll"
        ),
        Question(
            questionText: "What are the different types of plant reproduction, and how do they ensure the survival of plant species?",
            answers: ["Asexual and sexual reproduction", "Cellular fusion", "Flowering"],
            correctAnswer: "Asexual and sexual reproduction"
        ),
        Question(
            questionText: "How do plants adapt to extreme environments, such as deserts or rainforests?",
            answers: ["By adjusting their water absorption", "By growing taller", "By reducing photosynthesis"],
            correctAnswer: "By adjusting their water absorption"
        )
    ]
    
    // Track the selected answer for each question
    @State private var selectedAnswers: [Int: String] = [:] // [QuestionIndex: SelectedAnswer]
    @State private var showResult = false
    @State private var correctAnswersCount = 0
    
    var body: some View {
        VStack {
            if showResult {
                // Show result after submitting answers
                Text("You got \(correctAnswersCount) out of 3 correct!")
                    .font(.largeTitle)
                    .padding()
            } else {
                // Display questions and answers
                ForEach(0..<questions.count, id: \.self) { index in
                    let question = questions[index]
                    
                    VStack(alignment: .leading) {
                        Text(question.questionText)
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        // Display multiple choice answers
                        ForEach(question.answers, id: \.self) { answer in
                            HStack {
                                // Radio button to select an answer
                                Button(action: {
                                    selectedAnswers[index] = answer
                                }) {
                                    HStack {
                                        Image(systemName: selectedAnswers[index] == answer ? "largecircle.fill.circle" : "circle")
                                        Text(answer)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.bottom, 2)
                        }
                    }
                    .padding(.vertical)
                }
                
                // Submit Button to check answers
                Button(action: {
                    // Calculate how many answers are correct
                    correctAnswersCount = calculateCorrectAnswers()
                    showResult = true
                }) {
                    Text("Submit Answers")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            
            Spacer()
        }
        .navigationTitle("Science Quiz")
        .padding()
    }
    
    // Function to calculate how many correct answers the user selected
    func calculateCorrectAnswers() -> Int {
        var correctCount = 0
        for (index, selectedAnswer) in selectedAnswers {
            if selectedAnswer == questions[index].correctAnswer {
                correctCount += 1
            }
        }
        return correctCount
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView()
    }
}

