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
                            .multilineTextAlignment(.center)
                            .frame(alignment:.center)
                        
                        Text("Episode:\(Anime!.Episode)")
                            .frame(alignment:.center)
                        
                        Imagesub(Screensize: geometry.size, DaImage: convertBase64ToImage(Anime!.ImageString))
                            .frame(alignment:.center)
                        
                        Spacer()
                        Text("Description")
                        Text(Anime!.Description)
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width - 20)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        GenreView(GenreArray: Anime!.genres)

                    }
                }.frame(width: geometry.size.width)
            }.frame(alignment: .center)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(Anime: .constant(AnimeInfo()))
    }
}

extension DetailView{
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
