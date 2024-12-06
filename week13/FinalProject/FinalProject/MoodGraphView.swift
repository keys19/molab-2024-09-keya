//
//  MoodGraphView.swift
//  FinalProject
//
//  Created by Keya Shah on 04/12/2024.
//
import SwiftUI

// Data Model for MoodPoint
struct MoodPoint: Identifiable {
    let id = UUID()
    var time: String
    var moodValue: CGFloat // Represents mood (0 = Low, 1 = High)
}

// ViewModel to Manage Mood Data
import FirebaseFirestore

class MoodGraphViewModel: ObservableObject {
    @Published var moodPoints: [MoodPoint] = [
        MoodPoint(time: "Morning", moodValue: 0.5),
        MoodPoint(time: "Afternoon", moodValue: 0.7),
        MoodPoint(time: "Evening", moodValue: 0.4),
        MoodPoint(time: "Night", moodValue: 0.6)
    ]

    private let db = Firestore.firestore()

    func saveMoodDataToFirebase() {
        let moodData: [String: Any] = [
            "date": Date(),
            "moods": moodPoints.map { ["time": $0.time, "moodValue": $0.moodValue] }
        ]

        db.collection("moodTracking").addDocument(data: moodData) { error in
            if let error = error {
                print("Error saving mood data: \(error.localizedDescription)")
            } else {
                print("Mood data saved successfully.")
            }
        }
    }
}
// Main Graph View
struct MoodGraphView: View {
    @StateObject private var viewModel = MoodGraphViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Trace Your Day")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
                .padding(.top)

            // Subtitle
            Text("Adjust how you felt throughout the day.")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Graph Container
            GeometryReader { geometry in
                ZStack {
                    // Background Grid
                    GridLines()

                    // Y-Axis Labels
                    VStack {
                        Text("High")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Low")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 10)

                    // Mood Path
                    Path { path in
                        for index in viewModel.moodPoints.indices {
                            let x = geometry.size.width / CGFloat(viewModel.moodPoints.count) * CGFloat(index + 1)
                            let y = (1 - viewModel.moodPoints[index].moodValue) * geometry.size.height
                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)

                    // Draggable Mood Points
                    ForEach(viewModel.moodPoints.indices, id: \.self) { index in
                        let x = geometry.size.width / CGFloat(viewModel.moodPoints.count) * CGFloat(index + 1)
                        let y = (1 - viewModel.moodPoints[index].moodValue) * geometry.size.height

                        Circle()
                            .fill(Color.orange)
                            .frame(width: 16, height: 16)
                            .position(x: x, y: y)
                            .gesture(DragGesture()
                                .onChanged { value in
                                    let newY = max(0, min(value.location.y / geometry.size.height, 1))
                                    viewModel.moodPoints[index].moodValue = 1 - newY
                                }
                            )
                    }

                    // X-Axis Labels
                    HStack {
                        ForEach(viewModel.moodPoints) { moodPoint in
                            Text(moodPoint.time)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top, geometry.size.height + 10)
                }
            }
            .frame(height: 300)
            .padding(.horizontal)

            Spacer()

            // Save Button
            Button(action: saveMoodData) {
                Text("Save Mood Data")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }

    // Save Data Functionality
    func saveMoodData() {
        viewModel.saveMoodDataToFirebase()
    }
}

// Grid Lines for Graph Background
struct GridLines: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                // Horizontal Lines
                let spacingY: CGFloat = geometry.size.height / 5
                for i in 0...5 {
                    let y = CGFloat(i) * spacingY
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }

                // Vertical Lines
                let spacingX: CGFloat = geometry.size.width / 4
                for i in 0...4 {
                    let x = CGFloat(i) * spacingX
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }
            }
            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        }
    }
}

// Preview Provider for Testing
struct MoodGraphView_Previews: PreviewProvider {
    static var previews: some View {
        MoodGraphView()
    }
}
