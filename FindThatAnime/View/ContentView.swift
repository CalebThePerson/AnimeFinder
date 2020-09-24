//
//  ContentView.swift
//  AnimeFinderUI
//
//  Created by Caleb Wheeler on 9/17/20.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var Anime: Results<AnimeInfo> = try! Realm(configuration: Realm.Configuration(schemaVersion: 1)).objects(AnimeInfo.self)
    
    var body: some View {
        VStack {
            ForEach(Anime, id: \.Name) { anime in
                GeometryReader { geometry in
                    ImageCell(ScreenSize: geometry.size, TheImage: convertBase64ToImage(anime.ImageString))
                }
            }
            FloatingMenu()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        print("Worked")
        return decodedimage!
    }
    
}

class BindableResults<AnimeInfo>: ObservableObject where AnimeInfo: RealmSwift.RealmCollectionValue {

    var results: Results<AnimeInfo>
    private var token: NotificationToken!

    init(results: Results<AnimeInfo>) {
        self.results = results
        lateInit()
    }

    func lateInit() {
        token = results.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

    deinit {
        token.invalidate()
    }
}
