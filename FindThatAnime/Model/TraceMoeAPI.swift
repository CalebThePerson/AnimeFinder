//
//  TraceMoeAPI.swift
//  
//
//  Created by Caleb Wheeler on 9/19/20.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class TraceMoeAPI: ObservableObject {
    
    @Published var CirclePresenting:Bool = false
    
    @Published var DataIsSaved:Bool = false
    
    func API(ImageString: String){
        
        //Paramerters and Headers
        let MyParameters = ["image":"\(ImageString)"]
        let Headers: HTTPHeaders = [.accept("application/json")]
        
        //Actually Making the request
        AF.request("https://trace.moe/api/search", method:.post, parameters: MyParameters, headers: Headers).responseJSON { [self] response in
            print("Working")
            
            if let Data = response.data{
                print("come on")
                //Creates the JSON Files
                let json = try! JSON(data: Data)
                
                print("Almost there")
                
                //Creatinug our variables taht we want to save
                guard let name = json["docs"][0]["title_english"].string else {return}
                guard let episode = json["docs"][0]["episode"].int else {return}
                guard let AnilistId = json["docs"][0]["anilist_id"].int else {return}
                guard let MalID = json["docs"][0]["mal_id"].int else {return}
                
                //The Video Variables
                guard let at = json["docs"][0]["at"].int else {return}
                guard let filename = json["docs"][0]["filename"].string else {return}
                guard let tokenthumb = json["docs"][0]["tokenthumb"].string else {return}
                
//
//                guard let NewData = self.AnieListApi.ObtainData(AnimeID: AnilistId) else {return}
//                print("Didnt fail")
//                let TheStuff = self.Disection(TheData: NewData)
                
                //Beggening to save them
                
                let Info = AnimeInfo()
                Info.Name = name
                Info.Episode = episode
                Info.MalID = MalID
                Info.AniListID = AnilistId
                Info.ImageString = ImageString
                Info.VideoURL = "https://media.trace.moe/video/$\(AnilistId)/${encodeURIComponent\(filename)}?t=$\(at)&token=$\(tokenthumb)"
//                Info.Description = TheStuff["Description"] as! String
//                Info.Populatiry = TheStuff["Popularity"] as! String
                //                print(Info.VideoURL)
                
                Save(Anime: Info)
                
                //                DispatchQueue.main.async {
                //                    self.Delegate?.Reload()
                //                }
                
                print("Done")
                self.DataIsSaved = true
                self.CirclePresenting = false
                
                
                
                //https://media.trace.moe/video/${anilist_id}/${encodeURIComponent(filename)}?t=${at}&token=${tokenthumb}`
                
                
                
            }
        }
        
    }
}
extension TraceMoeAPI {
    
//    func Disection(TheData: QueryQuery.Data) -> [(String):(Any)] {
//
//        var Poggers = [(String):(Any)]()
//
//
//
//        let Description = TheData.media?.description
//        let StartDate = TheData.media?.startDate
//        let Populatiry = TheData.media?.popularity
//
//        var Genres = List<String>()
//        for num in 0...(TheData.media?.genres!.count)! {
//            Genres.append((TheData.media?.genres![num])!)
//        }
//
//        let SiteUrl = TheData.media?.siteUrl
//
//        Poggers["Description"] = Description
//        Poggers["Popularity"] = Populatiry
//        Poggers["GenreArray"] = Genres
//        Poggers["SiteURL"] = SiteUrl
//
//        return Poggers
//
//    }
}

