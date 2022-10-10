//
//  FlightsViewModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation

protocol FlightsViewModelViewProtocol: AnyObject{
  
  func didCellItemFetch(_ flights: [FlightsCellViewModel])
  
}

class FlightsViewModel {
  
  weak var viewDelegate: FlightsViewModelViewProtocol?
  private let model = FlightsModel()
  
  init() {
    model.delegate = self
  }
  
  func didViewLoad() {
    model.fetchData()
  }
  
}

private extension FlightsViewModel {
  
  func makeViewBasedModel(_ flights : [Flight]) -> [FlightsCellViewModel] {
    var arr: [FlightsCellViewModel] = []
    for element in flights {
      arr.append(FlightsCellViewModel(origin: element.origin, destination: element.destination, price: element.price))
    }
    return arr
  }
  
}

extension FlightsViewModel: FlightsModelProtocol {
  func didProcessFinish(_ isSuccess: Bool) {
    if isSuccess {
      let flights = model.flightsEnt
      let cellModels = makeViewBasedModel(flights)
      viewDelegate?.didCellItemFetch(cellModels)
    }
  }
}
