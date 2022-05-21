//
//  Model.swift
//  MVPpattern
//
//  Created by Михаил on 09.05.2022.
//

import UIKit

//struct Comment: Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

struct MovieStats: Codable {
    let searchType: SearchTypeEnum
    let expression: String
    let results: [Results]
    let errorMessage: String
}

struct Results: Codable {
    let id: String
    let resultType: SearchTypeEnum
    let image: String
    let title, resultDescription: String
    
    enum CodingKeys: String, CodingKey {

           case id, resultType, image, title

           case resultDescription = "description"

       }
}

enum SearchTypeEnum: String, Codable {
    case title = "Title"
}
