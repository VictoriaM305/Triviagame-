import SwiftUI

struct OptionsView: View {
    @State private var numberOfQuestions = 10
    @State private var selectedCategory = "Any"
    @State private var selectedDifficulty = "Easy"
    @State private var selectedType = "Multiple Choice"
    @State private var startGame = false  // For handling submit action
    
    var body: some View {
        NavigationView {
            Form {
                // Number of Questions
                Section(header: Text("Number of Questions")) {
                    Stepper(value: $numberOfQuestions, in: 1...50) {
                        Text("\(numberOfQuestions) Questions")
                    }
                }

                // Category Picker
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        Text("Any").tag("Any")
                        Text("General Knowledge").tag("General Knowledge")
                        Text("Science").tag("Science")
                        Text("Sports").tag("Sports")
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                // Difficulty Picker
                Section(header: Text("Difficulty")) {
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        Text("Easy").tag("Easy")
                        Text("Medium").tag("Medium")
                        Text("Hard").tag("Hard")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Question Type Picker
                Section(header: Text("Type")) {
                    Picker("Type", selection: $selectedType) {
                        Text("Multiple Choice").tag("Multiple Choice")
                        Text("True/False").tag("True/False")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Submit Button with NavigationLink
                Section {
                    NavigationLink(destination: QuestionsView()) {
                        Text("Submit")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Options")
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}

