//
//  ViewController.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 04/02/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class EarthPornWallpaper {
    
    //var imageUrl:String = "";
    
    var minutes:Int? = 0;
    
    static let folder = "Earth/";
    static let RedditURL = "https://www.reddit.com/r/EarthPorn/.json?limit=5";
    var timer:Timer? = nil;;
    
    @objc static func setBackground(){
        var imageUrl:String = "";
        
        
        Alamofire.request(RedditURL).responseObject { (response: DataResponse<RedditDto>) in
            if let result = response.result.value {
                
                
                
                for child in (result.data?.children)!{
                    if(!child.data!.stickied!){
                        imageUrl = child.data!.preview!.images![0].source!.url!;
                        break;
                    }
                }
                /*
                 if(imageUrl.range(of: ".png") == nil && imageUrl.range(of: ".jpg") == nil){
                 imageUrl += ".png"
                 }
                 */
                imageUrl = imageUrl.replacingOccurrences(of: "&amp;", with: "&");
                
                do {
                    let img = NSImage(contentsOf: URL(string: imageUrl)!);
                    if let bits = img?.representations.first as? NSBitmapImageRep {
                        var data:Data? = nil;
                        if(imageUrl.range(of: ".png") != nil){
                            data = bits.representation(using: .PNG, properties: [:])
                        }
                        else if(imageUrl.range(of: ".jpg") != nil){
                            data = bits.representation(using: .JPEG, properties: [:])
                        }
                        
                        let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.folder);
                        do{
                            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false, attributes: nil);
                        }
                        catch{
                            //directory already exists
                        }
                        
                        let fileURL = directory.appendingPathComponent((URL(string: imageUrl)!).lastPathComponent)
                        print(fileURL);
                        do {
                            try data?.write(to: fileURL, options: .atomic)
                        } catch {
                            print(error)
                        }
                        let workspace = NSWorkspace.shared()
                        if let screen = NSScreen.main()  {
                            print(imageUrl);
                            try workspace.setDesktopImageURL(fileURL, for: screen, options: [:])
                        }
                    }
                } catch {
                    print(error)
                    
                }
            }
            else{
                
            }
        }
        
    }
    
    static func start(min:Int){
        setBackground();
        let seconds = min * 60;
        let timer = Timer.scheduledTimer(timeInterval: TimeInterval(seconds), target: self, selector: #selector(setBackground), userInfo: nil, repeats: true);
    }
    
    
}

