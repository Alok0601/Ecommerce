//
//  SortByModel.swift
//  Ecommerce
//
//  Created by Alok Ranjan on 04/02/24.
//

import Foundation

enum SortBYData: String, CaseIterable {
    case Relevance = "Relevance"
    case NewestFirst = "Newest First"
    case LowToHigh = "Price -- Low to High"
    case HighToLow = "Price -- High to Low"
    case rating = "Rating"
}
