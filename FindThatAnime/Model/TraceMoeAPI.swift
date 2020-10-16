import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class TraceMoeAPI: ObservableObject {
    
    var AniListapi = AniListAPI()
    @Published var CirclePresenting:Bool = false
    @Published var Percetage:Int = 0
    
    @Published var DataIsSaved:Bool = false
    
    func API(ImageString: String){
        CirclePresenting=true
        Percetage = 7
        //Paramerters and Headers
        let MyParameters = ["image":"\(ImageString)"]
        let Headers: HTTPHeaders = [.accept("application/json")]
        
        //Actually Making the request
        AF.request("https://trace.moe/api/search", method:.post, parameters: MyParameters, headers: Headers).responseJSON { [self] response in
            Percetage = 14
            print("Working")
            
            if let Data = response.data{
                print("come on")
                //Creates the JSON Files
                let json = try! JSON(data: Data)
                
                print("Almost there")
                Percetage = 21
                
                //Creatinug our variables taht we want to save
                guard let name = json["docs"][0]["title_english"].string else {return}
                guard let episode = json["docs"][0]["episode"].int else {return}
                Percetage = 28
                guard let AnilistId = json["docs"][0]["anilist_id"].int else {return}
                guard let MalID = json["docs"][0]["mal_id"].int else {return}
                Percetage = 35
                
                //The Video Variables
                guard let at = json["docs"][0]["at"].int else {return}
                guard let filename = json["docs"][0]["filename"].string else {return}
                guard let tokenthumb = json["docs"][0]["tokenthumb"].string else {return}
                
                Percetage = 42
                
                self.AniListapi.ObtainData(AnimeID: AnilistId) { (NewData) in
                    //                    print(NewData)
                    let TheStuff = self.Disection(TheData: NewData)
                    let Info = AnimeInfo()
                    Percetage = 49
                    Info.Name = name
                    Percetage = 56
                    Info.Episode = episode
                    Percetage = 63
                    Info.MalID = MalID
                    Percetage = 70
                    Info.AniListID = AnilistId
                    Percetage = 77
                    Info.ImageString = ImageString
                    Percetage = 84
                    Info.VideoURL = "https://media.trace.moe/video/$\(AnilistId)/${encodeURIComponent\(filename)}?t=$\(at)&token=$\(tokenthumb)"
                    Percetage = 91
                    
                    Info.Description = TheStuff["Description"] as! String
                    //                    Info.Populatiry = TheStuff["Popularity"] as! String
                    
                    
                    Save(Anime: Info)
                    Percetage = 100
                    print("Done")
                    self.DataIsSaved = true
                    self.CirclePresenting = false
                }
                //
                //                guard let NewData = self.AnieListApi.ObtainData(AnimeID: AnilistId) else {return}
                //                print("Didnt fail")
                //                let TheStuff = self.Disection(TheData: NewData)
                
                //Beggening to save them
                
                
                
                //                print(Info.VideoURL)
                
                
                
                
                
                
                //https://media.trace.moe/video/${anilist_id}/${encodeURIComponent(filename)}?t=${at}&token=${tokenthumb}`
                
                
                
            }
        }
        
    }
}
extension TraceMoeAPI {
    
    func Disection(TheData: QueryQuery.Data) -> [(String):(Any)] {
        
        var Poggers = [(String):(Any)]()
        
        var Description = (TheData.media?.description)! as String
        let removale = ["<br> <br>", "<br>", "<b/>", "<br><br>","</b>"]
        
        
        for word in removale{
            Description = Description.replacingOccurrences(of: word, with: "")
        }
        print(Description)
        
        let StartDate = TheData.media?.startDate
        let Populatiry = TheData.media?.popularity
        
        var Genres = List<String>()
        
        for genre in TheData.media?.genres as [String] {
            Genres.append(genre)
        }
        
        let SiteUrl = TheData.media?.siteUrl
        
        Poggers["Description"] = Description
        Poggers["Popularity"] = Populatiry
        Poggers["GenreArray"] = Genres
        Poggers["SiteURL"] = SiteUrl
        
        return Poggers
        
    }
}
