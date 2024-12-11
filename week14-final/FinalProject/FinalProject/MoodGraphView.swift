//
//  MoodGraphView.swift
//  FinalProject
//
//  Created by Keya Shah on 04/12/2024.
//
import SwiftUI


import SwiftUI
import FirebaseFirestore

struct TraceYourDayView: View {
    @State private var points: [CGPoint] = [
        CGPoint(x: 40, y: 200),
        CGPoint(x: 130, y: 150),
        CGPoint(x: 220, y: 300),
        CGPoint(x: 310, y: 180)
    ]

    @State private var activePointIndex: Int? = nil
    @State private var navigateToChestView = false

    private let db = Firestore.firestore()

    // X-axis labels
    private let xLabels = ["Morning", "Afternoon", "Evening", "Night"]

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.9), Color.blue.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Title
                    Text("Trace Your Day")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    // Subtitle
                    Text("Adjust how you felt throughout the day.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))

                    // Graph Area
                    ZStack {
                        // Grid Lines
                        GraphGrid()

                        // Interactive Graph
                        Path { path in
                            path.move(to: points.first ?? .zero)
                            for point in points {
                                path.addLine(to: point)
                            }
                        }
                        .stroke(Color.white, lineWidth: 2)

                        // Draggable Points
                        ForEach(points.indices, id: \.self) { index in
                            Circle()
                                .fill(activePointIndex == index ? Color.purple : Color.white)
                                .frame(width: 16, height: 16)
                                .position(points[index])
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            points[index].y = max(50, min(300, value.location.y)) // Constrain drag to graph area
                                            activePointIndex = index
                                        }
                                        .onEnded { _ in
                                            activePointIndex = nil
                                        }
                                )
                        }

   
                        HStack {
                            ForEach(xLabels.indices, id: \.self) { index in
                                Text(xLabels[index])
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.top, 310)
                    }
                    .frame(height: 300)
                    .padding(.horizontal)

                    Spacer()

           
                    Button(action: {
                        saveMoodDataToFirebase()
                    }) {
                        Text("Save Mood Data")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.white)
                            .foregroundColor(.purple)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    .padding(.bottom, 40)
                }
                .padding()
            }
            .gesture(
                DragGesture(minimumDistance: 50, coordinateSpace: .local)
                    .onEnded { value in
                        //left swipe?
                        if value.translation.width < 0 {
                            navigateToChestView = true
                        }
                    }
            )
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: ChestView(),
                    isActive: $navigateToChestView,
                    label: { EmptyView() }
                )
            )
        }
    }

    // Function to Save Mood Data to Firebase
    func saveMoodDataToFirebase() {
        let moodData: [String: Any] = [
            "date": Date(),
            "moods": points.map { ["x": $0.x, "y": $0.y] }
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

// Grid for Graph
struct GraphGrid: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let rows = 5
                let cols = 4
                let rowHeight = geometry.size.height / CGFloat(rows)
                let colWidth = geometry.size.width / CGFloat(cols)

                // Horizontal lines
                for i in 0...rows {
                    let y = CGFloat(i) * rowHeight
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }

                // Vertical lines
                for i in 0...cols {
                    let x = CGFloat(i) * colWidth
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }
            }
            .stroke(Color.white.opacity(0.2), lineWidth: 1)
        }
    }
}



// Preview
struct TraceYourDayView_Previews: PreviewProvider {
    static var previews: some View {
        TraceYourDayView()
    }
}
