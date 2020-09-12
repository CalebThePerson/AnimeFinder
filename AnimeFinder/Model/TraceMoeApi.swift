//
//  TraceMoeApi.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/5/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

struct TraceMoeAPI {
    
    //The Delegate allows us to call the main table view and reload it through here rather than reloading it over there
    
    var Delegate: AnimeDelagate?
    
    func API(ImageString: String){
        
        //Paramerters and Headers
        let MyParameters = ["image":"\(ImageString)"]
        let Headers: HTTPHeaders = [.accept("application/json")]
        
        //Actually Making the request
        AF.request("https://trace.moe/api/search", method:.post, parameters: MyParameters, headers: Headers).responseJSON { response in
            print("Working")
            
            if let Data = response.data{
                
                //Creates the JSON Files
                let json = try! JSON(data: Data)
                
                
                
                //Creatinug our variables taht we want to save
                guard let name = json["docs"][0]["title_english"].string else {return}
                guard let episode = json["docs"][0]["episode"].int else {return}
                guard let AnilistId = json["docs"][0]["anilist_id"].int else {return}
                guard let MalID = json["docs"][0]["mal_id"].int else {return}
                
                //The Video Variables
                guard let at = json["docs"][0]["at"].int else {return}
                guard let filename = json["docs"][0]["filename"].string else {return}
                guard let tokenthumb = json["docs"][0]["tokenthumb"].string else {return}
                
                
                //Beggening to save them
                
                let Info = AnimeInfo()
                Info.Name = name
                Info.Episode = episode
                Info.MalID = MalID
                Info.AniListID = AnilistId
                Info.ImageString = ImageString
                Info.VideoURL = "https://media.trace.moe/video/$\(AnilistId)/${encodeURIComponent\(filename)}?t=$\(at)&token=$\(tokenthumb)"
//                print(Info.VideoURL)
                
                Save(Anime: Info)
                
                DispatchQueue.main.async {
                    self.Delegate?.Reload()
                }
                print("Done")
                
                
                
                //https://media.trace.moe/video/${anilist_id}/${encodeURIComponent(filename)}?t=${at}&token=${tokenthumb}`
                
                
                
            }
        }
    }
}


//MARK: - Delagate
//So we can call the Reload function rather than reloading it in there
protocol AnimeDelagate {
    func Reload()
}

