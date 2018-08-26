import Foundation

import Swiftline
import ColorizeSwift
import CommandLineKit


func getRating(OfMoviewName movieName:String,movieRatingBlock blck:@escaping ((Float,String)->Void)){
    let withoutSpcxAe = movieName.replacingOccurrences(of: " ", with: "%20")
    let rawUrl = "https://www.omdbapi.com/?t=\(withoutSpcxAe)&apikey=7425eaae"
    print("raw url is \(rawUrl)")
    let url = URL(string: rawUrl)!
    let request = URLRequest(url: url)
    print(rawUrl)
    let task = URLSession.shared.dataTask(with: request) { (data, req, error) in
        if data != nil{
            do{
                let resp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                print("Response is \(resp)")
                if let rating  = resp["imdbRating"] as? String{
                    blck(Float(rating)!,movieName)
                }
                else{
                    print("else block")
                    blck(0.0,movieName)
                }
            }catch{
                print("catch block \(error)")
                blck(0.0,movieName)
            }
            
        }
    }
    task.resume()
    
}

let cli = CommandLineKit.CommandLine()
let dirPath = StringOption(shortFlag: "t", longFlag: "filetypes", helpMessage: "List all the types of files in current directory")
cli.addOptions(dirPath)
do {
    try cli.parse()
} catch {
    cli.printUsage(error)
}
print(dirPath.value!)
var extensions = [String]() // Array to hold types of files present in the given directory
let fileManager = FileManager.default
let dirURL = URL(fileURLWithPath: dirPath.value!)
var movieNames = [String]()
var movieWithRating = [String:Float]()

do {
    // fileURLs contains urls of all the files in the given directory
    let fileURLs = try fileManager.contentsOfDirectory(at: dirURL, includingPropertiesForKeys: nil)
    // Getting the unique file types
    for file in fileURLs {
        // let arr = file.componentsSeparatedByString("(")
        let absName = file.absoluteString
        let replaced = absName.replacingOccurrences(of: "file://\(dirPath.value!)/", with: "")
        let correctWithSpace = replaced.replacingOccurrences(of: "%20", with: " ")
        if !correctWithSpace.hasPrefix("."){
            let arr  = correctWithSpace.components(separatedBy: "(")
            let str0 = String(arr[0])
            let correctFileName = str0.replacingOccurrences(of: "/", with: "")
            movieNames.append(correctFileName)
            getRating(OfMoviewName: correctFileName) { (rating, ofMovie) in
                movieWithRating[ofMovie] = rating
                movieNames.remove(at: movieNames.index(of: ofMovie)!)
                if(movieNames.count == 0){
                    print(movieWithRating)
                    let textFile = dirURL.appendingPathComponent("result.txt")
                    var FullStr = ""
                    let sortedDict = movieWithRating.sorted { $0.1 > $1.1 }
                    for (key,value) in sortedDict{
                        FullStr += "\(key) = \(value) \n"
                    }
                    do{
                        let success = try FullStr.write(to: textFile, atomically: true, encoding: String.Encoding.utf8)
                        print("write: ", success)
                    }catch{
                        print("error in writiingf \(error)")
                    }
                    

                }
            }
            print(" NAME IS \(correctFileName)")
        }
    }
    
} catch {
    print("Error while enumerating files \(error.localizedDescription)")
}
RunLoop.main.run()
