//
//  ImageCell.swift
//  AnimeFinderUI
//
//  Created by Caleb Wheeler on 9/17/20.
//

import SwiftUI

struct ImageCell: View {
    
    var ScreenSize: CGSize
    var TheImage:UIImage
    
    
    var body: some View {
        
        var Newimage = UItoImage(with: TheImage)
        
        Image("\(Newimage)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: ScreenSize.width - 14, height: 140)
            .clipped()
        
    }
}

struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ImageCell(ScreenSize: geometry.size, TheImage: UIImage(imageLiteralResourceName: "Cringe"))
        }
    }
}

extension ImageCell {
    
    func UItoImage(with PogImage: UIImage) -> Image {
        let NewImage = Image(uiImage: PogImage)
        return NewImage
    }
}
