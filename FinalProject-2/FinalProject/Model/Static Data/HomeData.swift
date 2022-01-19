//
//  Static Data.swift
//  FinalProject
//
//

import Foundation
import UIKit



struct HomeData {
    var category: String
    var subCategory: String
    var image: UIImage    
}

class HomeDB {
    
    static let dataForClothes = [
        HomeData(category: "Clothes", subCategory: "Shoes", image: UIImage(named: "shoes")!),
        HomeData(category: "Clothes", subCategory: "Bags", image: UIImage(named: "bag")!),
        HomeData(category: "Clothes", subCategory: "Shirts & Pants", image: UIImage(named: "shirts")!)
    ]
    
    static let dataForBooks = [
        HomeData(category: "Books", subCategory: "Kids & Education", image: UIImage(named: "kids")!),
        HomeData(category: "Books", subCategory: "Fiction", image: UIImage(named: "fiction")!),
        HomeData(category: "Books", subCategory: "Science", image: UIImage(named: "science")!)
    ]
    
    static let dataForGames = [
        HomeData(category: "Games", subCategory: "Kids & Toys", image: UIImage(named: "kids-games")!),
        HomeData(category: "Games", subCategory: "Adults & Video Games", image: UIImage(named: "adults")!),
        HomeData(category: "Games", subCategory: "Board & Cards games", image: UIImage(named: "board")!),
    ]
    
}
