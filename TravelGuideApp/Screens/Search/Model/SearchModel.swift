//
//  SearchModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation
import Alamofire
import CryptoKit

protocol SearchModelProtocol: AnyObject {
  func didFlightsProccessFinish(_ isSuccess: Bool)
  func didHotelsProccessFinish(_ isSuccess: Bool)
}

class SearchModel {
  
  weak var delegate: SearchModelProtocol?
  
  var flightsEnt: [Flight] = []
  var hotelsEnt: [Hotel] = []
  
  //Flight API Request
  let baseUrlFlight: String = "https://api.travelpayouts.com"
  let contentURIFlight: String = "/aviasales/v3/prices_for_dates?"
  let tokenFlight: String = "322964b39cd9f6126986fa1c5f276337"
  
  //Fetch for Flight
  func fetchFlightData() {
    
    let url = baseUrlFlight + contentURIFlight
    
    AF.request(url +
               "origin=&destination=IST&departure_at=2022-12&return_at=2023-01&unique=false&sorting=price&direct=false&currency=usd&limit=30&page=1&one_way=true&token=" + tokenFlight)
      .responseDecodable(of: Flights.self) { (response) in
        
        switch response.result {
          
        case .success(let result):
          print(result)
          if let resultFlight = result.data {
            for item in resultFlight {
              self.flightsEnt.append(item)
            }
            self.delegate?.didFlightsProccessFinish(true)
          }
          
        case .failure(let error):
          print(error)
          
        }
        
      }
    
  }
  
  
  //Hotel API Request
  let baseUrlHotel: String = "https://api.test.hotelbeds.com"
  let contentURIHotel: String = "/hotel-content-api/1.0"
  let apiKeyHotel: String = "516e5237fbad5090ecb29c11f23146f1"
  let secretHotel: String = "883dec855e"
  let baseHeaders: [String:String] = [:]
  
  func hashSignature() -> String {
    let timestamp = Int(NSDate().timeIntervalSince1970)
    let inputString = apiKeyHotel + secretHotel + String(timestamp)
    let inputData = Data(inputString.utf8)
    let hashed = SHA256.hash(data: inputData)
    
    
    return hashed.description.components(separatedBy: ":")[1]
    
  }
  
  //fetch for Hotel
  func fecthHotelData() {
    
    let parameters: [String : Any] = [:]
    let url = baseUrlHotel + contentURIHotel
    let headers: HTTPHeaders = getHeaders()
    
    AF.request(url + "/hotels?destinationCode=&from=1&to=20&useSecondaryLanguage=false&fields=name,code,description,countryCode,address,city,images",
               method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
      .validate(statusCode: 200..<600)
      .responseDecodable(of: Hotels.self ) { (response) in
        
        switch response.result {
          
        case .success(let result):
          print(result)
          if let resultHotel = result.hotels {
            for item in resultHotel {
              self.hotelsEnt.append(item)
            }
            self.delegate?.didHotelsProccessFinish(true)
          }
        case .failure(let error):
          print(error)
        }
      }
  }
  
  func getHeaders() -> HTTPHeaders {
    return ["Accept":"application/json", "Api-key": apiKeyHotel, "Accept-Encoding":"gzip", "X-Signature": hashSignature()]
  }
  
}
