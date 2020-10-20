//
//  GenreView.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 10/15/20.
//

import SwiftUI
import RealmSwift

struct GenreView: View {
    var GenreArray: RealmSwift.List<Genres>
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal){
                HStack {
                    ForEach(0..<GenreArray.count) { genre in
                        Spacer()
                        Text(GenreArray[genre].genre)
                        Spacer()
                    }
                }
            }
            .frame(alignment: .center)
        }
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(GenreArray: AnimeInfo().genres)
    }
}
