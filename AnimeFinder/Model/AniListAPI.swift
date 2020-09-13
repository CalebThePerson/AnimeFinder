//
//  AniListAPI.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/12/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import Foundation
import Apollo

struct AniListAPI {
    let AniListUrl = "https://graphql.anilist.co"
    
    func ObtainData(AnimeID: Int){
        
        let TheInfo = QueryQuery(id: AnimeID)
        GraphClient.fetch(query: TheInfo) { result in
            switch result {
            case .failure(let error):
                print("A big No no happened \(error)")
            case .success(let GraphQLResult):
                guard let Info = GraphQLResult.data else {return}
                print(Info)

            }
            
        }
    }

    
}
