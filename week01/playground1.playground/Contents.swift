import SwiftUI
import PlaygroundSupport
import Foundation

// function to generate a random emoji line of text art
func generateLine(patterns: [String], length: Int) -> String {
    var result = ""
    
    for _ in 0..<length {
        if let randomPattern = patterns.randomElement() {
            result += randomPattern
        }
    }
    return result
}

struct ContentView: View {
    let patterns = ["⭐️", "🌍", "🚀", "✨", "🔥", "🎉", "🌟", "🌈", "🌀"]
    let positiveWords = [
        "Joy", "Love", "Peace", "Harmony", "Hope", "Bliss", "Gratitude", "Inspire", "Believe", "Shine",
        "Happiness", "Strength", "Courage", "Trust", "Kindness", "Dream", "Laugh", "Smile", "Compassion",
        "Brilliance", "Magic", "Calm", "Balance", "Breathe", "Positivity", "Passion", "Abundance",
        "Joyful", "Faith", "Empathy", "Radiance", "Freedom", "Adventure", "Light", "Serenity", "Empower",
        "Celebrate", "Achievement", "Success", "Optimism", "Hopeful", "Growth", "Victory", "Determination",
        "Focus", "Clarity", "Confidence", "Persistence"
    ]

    

    // timer-related states
    @State var timeElapsed: Int = 0
    @State var currentWord: String = "Smile"
    
    var body: some View {
        // timer that triggers every second
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        VStack {
            // text art above
            Text(generateLine(patterns: patterns, length: 3))
                .font(.system(size: 10))
                .padding()
            
            // display the current positive word
            Text(currentWord)
                .font(.title)
                .padding()
            
            // text art below
            Text(generateLine(patterns: patterns, length: 3))
                .font(.system(size: 10))
                .padding()
        }
        .onReceive(timer) { _ in
            // update the elapsed time and choose a new random word every second
            timeElapsed += 1
            currentWord = positiveWords.randomElement() ?? "Smile"
        }
    }
}

// ContentView
PlaygroundPage.current.setLiveView(ContentView())
