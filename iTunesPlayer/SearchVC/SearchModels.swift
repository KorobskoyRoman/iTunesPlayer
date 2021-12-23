//
//  SearchModels.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
   
  enum Model {
    struct Request {
      enum RequestType {
        case some
          case getTracks(searchText: String)
      }
    }
    struct Response {
      enum ResponseType {
        case some
          case presentTracks(searchResponse: TrackModel?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case some
          case displayTracks(searchViewModel: SearchViewModel)
      }
    }
  }
  
}

struct SearchViewModel {
    struct Cell: TrackCellViewModel {
        var iconUrlString: String?
        var trackName: String?
        var collectionName: String?
        var artistName: String
        var previewUrl: String?
    }
    
    let cells: [Cell]
}
