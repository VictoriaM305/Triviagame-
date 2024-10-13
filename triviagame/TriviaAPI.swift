import SwiftUI

class TriviaAPI {
    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]) -> Void) {
        var urlComponents = URLComponents(string: "https://opentdb.com/api.php")!
        urlComponents.queryItems = [
            URLQueryItem(name: "amount", value: "10"), // Fixed number of questions (10)
            URLQueryItem(name: "difficulty", value: "easy"), // Fixed difficulty to "easy"
            URLQueryItem(name: "type", value: "multiple") // Fixed type to "multiple choice"
        ]

        guard let url = urlComponents.url else {
            print("Failed to create URL")
            return
        }

        print("API URL: \(url)") // Debug print to check the URL

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching trivia questions: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            let decoder = JSONDecoder()
            if let response = try? decoder.decode(TriviaResponse.self, from: data) {
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } else {
                print("Failed to decode JSON response")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)") // Print the raw JSON to help debug
                }
            }
        }.resume()
    }
}

