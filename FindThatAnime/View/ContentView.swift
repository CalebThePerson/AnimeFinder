//
//  ContentView.swift
//  AnimeFinderUI
//
//  Created by Caleb Wheeler on 9/17/20.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedObject var API = TraceMoeAPI()
    @State private var Anime: Results<AnimeInfo> = realm.objects(AnimeInfo.self)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                //                VStack(alignment:.center, spacing: 0){
                ScrollView(.vertical) {
                    ForEach(Anime, id: \.Name){ anime in
                        ImageCell(ScreenSize: geometry.size, TheImage: convertBase64ToImage(anime.ImageString))
                    }
                    //                    .frame(height: geometry.size.height)
                }
                .lineSpacing(0)
                
                FloatingMenu(TraceAPI: API)
                    .offset(x:150, y:-10)
            }
        }
        .edgesIgnoringSafeArea(.all)
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
        return decodedimage!
    }
    
}
//MARK: - Useless section poggers

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
