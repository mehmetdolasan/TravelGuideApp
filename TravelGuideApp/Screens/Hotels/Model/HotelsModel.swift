//
//  HotelsModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation
import Alamofire
import CryptoKit

protocol HotelsModelProtocol: AnyObject {
  func didFetchProcessFinish(_ isSuccess:Bool)
}


class HotelsModel {
  
  weak var delegate: HotelsModelProtocol?
  
  var hotelsEnt: [Hotel] = []
  
  //API Request
  let baseUrl: String = "https://api.test.hotelbeds.com"
  let contentURI: String = "/hotel-content-api/1.0"
  let apiKey: String = "516e5237fbad5090ecb29c11f23146f1"
  let secret: String = "883dec855e"
  
  
  let baseHeaders: [String:String] = [:]
  
  
  func hashSignature() -> String {
    let timestamp = Int(NSDate().timeIntervalSince1970)
    let inputString = apiKey + secret + String(timestamp)
    let inputData = Data(inputString.utf8)
    let hashed = SHA256.hash(data: inputData)
    
    
    return hashed.description.components(separatedBy: ":")[1]
    
  }
  
  
  func fetchData() {
    
    let parameters: [String : Any] = [:]
    let url = baseUrl + contentURI
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
            self.delegate?.didFetchProcessFinish(true)
          }
        case .failure(let error):
          print(error)
        }
      }
  }
  
  func getHeaders() -> HTTPHeaders {
    return ["Accept":"application/json", "Api-key": apiKey, "Accept-Encoding":"gzip", "X-Signature": hashSignature()]
  }
  
}
