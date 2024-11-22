//
//  InteractiveMandalaView.swift
//  FinalProject
//
//  Created by Keya Shah on 19/11/2024.
//

import Foundation


import SwiftUI
import SVGKit

import SwiftUI
import SVGKit

struct InteractiveMandalaView: UIViewRepresentable {
    let svgName: String
    @Binding var selectedColor: UIColor
    @Binding var pathColors: [String: UIColor] // Tracks colors assigned to paths

    func makeUIView(context: Context) -> SVGKFastImageView {
        // Load the SVG file
        guard let svgImage = SVGKImage(named: svgName) else {
            fatalError("Unable to load SVG file: \(svgName)")
        }
        
        // Safely initialize SVGKFastImageView
        guard let svgView = SVGKFastImageView(svgkImage: svgImage) else {
            fatalError("Unable to create SVGKFastImageView")
        }
        
        svgView.contentMode = .scaleAspectFit
        svgView.isUserInteractionEnabled = true

        // Add tap gesture recognizer to handle path selection
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        svgView.addGestureRecognizer(tapGesture)

        return svgView
    }

    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        // Update path colors dynamically
        for (pathId, color) in pathColors {
            if let shapeLayer = uiView.layer.sublayers?.compactMap({ $0 as? CAShapeLayer }).first(where: { $0.name == pathId }) {
                shapeLayer.fillColor = color.cgColor
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: Coordinator for handling interactions
    class Coordinator: NSObject {
        var parent: InteractiveMandalaView

        init(_ parent: InteractiveMandalaView) {
            self.parent = parent
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let svgView = sender.view as? SVGKFastImageView else { return }
            let tapLocation = sender.location(in: svgView)

            // Iterate through paths in the SVG
            if let layers = svgView.layer.sublayers {
                for layer in layers {
                    if let shapeLayer = layer as? CAShapeLayer, shapeLayer.path?.contains(tapLocation) == true {
                        // Assign the selected color to the tapped path
                        shapeLayer.fillColor = parent.selectedColor.cgColor
                        if let pathId = shapeLayer.name {
                            parent.pathColors[pathId] = parent.selectedColor
                        }
                        break
                    }
                }
            }
        }
    }
}
