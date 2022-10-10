// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hotels = try? newJSONDecoder().decode(Hotels.self, from: jsonData)

import Foundation

// MARK: - Hotels
struct Hotels: Decodable {
    let from, to, total: Int?
    let auditData: AuditData?
    let hotels: [Hotel]?
}

// MARK: - AuditData
struct AuditData: Decodable{
    let processTime, timestamp, requestHost, serverID: String?
    let environment, release, auditDataInternal: String?
}

// MARK: - Hotel
struct Hotel: Decodable {
    let code: Int?
    let name, hotelDescription: City?
    let countryCode: String?
    let address: Address?
    let city: City?
    let images: [Image]?
}

// MARK: - Address
struct Address: Decodable {
    let content, street, number: String?
}

// MARK: - City
struct City: Decodable {
    let content: String?
}



// MARK: - Image
struct Image: Decodable {
    let imageTypeCode: String?
    let path: String?
    let order, visualOrder: Int?
    let roomCode: String?
    let roomType: String?
    let characteristicCode: String?
}







