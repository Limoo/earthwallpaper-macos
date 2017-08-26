//
//  ViewController.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 04/02/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa
import Alamofire

class EarthPornWallpaper {
    
    static let folder = "Earth/"
    static let RedditURL = URL(string: "https://www.reddit.com/r/EarthPorn/.json?limit=5")!
    var timer:Timer? = nil
    
    static let shared = EarthPornWallpaper()
    
    @objc static func setBackground(){
        self.requestRedditObject(completion: {( redditObject) in
            if let imageUrl = extractImageUrlFrom(redditObject: redditObject), let image = NSImage(contentsOf: imageUrl), let data = convertToDataFor(image: image, type: .png) {
                let directory = createImageDirectory()
                let fileURL = saveDataToDirectory(name: imageUrl.lastPathComponent, data: data, directory: directory)
                setBackgroundFor(url: fileURL)
            }
        })
    }
    
    private static func convertToDataFor(image:NSImage, type: NSBitmapImageRep.FileType) -> Data? {
        var data:Data? = nil
        if let bits = image.representations.first as? NSBitmapImageRep {
            
            switch(type){
            case .png:
                data = bits.representation(using: .png, properties: [:])
                break
            case .jpeg:
                data = bits.representation(using: .jpeg, properties: [:])
                break
            default:
                break
            }
        }
        return data
    }
    
    private static func saveDataToDirectory(name:String, data:Data, directory:URL) -> URL {
        let fileURL = directory.appendingPathComponent(name)
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
        return fileURL
    }

    private static func createImageDirectory() -> URL{
        let directory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.folder)
        do{
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false, attributes: nil)
        }
        catch{
            //directory already exists
        }
        return directory
    }
    
    private static func FixImageUrlString(urlString: String) -> String {
        var pUrlString = urlString
        if(pUrlString.range(of: ".png") == nil && pUrlString.range(of: ".jpg") == nil){
            pUrlString += ".png"
        }
        pUrlString = pUrlString.replacingOccurrences(of: "&amp;", with: "&")
        return pUrlString
    }
    
    private static func extractImageUrlFrom(redditObject: RedditDto) -> URL? {
        var imageUrl:URL? = nil
        
        if let children = redditObject.data?.children {
            for child in children {
                
                if let sticky = child.data?.stickied, let urlString = child.data?.preview?.images?[0].source?.url {
                    if !sticky, let url = URL(string: FixImageUrlString(urlString: urlString)) {
                        imageUrl = url
                        break
                    }
                }
                
            }
        }
        return imageUrl
    }
    
    private static func requestRedditObject(completion: @escaping (RedditDto) -> ())  {
        Alamofire.request(RedditURL).responseString(completionHandler: { (response) in
            if let jsonString = response.result.value {
                if let data = jsonString.data(using: .utf8) {
                    do{
                        let object = try JSONDecoder().decode(RedditDto.self, from: data)
                        completion(object)
                    }
                    catch{
                        print(error)
                    }
                }
            }
        })
    }
    
    private static func setBackgroundFor(url: URL) {
        if let screen = NSScreen.main  {
            try! NSWorkspace.shared.setDesktopImageURL(url, for: screen, options: [:])
        }
    }
    
    func start(min:Int){
        EarthPornWallpaper.setBackground()
        let seconds = min * 60
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self, selector: #selector(EarthPornWallpaper.setBackground), userInfo: nil, repeats: true)
    }

}

