//
//  ViewController.swift
//  True Depth
//
//  Created by Sai Kambampati on 2/23/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var faceLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    var analysis = ""
    var reportChange: (() -> Void)!
    
    override func viewDidLoad() {
        print("ViewController viewDidLoad")
        super.viewDidLoad()
        
        labelView.layer.cornerRadius = 10
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face tracking is not supported on this device")
            return
        }
        
        //disable UIKit label in Main.storyboard
        labelView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewController viewWillAppear")

        super.viewWillAppear(animated)

        let configuration = ARFaceTrackingConfiguration()


        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("ViewController viewWillDisappear")

        super.viewWillDisappear(animated)
        

        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        let node = SCNNode(geometry: faceMesh)
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            expression(anchor: faceAnchor)
            
            DispatchQueue.main.async {
               
                self.reportChange()
            }
            
        }
    }
    
    func expression(anchor: ARFaceAnchor) {
    
        let smileLeft = anchor.blendShapes[.mouthSmileLeft]
        let smileRight = anchor.blendShapes[.mouthSmileRight]
        let cheekPuff = anchor.blendShapes[.cheekPuff]
        let browDownLeft = anchor.blendShapes[.browDownLeft]
        let browDownRight = anchor.blendShapes[.browDownRight]
        let browInnerUp = anchor.blendShapes[.browInnerUp]
        let eyeBlinkLeft = anchor.blendShapes[.eyeBlinkLeft]
        let eyeBlinkRight = anchor.blendShapes[.eyeBlinkRight]
        let jawOpen = anchor.blendShapes[.jawOpen]
        let eyeSquintLeft = anchor.blendShapes[.eyeSquintLeft]
        let eyeSquintRight = anchor.blendShapes[.eyeSquintRight]
        let tongue = anchor.blendShapes[.tongueOut]
        
    
        self.analysis = ""

        // Ready to Meditate (relaxed face, neutral expression)
        let relaxedFace = (browDownLeft?.decimalValue ?? 0.0) < 0.3 &&
                          (browDownRight?.decimalValue ?? 0.0) < 0.3 &&
                          (browInnerUp?.decimalValue ?? 0.0) < 0.3 &&
                          (eyeBlinkLeft?.decimalValue ?? 0.0) < 0.6 &&
                          (eyeBlinkRight?.decimalValue ?? 0.0) < 0.6 &&
                          (jawOpen?.decimalValue ?? 0.0) < 0.2

        if relaxedFace {
            self.analysis += "Your face looks relaxed, you are ready to meditate. "
        }

        // Not Ready to Meditate (tension, frustration, stress)
        let stressedFace = (browDownLeft?.decimalValue ?? 0.0) > 0.4 ||
                           (browDownRight?.decimalValue ?? 0.0) > 0.4 ||
                           (jawOpen?.decimalValue ?? 0.0) > 0.4 ||
                           (eyeSquintLeft?.decimalValue ?? 0.0) > 0.4 ||
                           (eyeSquintRight?.decimalValue ?? 0.0) > 0.4

        if stressedFace {
            self.analysis += "You seem tense or stressed, try to relax. "
        }

        // Slight Smile (calm, positive, but ready for meditation)
        let slightSmile = ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) > 0.2 &&
                          ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) < 0.6

        if slightSmile {
            self.analysis += "You have a slight smile, you might be in a calm and positive mood. "
        }

        // Overly Smiling (may indicate excitement or distraction, not ready to meditate)
        let overlySmiling = ((smileLeft?.decimalValue ?? 0.0) + (smileRight?.decimalValue ?? 0.0)) > 0.8

        if overlySmiling {
            self.analysis += "You are smiling a lot, you might be too excited to meditate. "
        }

        // Distraction or Stress (tongue out, cheek puff, jaw tension)
        if tongue?.decimalValue ?? 0.0 > 0.2 {
            self.analysis += "Your tongue is out, try to focus and relax. "
        }
        
        if cheekPuff?.decimalValue ?? 0.0 > 0.2 {
            self.analysis += "Your cheeks are puffed, take a deep breath to relax. "
        }

        // Check for blink rate to assess focus or distraction
        if (eyeBlinkLeft?.decimalValue ?? 0.0) > 0.7 && (eyeBlinkRight?.decimalValue ?? 0.0) > 0.7 {
            self.analysis += "You might be blinking a lot, which could indicate distraction or fatigue. "
        }

        // General feedback based on the analysis
        if relaxedFace && slightSmile && !(overlySmiling || stressedFace) {
            self.analysis += "You are calm and relaxed, perfect for meditation. "
        }else if stressedFace || overlySmiling || (tongue?.decimalValue ?? 0.0) > 0.2 || (cheekPuff?.decimalValue ?? 0.0) > 0.2 {
            self.analysis += "Try to calm down and focus on your breathing before meditating. "
        }
    }

}
