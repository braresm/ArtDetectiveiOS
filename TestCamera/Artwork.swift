import Foundation

struct Artwork: Identifiable, Decodable {
    let objectID: Int
    let title: String
    let primaryImageURL: String?
    let artistDisplayName: String?
    
    var id: Int { objectID }
        		
    enum CodingKeys: String, CodingKey {
        case objectID
        case title
        case primaryImageURL = "primaryImageSmall"
        case artistDisplayName
    }
}
