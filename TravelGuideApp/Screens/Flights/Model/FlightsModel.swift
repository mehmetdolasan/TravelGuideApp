//
//  FlightsModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation
import Alamofire


protocol FlightsModelProtocol: AnyObject{
  func didProcessFinish(_ isSuccess: Bool)
}

class FlightsModel {
  
  weak var delegate: FlightsModelProtocol?
  
  var flightsEnt: [Flight] = []
  
  //API Request
  let baseUrl: String = "https://api.travelpayouts.com"
  let contentURI: String = "/aviasales/v3/prices_for_dates?"
  let token: String = "322964b39cd9f6126986fa1c5f276337"
  
  func fetchData() {
    let url = baseUrl + contentURI
    
    AF.request(url +
               "origin=&destination=IST&departure_at=2022-12&return_at=2023-01&unique=false&sorting=price&direct=false&currency=usd&limit=30&page=1&one_way=true&token=" + token)
      .responseDecodable(of: Flights.self) { (response) in
        
        switch response.result {
          
        case .success(let result):
          print(result)
          if let resultFlight = result.data {
            for item in resultFlight {
              self.flightsEnt.append(item)
            }
            self.delegate?.didProcessFinish(true)
          }
          
        case .failure(let error):
          print(error)
          
        }
        
      }
  }
}
