//
//  ScannedArtView.swift
//  TestCamera
//
//  Created by Balutoiu Rares on 08/11/2023.
//

import SwiftUI

struct ScannedArtView: View {
    var image: UIImage
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(uiImage: image) // Load your finished image
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Mona Lisa")
                .font(.title)
                .fontWeight(.bold)
            Text("Artist: Leonardo da Vinci")
                .font(.title3)
            Text("Style: Renaissance")
                .font(.title3)
            Text("Brush: sfumato")
                .font(.title3)
            Text("Material: oil on a poplar wood")
                .font(.title3)
            // Add more details as needed here
        }
        .padding()
    }
    /*.navigationTitle(artwork.title)
    .navigationBarTitleDisplayMode(.inline)
    }*/
}
