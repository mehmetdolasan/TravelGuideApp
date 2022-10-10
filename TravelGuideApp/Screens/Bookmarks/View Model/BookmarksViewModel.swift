//
//  BookmarksViewModel.swift
//  TravelGuideApp
//
//  Created by Mehmet Dolasan on 27.09.2022.
//

import Foundation

protocol BookmarksViewModelViewProtocol: AnyObject {
  
  func didCellItemFetch(_ items: [BookmarksCellViewModel])
  
}


class BookmarksViewModel {
  
  private let model = BookmarksModel()
  weak var viewDelegate: BookmarksViewModelViewProtocol?
  
  init() {
    model.delegate = self
  }
  
  func didViewLoad() {
    model.fetchData()
  }
  
}

private extension BookmarksViewModel {
  
  func makeViewBasedModel(_ bookmarks : [Bookmarks]) -> [BookmarksCellViewModel] {
    return bookmarks.map { .init(name: $0.name, desc: $0.desc) }
  }
  
}

extension BookmarksViewModel: BookmarksModelProtocol {
  func didFetchProcessFinish(_ isSuccess: Bool) {
    if isSuccess {
      let bookmarks = model.bookmarks
      let cellModels = makeViewBasedModel(bookmarks)
      viewDelegate?.didCellItemFetch(cellModels)
    }
  }
}
