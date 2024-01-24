import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let urlString = artwork.primaryImageURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(8)
                }

                Text(artwork.title)
                    .font(.title)
                    .fontWeight(.bold)

                if let artist = artwork.artistDisplayName {
                    Text("Artist: \(artist)")
                        .font(.title3)
                }

                // Add more details as needed here
            }
            .padding()
        }
        .navigationTitle(artwork.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ArtworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkDetailView(artwork: Artwork(objectID: 1, title: "Sample Art", primaryImageURL: nil, artistDisplayName: "Sample Artist"))
    }
}
