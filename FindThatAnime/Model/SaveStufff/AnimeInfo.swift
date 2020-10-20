//
//  AnimeInfo.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/5/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import Foundation
import RealmSwift


class AnimeInfo: Object, Identifiable {
    //The variables we are saving to the realm file
    @objc dynamic var Name: String = ""
    @objc dynamic var ImageString: String = ""
    @objc dynamic var Episode: Int = 0
    @objc dynamic var AniListID: Int = 0
    @objc dynamic var MalID: Int = 0
    @objc dynamic var VideoURL: String = ""
    @objc dynamic var Description: String = ""
    @objc dynamic var Populatiry: String = ""
    @objc dynamic var SiteURL: String = ""
    var genres = List<Genres>()
    
}
