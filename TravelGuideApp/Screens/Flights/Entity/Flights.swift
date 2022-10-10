import Foundation

// MARK: - Flights
struct Flights: Decodable {
    let success: Bool?
    let data: [Flight]?
    let currency: String?
}

// MARK: - Datum
struct Flight: Decodable {
    let origin: String?
    let destination: String?
    let originAirport: String?
    let destinationAirport: String?
    let price: Int?
    let airline: String?
    let flightNumber: String?
    let departureAt, returnAt: Date?
    let transfers, returnTransfers, duration: Int?
    let link: String?
}




