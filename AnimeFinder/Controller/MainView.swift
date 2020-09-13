//
//  MainView.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/4/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    //MARK: - The IB Outlets
    @IBOutlet weak var AnimeNameLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var DescriptionBox: UILabel!
    @IBOutlet weak var EpisodeLabel: UILabel!
    
    
    //MARK: - Variables
    var Anime : AnimeInfo?
    var AniLIst = AniListAPI()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //Testing
        AniLIst.ObtainData(AnimeID: 21857)
        AssingingVariables()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainView {
    func AssingingVariables() {
        if let TheAnime = Anime {
            AnimeNameLabel.text = TheAnime.Name
            EpisodeLabel.text = "Episode: \(TheAnime.Episode)"
            ImageView.image = convertBase64ToImage(TheAnime.ImageString)
        }
    }
    
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
