//
//  HotelsViewModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation

protocol HotelsViewModelViewProtocol: AnyObject {
  
  func didCellItemFetch(_ hotels:  [HotelsCellViewModel])
  
}

class HotelsViewModel {
  
  private let model = HotelsModel()
  weak var viewDelegate: HotelsViewModelViewProtocol?
  
  init() {
    model.delegate = self
  }
  
  func didViewLoad() {
    model.fetchData()
  }
}

private extension HotelsViewModel {
  
  func makeViewBasedModel(_ hotels: [Hotel]) -> [HotelsCellViewModel] {
    var arr: [HotelsCellViewModel] = []
    for element in hotels {
      arr.append(HotelsCellViewModel(hotelName: element.name?.content, desc: element.city?.content))
    }
    return arr
  }
  
}

extension HotelsViewModel: HotelsModelProtocol {
  func didFetchProcessFinish(_ isSuccess: Bool) {
    if isSuccess {
      let hotels = model.hotelsEnt
      let cellModels = makeViewBasedModel(hotels)
      viewDelegate?.didCellItemFetch(cellModels)
    }
  }
}
