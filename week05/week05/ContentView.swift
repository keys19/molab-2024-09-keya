//
//  ContentView.swift
//  week05
//
//  Created by Keya Shah on 10/10/2024.
//

////import SwiftUI
////
////struct ContentView: View {
////    var body: some View {
////        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Hello, world!")
////        }
////        .padding()
////    }
////}
////
////#Preview {
////    ContentView()
////}
//import SwiftUI
//import AVFoundation
//struct ContentView: View {
//    //animation variables
//    @State private var scale: CGFloat = 1.0
//    @State private var rippleEffect = false
//    @State private var opacity: Double = 0.5
//    
//    @State private var audioPlayer: AVAudioPlayer?
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Image("4")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                    .offset(x: -20)
//                VStack {
//                    Text("Mindful Minutes")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding()
//                    
//                    // breathing circle animation
////                                   Circle()
////                                       .stroke(lineWidth: 4)
////                                       .scaleEffect(scale)
////                                       .opacity(0.5)
////                                       .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true))
////                                       .onAppear {
////                                           scale = 1.5
////                                       }
////                                       .frame(width: 150, height: 150)
////                                       .padding()
//                    //ripple animation
////                    Circle()
////                            .stroke(lineWidth: 2)
////                            .scaleEffect(rippleEffect ? 2 : 0.5)
////                            .opacity(rippleEffect ? 0 : 1)
////                            .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false))
////                            .onAppear {
////                                rippleEffect.toggle()
////                            }
//                    
//                    //gradient animation
//                    RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(opacity), Color.white.opacity(0)]), center: .center, startRadius: 20, endRadius: 200)
//                            .onAppear {
//                                withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
//                                    opacity = 1.0
//                                }
//                            }
//                    NavigationLink(destination: MeditationSelectionView()) {
//                        Text("Begin Your Calmness Journey")
//                            .font(.title2)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                }
//                .onAppear {
//                                playBackgroundMusic()
//                            }
//            }
//        }
//    }
//}
//
//func playBackgroundMusic() {
//        guard let path = Bundle.main.path(forResource: "background_music", ofType: "mp3") else {
//            print("Background music file not found")
//            return
//        }
//
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.numberOfLoops = -1
//            audioPlayer?.play()
//        } catch {
//            print("Error playing background music: \(error.localizedDescription)")
//        }
//    }
//}


import SwiftUI
import AVFoundation

struct ContentView: View {
    // animation variables
    @State private var scale: CGFloat = 1.0
    @State private var rippleEffect = false
    @State private var opacity: Double = 0.5
    
    // audio player state
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        NavigationView {
            ZStack {
          
                Image("4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .offset(x: -20)
                
                VStack {

                    Text("Mindful Minutes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    // Breathing circle animation
//                    Circle()
//                        .stroke(lineWidth: 4)
//                        .scaleEffect(scale)
//                        .opacity(0.5)
//                        .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true))
//                        .onAppear {
//                            scale = 1.5
//                        }
//                        .frame(width: 150, height: 150)
//                        .padding()

                    // Ripple effect animation
//                    Circle()
//                        .stroke(lineWidth: 2)
//                        .scaleEffect(rippleEffect ? 2 : 0.5)
//                        .opacity(rippleEffect ? 0 : 1)
//                        .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false))
//                        .onAppear {
//                            rippleEffect.toggle()
//                        }
                    
                    // Gradient animation
                    RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(opacity), Color.white.opacity(0)]), center: .center, startRadius: 20, endRadius: 200)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                                    opacity = 1.0
                                }
                            }
                                           
                    
                    // Navigation link to meditation selection
                    NavigationLink(destination: MeditationSelectionView()) {
                        Text("Begin Your Calmness Journey")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
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
    }


    func playBackgroundMusic() {
        guard let path = Bundle.main.path(forResource: "1", ofType: "mp3") else {
            print("Background music file not found")
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }


    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}


#Preview {
    ContentView()
}
//sources
//audios are from pixabay
//images are from pinterest
// https://www.appcoda.com/animate-gradient-swiftui/
