//
//  SearchInteractor.swift
//  iTunesPlayer
//
//  Created by Roman Korobskoy on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var networkManager = NetworkManager()
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        switch request {
        case .getTracks(let searchText):
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentFooterView)
            networkManager.fetchTracks(searchText: searchText) { [weak self] searchResponse in
                self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(searchResponse: searchResponse))
            }
        }
    }
    
}
