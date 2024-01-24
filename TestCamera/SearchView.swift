import SwiftUI
import Combine

struct SearchView: View {
@State private var searchTerm: String = ""
@State private var artworks: [Artwork] = []
@State private var isLoading = false
@State private var error: IdentifiableError?
@State private var cancellables = Set<AnyCancellable>()

var artService: ArtServiceProtocol = MetArtService()

var body: some View {
NavigationView {
VStack {
TextField("Search art...", text: $searchTerm, onCommit: search)
.textFieldStyle(RoundedBorderTextFieldStyle())
.padding()

if isLoading {
ProgressView()
} else {
List(artworks) { artwork in
NavigationLink(destination: ArtworkDetailView(artwork: artwork)) {
HStack {
if let urlString = artwork.primaryImageURL, let url = URL(string: urlString) {
AsyncImage(url: url) { image in
image.resizable()
} placeholder: {
Color.gray.opacity(0.1)
}
.frame(width: 70, height: 70)
.cornerRadius(5)
} else {
Color.gray.opacity(0.1)
.frame(width: 70, height: 70)
.cornerRadius(5)
}

VStack(alignment: .leading) {
Text(artwork.title)
.font(.headline)
Text(artwork.artistDisplayName ?? "Unknown Artist")
.font(.subheadline)
.foregroundColor(.secondary)
}
}
}
}
}
}
.navigationBarTitle("Art Search")
.alert(item: $error) { err in
Alert(title: Text("Error"), message: Text(err.message), dismissButton: .default(Text("OK")))
}
}
.navigationViewStyle(StackNavigationViewStyle())
}

func search() {
isLoading = true
artworks.removeAll()

artService.searchArtworkIDs(for: searchTerm)
.flatMap { objectIDs in
Publishers.MergeMany(objectIDs.map { self.artService.fetchArtworkDetails(for: $0) })
.collect()
}
.sink(receiveCompletion: { completion in
isLoading = false
if case .failure(let error) = completion {
self.error = IdentifiableError(message: error.localizedDescription)
}
}, receiveValue: { fetchedArtworks in
self.artworks = fetchedArtworks
})
.store(in: &cancellables)
}
}

// Identifiable error to use with the alert
struct IdentifiableError: Identifiable {
let id = UUID()
let message: String
}

// Preview for SearchView
struct SearchView_Previews: PreviewProvider {
static var previews: some View {
SearchView()
}
}

