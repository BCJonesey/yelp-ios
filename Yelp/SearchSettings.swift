//
//  SearchSettings.swift
//  Yelp
//
//  Created by Ben Jones on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SearchSettings: NSObject,NSCopying {

    static let categoryOptions : [String:String] = ["thai":"Thai", "latin":"Latin American"]
    static let distanceOptions : [String:String] = ["1600":"1 Mile", "8000":"5 Miles", "16000":"10 Miles", "40000":"25 Miles"]
    static let searchModeOptionNames : [String] = ["Best Matched", "Distance", "Highest Rated"]
    var searchTerm : String
    var categories : [String]
    var deal : Bool
    var sortMode : YelpSortMode = YelpSortMode.highestRated
    var distance : String
    
    

    func executeSearch(completion: @escaping ([Business]?, Error?) -> Void) {
        Business.searchWithTerm(term: searchTerm, sort: sortMode, categories: categories, deals: deal, completion: completion)
    }
    
    init(searchTerm: String = "", categories: [String] = [], deal: Bool = false, distance: String = "1600") {
        self.searchTerm = searchTerm
        self.categories = categories
        self.deal = deal
        self.distance = distance
    }
    
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = SearchSettings(searchTerm: searchTerm, categories: categories, deal: deal, distance: distance)
        return copy
    }
    
}
