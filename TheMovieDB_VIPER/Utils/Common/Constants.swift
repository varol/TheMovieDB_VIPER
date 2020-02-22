//
//  Constants.swift
//  TheMovieDB_VIPER
//
//  Created by VAROL AKSOY on 20.02.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit
struct Constants {
    
    struct Fonts {
        static let defaultFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let headerFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let dateFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .thin)

    }
    
    struct Sizes {
        static let tableViewCellHeight: CGFloat = 150
        static let collectionViewCellSize: CGFloat = 162.0
    }
    
    struct Colors {
        static let mainTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let descriptionTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        static let headerTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    struct BaseURL {
        static let baseURL: String = "https://api.themoviedb.org/"
        static let nowPlayingURL: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=e7452b02e4e38ec328090154c68c43a7&language=en-US&page=1"
        static let upcomingURL: String = "https://api.themoviedb.org/3/movie/upcoming?api_key=e7452b02e4e38ec328090154c68c43a7&language=en-US&page=1"

    }

}

