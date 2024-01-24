import Foundation
import Combine

// Protocol for the art service
protocol ArtServiceProtocol {
    func searchArtworkIDs(for query: String) -> AnyPublisher<[Int], Error>
    func fetchArtworkDetails(for objectID: Int) -> AnyPublisher<Artwork, Error>
}

// Real art service for the Metropolitan Museum of Art API
class MetArtService: ArtServiceProtocol {
    private let session = URLSession.shared
    private let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"

    func searchArtworkIDs(for query: String) -> AnyPublisher<[Int], Error> {
        let searchURL = URL(string: "\(baseURL)/search?hasImages=true&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        return session.dataTaskPublisher(for: searchURL)
            .map(\.data)
            .decode(type: ArtAPIResponse.self, decoder: JSONDecoder())
            .map(\.objectIDs)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchArtworkDetails(for objectID: Int) -> AnyPublisher<Artwork, Error> {
        let detailsURL = URL(string: "\(baseURL)/objects/\(objectID)")!
        return session.dataTaskPublisher(for: detailsURL)
            .map(\.data)
            .decode(type: Artwork.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// Models to match the API's JSON response
struct ArtAPIResponse: Decodable {
    let total: Int
    let objectIDs: [Int]
}
