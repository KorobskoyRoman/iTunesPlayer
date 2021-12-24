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
                case getTracks(searchText: String)
            }
        }
        struct Response {
            enum ResponseType {
                case presentTracks(searchResponse: TrackModel?)
                case presentFooterView
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayTracks(searchViewModel: SearchViewModel)
                case displayFooterView
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
