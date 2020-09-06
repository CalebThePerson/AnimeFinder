//
//  AnimeInfo.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/5/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import Foundation
import RealmSwift

class AnimeInfo: Object {
    @objc dynamic var Name: String = ""
    @objc dynamic var ImageString: String = ""
    @objc dynamic var Episode: Int = 0
    @objc dynamic var AniListID: Int = 0
    @objc dynamic var MalID: Int = 0
    @objc dynamic var VideoURL: String = ""
}
