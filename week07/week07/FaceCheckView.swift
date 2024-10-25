//
//  FaceCheckView.swift
//  week07
//
//  Created by Keya Shah on 24/10/2024.
//

import Foundation
import SwiftUI

struct FaceCheckView: UIViewControllerRepresentable {
    @Binding var analysis: String

    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "main") as! ViewController
        
        viewController.reportChange = {
            analysis = viewController.analysis
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
       
    }
}
