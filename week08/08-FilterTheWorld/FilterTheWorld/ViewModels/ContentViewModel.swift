/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
//
//import CoreImage
//
//class ContentViewModel: ObservableObject {
//  @Published var error: Error?
//  @Published var frame: CGImage?
//
//  var comicFilter = false
//  var monoFilter = false
//  var crystalFilter = false
//  var otherFilter = false
//
//  private let context = CIContext()
//
//  private let cameraManager = CameraManager.shared
//  private let frameManager = FrameManager.shared
//
//  init() {
//    setupSubscriptions()
//  }
//
//  func setupSubscriptions() {
//    // swiftlint:disable:next array_init
//    cameraManager.$error
//      .receive(on: RunLoop.main)
//      .map { $0 }
//      .assign(to: &$error)
//
//    frameManager.$current
//      .receive(on: RunLoop.main)
//      .compactMap { buffer in
//        guard let image = CGImage.create(from: buffer) else {
//          return nil
//        }
//
//        var ciImage = CIImage(cgImage: image)
//
//        if self.otherFilter {
//          let param = [
//            "inputRadius": 40.0,
//            "inputIntensity": 1.0
//          ];
//          ciImage = ciImage.applyingFilter("CIBloom", parameters: param)
//        }
//
//        if self.crystalFilter {
//          ciImage = ciImage.applyingFilter("CICrystallize")
//        }
//
//        if self.comicFilter {
//          ciImage = ciImage.applyingFilter("CIComicEffect")
//        }
//
//        if self.monoFilter {
//          ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
//        }
//        
//        return self.context.createCGImage(ciImage, from: ciImage.extent)
//      }
//      .assign(to: &$frame)
//  }
//}



//import CoreImage
//
//class ContentViewModel: ObservableObject {
//    @Published var error: Error?
//    @Published var frame: CGImage?
//
//    var comicFilter = false
//    var monoFilter = false
//    var crystalFilter = false
//    var otherFilter = false
//    var kaleidoscopeFilter = false // New kaleidoscope filter
//
//    private let context = CIContext()
//
//    private let cameraManager = CameraManager.shared
//    private let frameManager = FrameManager.shared
//
//    init() {
//        setupSubscriptions()
//    }
//
//    func setupSubscriptions() {
//        cameraManager.$error
//            .receive(on: RunLoop.main)
//            .map { $0 }
//            .assign(to: &$error)
//
//        frameManager.$current
//            .receive(on: RunLoop.main)
//            .compactMap { buffer in
//                guard let image = CGImage.create(from: buffer) else {
//                    return nil
//                }
//
//                var ciImage = CIImage(cgImage: image)
//
//                // Apply kaleidoscope effect if enabled
//                if self.kaleidoscopeFilter {
//                    if let kaleidoscopeImage = self.applyKaleidoscopeFilter(to: ciImage) {
//                        return self.context.createCGImage(kaleidoscopeImage, from: kaleidoscopeImage.extent)
//                    } else {
//                        print("Failed to create kaleidoscope effect.")
//                        return nil
//                    }
//                } else {
//                    // Apply standard filters based on selections
//                    return self.context.createCGImage(self.applyStandardFilters(to: ciImage), from: ciImage.extent)
//                }
//            }
//            .assign(to: &$frame)
//    }
//
//    // Apply standard filters based on toggles
//    private func applyStandardFilters(to ciImage: CIImage) -> CIImage {
//        var filteredImage = ciImage
//
//        if self.otherFilter {
//            let param = ["inputRadius": 40.0, "inputIntensity": 1.0]
//            filteredImage = filteredImage.applyingFilter("CIBloom", parameters: param)
//        }
//
//        if self.crystalFilter {
//            filteredImage = filteredImage.applyingFilter("CICrystallize")
//        }
//
//        if self.comicFilter {
//            filteredImage = filteredImage.applyingFilter("CIComicEffect")
//        }
//
//        if self.monoFilter {
//            filteredImage = filteredImage.applyingFilter("CIPhotoEffectNoir")
//        }
//
//        return filteredImage
//    }
//
//    // Apply kaleidoscope filter
//    private func applyKaleidoscopeFilter(to ciImage: CIImage) -> CIImage? {
//        let kaleidoscope = CIFilter(name: "CITriangleKaleidoscope")
//        kaleidoscope?.setValue(ciImage, forKey: kCIInputImageKey)
//        kaleidoscope?.setValue(200.0, forKey: "inputSize")           // Tile size
//        kaleidoscope?.setValue(0.0, forKey: "inputRotation")         // Angle of rotation
//        kaleidoscope?.setValue(0.85, forKey: "inputDecay")           // Decay for smooth blending
//        
//        guard let outputImage = kaleidoscope?.outputImage else {
//            print("Kaleidoscope filter failed to generate output image.")
//            return nil
//        }
//        
//        return outputImage.cropped(to: ciImage.extent) // Crop to original size to avoid any layout issues
//    }
//}


import CoreImage

class ContentViewModel: ObservableObject {
    @Published var error: Error?
    @Published var frame: CGImage?

    var retroMode = false
    var popArtMode = false
    var sciFiMode = false
  
    @Published var bloomIntensity: Float = 1.5
    private var animationTimer: Timer?

    private let context = CIContext()
    private let cameraManager = CameraManager.shared
    private let frameManager = FrameManager.shared

    init() {
        setupSubscriptions()
        startSciFiAnimation()
    }

    func setupSubscriptions() {
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map { $0 }
            .assign(to: &$error)

        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { buffer in
                guard let image = CGImage.create(from: buffer) else {
                    return nil
                }

                var ciImage = CIImage(cgImage: image)

                
                if self.retroMode {
                    ciImage = self.applyRetroMode(to: ciImage)
                } else if self.popArtMode {
                    ciImage = self.applyPopArtMode(to: ciImage)
                } else if self.sciFiMode {
                    ciImage = self.applySciFiMode(to: ciImage)
                }

                return self.context.createCGImage(ciImage, from: ciImage.extent)
            }
            .assign(to: &$frame)
    }

    // Retro Mode
    private func applyRetroMode(to ciImage: CIImage) -> CIImage {
        return ciImage
            .applyingFilter("CISepiaTone", parameters: [kCIInputIntensityKey: 0.8])
            .applyingFilter("CIVignette", parameters: ["inputRadius": 2.0, "inputIntensity": 1.0])
            .applyingFilter("CINoiseReduction", parameters: ["inputNoiseLevel": 0.02, "inputSharpness": 0.5])
    }

    // Pop Art Mode
//    private func applyPopArtMode(to ciImage: CIImage) -> CIImage {
//        return ciImage
//            .applyingFilter("CIColorInvert")
//            .applyingFilter("CIHueAdjust", parameters: [kCIInputAngleKey: Float.pi / 2])
//            .applyingFilter("CIPixellate", parameters: ["inputScale": 10.0])
//    }
  private func applyPopArtMode(to ciImage: CIImage) -> CIImage {
      let size = ciImage.extent.size

      
      let colorFilters: [(CIFilter, CIFilter)] = [
          (
              CIFilter(name: "CIColorControls", parameters: [
                  kCIInputSaturationKey: 1.8, kCIInputBrightnessKey: 0.2, kCIInputContrastKey: 1.4
              ])!,
              CIFilter(name: "CIHueAdjust", parameters: [kCIInputAngleKey: Float.pi / 3])!
          ),
          (
              CIFilter(name: "CIColorControls", parameters: [
                  kCIInputSaturationKey: 1.5, kCIInputBrightnessKey: -0.1, kCIInputContrastKey: 1.6
              ])!,
              CIFilter(name: "CIHueAdjust", parameters: [kCIInputAngleKey: Float.pi / 1.5])!
          ),
          (
              CIFilter(name: "CIColorControls", parameters: [
                  kCIInputSaturationKey: 2.0, kCIInputBrightnessKey: 0.1, kCIInputContrastKey: 1.7
              ])!,
              CIFilter(name: "CIHueAdjust", parameters: [kCIInputAngleKey: Float.pi])!
          ),
          (
              CIFilter(name: "CIColorControls", parameters: [
                  kCIInputSaturationKey: 1.6, kCIInputBrightnessKey: -0.2, kCIInputContrastKey: 1.3
              ])!,
              CIFilter(name: "CIHueAdjust", parameters: [kCIInputAngleKey: -Float.pi / 2])!
          )
      ]

     
      let quadrants: [CIImage] = colorFilters.compactMap { colorFilter, hueFilter in
          colorFilter.setValue(ciImage, forKey: kCIInputImageKey)
          guard let colorOutput = colorFilter.outputImage else { return nil }
          hueFilter.setValue(colorOutput, forKey: kCIInputImageKey)
          return hueFilter.outputImage?.cropped(to: CGRect(origin: .zero, size: CGSize(width: size.width / 2, height: size.height / 2)))
      }

      
      guard quadrants.count == 4 else { return ciImage }

      // creating a 2x2 grid
      let halfWidth = size.width / 2
      let halfHeight = size.height / 2
      let topLeft = quadrants[0]
      let topRight = quadrants[1].transformed(by: CGAffineTransform(translationX: halfWidth, y: 0))
      let bottomLeft = quadrants[2].transformed(by: CGAffineTransform(translationX: 0, y: halfHeight))
      let bottomRight = quadrants[3].transformed(by: CGAffineTransform(translationX: halfWidth, y: halfHeight))

      // Composite the four quadrants into a single image
      let combinedImage = topLeft
          .composited(over: topRight)
          .composited(over: bottomLeft)
          .composited(over: bottomRight)

      // Crop to the original size to prevent overflow
      return combinedImage.cropped(to: ciImage.extent)
  }


    // Sci-Fi Mode
//    private func applySciFiMode(to ciImage: CIImage) -> CIImage {
//        let colorMatrix = CIFilter(name: "CIColorMatrix", parameters: [
//            "inputRVector": CIVector(x: 1.5, y: 0.0, z: 0.0, w: 0.0),
//            "inputGVector": CIVector(x: 0.0, y: 0.8, z: 0.0, w: 0.0),
//            "inputBVector": CIVector(x: 0.0, y: 0.0, z: 1.2, w: 0.0)
//        ])
//        let bloom = ciImage.applyingFilter("CIBloom", parameters: ["inputRadius": 10.0, "inputIntensity": 1.5])
//        
//        return colorMatrix?.outputImage?.composited(over: bloom) ?? bloom
//    }
  private func applySciFiMode(to ciImage: CIImage) -> CIImage {
      let colorMatrix = CIFilter(name: "CIColorMatrix", parameters: [
          "inputRVector": CIVector(x: 1.0, y: 0.0, z: 0.0, w: 0.0),
          "inputGVector": CIVector(x: 0.0, y: 1.0, z: 0.4, w: 0.0),
          "inputBVector": CIVector(x: 0.0, y: 0.4, z: 1.2, w: 0.0),
          "inputBiasVector": CIVector(x: 0.1, y: 0.1, z: 0.1, w: 0.0)
      ])
      colorMatrix?.setValue(ciImage, forKey: kCIInputImageKey)
      guard let colorizedImage = colorMatrix?.outputImage else { return ciImage }

      let bloom = colorizedImage.applyingFilter("CIBloom", parameters: [
          "inputRadius": 10.0,
          "inputIntensity": bloomIntensity
      ])

      let glitch = bloom.applyingFilter("CIPixellate", parameters: [
          "inputScale": 8.0
      ])

      return glitch.cropped(to: ciImage.extent)
  }
  
  private func startSciFiAnimation() {
      animationTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
          self.bloomIntensity = 1.5 + 0.5 * Float(sin(CFAbsoluteTimeGetCurrent()))
      }
  }


     
     deinit {
         animationTimer?.invalidate()
     }

}


