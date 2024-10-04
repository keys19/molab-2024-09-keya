//
//  LandingPageView.swift
//  week04
//
//  Created by Keya Shah on 03/10/2024.
//

import SwiftUI
import AVFoundation

struct LandingPageView: View {
    @State private var selectedDuration: Int = 5
    @State private var audioPlayer: AVAudioPlayer?

    let durations = [3, 5, 10]

    var body: some View {
        NavigationView {
            //for layering the bg image
            ZStack {
                Image("4")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .offset(x: -20)
               
                VStack {
                    Spacer()

                    Text("Select Experience Time")
                        .font(.headline)
                        .padding()
                    
                    Picker("Duration", selection: $selectedDuration) {
                        ForEach(durations, id: \.self) { duration in
                            Text("\(duration) minutes")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    NavigationLink(destination: ExperienceView(selectedDuration: selectedDuration)) {
                        Text("Start Experience")
                            .font(.title)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Spacer()
                }
            }
            .onAppear {
                playBackgroundMusic()
            }
            .onDisappear {
                stopBackgroundMusic()
            }
        }
    }

    func playBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "1", withExtension: "mp3") { 
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // looping indefinitely
                audioPlayer?.play()
            } catch {
                print("Error playing background music: \(error)")
            }
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
