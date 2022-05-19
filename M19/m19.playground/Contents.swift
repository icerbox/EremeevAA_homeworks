import UIKit

let json = """
{

"name": "John Davis",
"country": "Peru",
"use": "to buy a new collection of clothes to stock her shop before the holidays.",
"loan_amount": 150

}
"""

struct Loan: Codable {
    let name: String
    let country: String
    let use: String
    let amount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case use
        case amount = "loan_amount"
    }
}

var loan: Loan? = nil

let decoder = JSONDecoder()


if let jsonData: Data = json.data(using: .utf8) {
    do {
        loan = try decoder.decode(Loan.self, from: jsonData)
        print(loan!)
    } catch {
        print(error)
    }
}

let encoder = JSONEncoder()

let loanData: Data? = try? encoder.encode(loan!)
