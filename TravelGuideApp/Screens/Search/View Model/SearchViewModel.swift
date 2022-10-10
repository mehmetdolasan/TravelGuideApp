//
//  SearchViewModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation

protocol SearchViewModelViewProtocol: AnyObject {
  
  func didFlightCellItemFetch(_ flights: [FlightsCellViewModel])
  func didHotelCellItemFetch(_ hotels: [HotelsCellViewModel])
  
}

class SearchViewModel {
  
  private let model = SearchModel()
  weak var viewDelegate: SearchViewModelViewProtocol?
  
  init() {
    model.delegate = self
  }
  
  func didViewLoad() {
    model.fetchFlightData()
    model.fecthHotelData()
  }
}

private extension SearchViewModel {
  
  func makeFlightViewBasedModel(_ flights: [Flight]) -> [FlightsCellViewModel] {
    
    var arr: [FlightsCellViewModel] = []
    for element in flights {
      arr.append(FlightsCellViewModel(origin: element.origin, destination: element.destination, price: element.price))
    }
    return arr
  }
  
  func makeHotelViewBasedModel(_ hotels: [Hotel]) -> [HotelsCellViewModel] {
    
    var arr: [HotelsCellViewModel] = []
    for element in hotels {
      arr.append(HotelsCellViewModel(hotelName: element.name?.content, desc: element.city?.content))
    }
    return arr
  }
}

extension SearchViewModel: SearchModelProtocol {
  func didFlightsProccessFinish(_ isSuccess: Bool) {
    if isSuccess {
      let flights = model.flightsEnt
      let cellModels = makeFlightViewBasedModel(flights)
      viewDelegate?.didFlightCellItemFetch(cellModels)
    }
  }
  
  func didHotelsProccessFinish(_ isSuccess: Bool) {
    if isSuccess {
      let hotels = model.hotelsEnt
      let cellModels = makeHotelViewBasedModel(hotels)
      viewDelegate?.didHotelCellItemFetch(cellModels)
    }
  }
}
