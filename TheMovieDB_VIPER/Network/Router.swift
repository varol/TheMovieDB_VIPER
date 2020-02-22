//
//  Router.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 21.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation
import Alamofire
enum Router: URLRequestConvertible {
    
    case nowPlaying
    case upcoming
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying:
            return .get
        case .upcoming:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .nowPlaying:
            return nil
        case .upcoming:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .nowPlaying:
            let url = URL(string: Constants.BaseURL.nowPlayingURL)!
            return url
        case .upcoming:
            let url = URL(string: Constants.BaseURL.upcomingURL)!
            return url
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}

