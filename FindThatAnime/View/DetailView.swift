//
//  DetailView.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 9/26/20.
//

import SwiftUI


struct DetailView: View {
    @Binding var Anime: AnimeInfo?
    
    var body: some View {
        if Anime?.Name != nil {
            GeometryReader { geometry in
                ScrollView(.vertical){
                    VStack{
                        Spacer()
                        Text(Anime!.Name)
                            .frame(alignment:.center)
                        Text("Episode:\(Anime!.Episode)")
                            .frame(alignment:.center)
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(Anime: .constant(AnimeInfo()))
    }
}
