//
//  AlamofireModel.swift
//  M19Homework
//
//  Created by Андрей Антонен on 17.03.2022.
//

import Foundation


struct Item : Codable {
    let birth : Int?
    let occupation : String?
    let name : String?
    let lastname : String?
    let country : String?
    
    enum CodingKeys: String, CodingKey {
        case birth = "birth"
        case occupation = "occupation"
        case name = "name"
        case lastname = "lastname"
        case country = "country"
    }
    
    init(birth: Int, occupation: String, name: String, lastname: String, country: String) {
        self.birth = birth
        self.occupation = occupation
        self.name = name
        self.lastname = lastname
        self.country = country
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        birth = try values.decodeIfPresent(Int.self, forKey: .birth)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        country = try values.decodeIfPresent(String.self, forKey: .country)
    }
}
