//import Foundation
//
//
//// function to load text from a file
//func load(_ file: String) -> String? {
//    if let path = Bundle.main.path(forResource: file, ofType: "txt") {
//        do {
//            let str = try String(contentsOfFile: path, encoding: .utf8)
//            return str
//        } catch {
//            print("Failed to read file: \(error.localizedDescription)")
//            return nil
//        }
//    } else {
//        print("File not found: \(file).txt")
//        return nil
//    }
//}
//
//print("Are you team teddy or panda??")
////loading file
//if let bear = load("bear") {
//    print(bear)
//} else {
//    print("Failed to load bear.txt")
//}
//
//
//if let panda = load("panda") {
//    print(panda)
//} else {print("Failed to load panda.txt")}
////source:http://artscene.textfiles.com/asciiart/asciiart.txt
////http://artscene.textfiles.com/asciiart/panda
//

//trying to shrink size

//import Foundation
//
//// Function to load text from a file
//func load(_ file: String) -> String? {
//    if let path = Bundle.main.path(forResource: file, ofType: "txt") {
//        do {
//            let str = try String(contentsOfFile: path, encoding: .utf8)
//            return str
//        } catch {
//            print("Failed to read file: \(error.localizedDescription)")
//            return nil
//        }
//    } else {
//        print("File not found: \(file).txt")
//        return nil
//    }
//}
//
//// Function to scale down ASCII art by reducing lines and characters per line
//func shrinkASCIIArt(_ art: String, widthScale: Int = 2, heightScale: Int = 2) -> String {
//    let lines = art.components(separatedBy: "\n")  // Split the art into lines
//    var shrunkArt = ""
//
//    // Iterate over the lines, skipping some lines to reduce vertical size
//    for (index, line) in lines.enumerated() where index % heightScale == 0 {
//        // Take only some characters in each line to reduce horizontal size
//        let shrunkLine = String(line.enumerated().compactMap { (i, char) in
//            return i % widthScale == 0 ? char : nil
//        })
//        shrunkArt += shrunkLine + "\n"  // Add the scaled line
//    }
//
//    return shrunkArt
//}
//
//print("Are you team teddy or panda??")
//
//// Loading and shrinking the bear ASCII art
//if let bear = load("bear") {
//    print(bear)
////    print(shrinkASCIIArt(bear, widthScale: 2, heightScale: 2))
//} else {
//    print("Failed to load bear.txt")
//}
//
//// Loading and shrinking the panda ASCII art
//if let panda = load("panda") {
//    print("Panda (scaled down):")
//    print(shrinkASCIIArt(panda, widthScale: 2, heightScale: 2))  // Adjust scaling here
//} else {
//    print("Failed to load panda.txt")
//}



//version with bear and panda side by side
import Foundation

// function to load text from a file
func load(_ file: String) -> String? {
    if let path = Bundle.main.path(forResource: file, ofType: "txt") {
        do {
            let str = try String(contentsOfFile: path, encoding: .utf8)
            return str
        } catch {
            print("Failed to read file: \(error.localizedDescription)")
            return nil
        }
    } else {
        print("File not found: \(file).txt")
        return nil
    }
}

//scaling down ASCII art by reducing lines and characters per line
func shrinkASCIIArt(_ art: String, widthScale: Int = 2, heightScale: Int = 2) -> String {
    let lines = art.components(separatedBy: "\n")  // Split the art into lines
    var shrunkArt = ""
    
    // iterating over the lines, skipping some lines to reduce vertical size
    for (index, line) in lines.enumerated() where index % heightScale == 0 {
        // take only some characters in each line to reduce horizontal size
        let shrunkLine = String(line.enumerated().compactMap { (i, char) in
            return i % widthScale == 0 ? char : nil
        })
        shrunkArt += shrunkLine + "\n"
    }
    
    return shrunkArt
}

//combining two ASCII art strings side by side
func combineSideBySide(_ art1: String, _ art2: String) -> String {
    let lines1 = art1.components(separatedBy: "\n")
    let lines2 = art2.components(separatedBy: "\n")
    
    // padding the shorter one with empty lines so both have the same number of lines
    let maxLines = max(lines1.count, lines2.count)
    let paddedLines1 = lines1 + Array(repeating: "", count: maxLines - lines1.count)
    let paddedLines2 = lines2 + Array(repeating: "", count: maxLines - lines2.count)
    
    var combinedArt = ""
    
    for i in 0..<maxLines {
        combinedArt += paddedLines1[i].padding(toLength: 40, withPad: " ", startingAt: 0) + " " + paddedLines2[i] + "\n"
    }
    
    return combinedArt
}

print("Are you team teddy or panda??")

// loading and shrinking the bear ASCII art
let bearArt: String = {
    if let bear = load("bear") {
        return shrinkASCIIArt(bear, widthScale: 2, heightScale: 2)
        //        return bear
    } else {
        return "Bear art could not be loaded."
    }
}()

// loading and shrinking the panda ASCII art
let pandaArt: String = {
    if let panda = load("panda") {
        return shrinkASCIIArt(panda, widthScale: 3, heightScale: 3)
    } else {
        return "Panda art could not be loaded."
    }
}()

// combining bear and panda side by side and print the result
let combinedArt = combineSideBySide(bearArt, pandaArt)
print(combinedArt)

print("i think bear!")
//full sized bear
// loading and shrinking the bear ASCII art
let bearArt2: String = {
    if let bear = load("bear") {
//        return shrinkASCIIArt(bear, widthScale: 2, heightScale: 2)
                print(bear)
            return bear
    } else {
        return "Bear art could not be loaded."
    }
}()

//source:http://artscene.textfiles.com/asciiart/asciiart.txt
//http://artscene.textfiles.com/asciiart/panda
//enlarging/changing text sizes: https://codegolf.stackexchange.com/questions/232957/enlarge-ascii-art-mark-ii?noredirect=1&lq=1
