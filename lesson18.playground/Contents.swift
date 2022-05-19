import UIKit

let url = URL(string: "https://petstore.swagger.io/v2/pet/findByStatus?status=sold")!

var request = URLRequest(url: url)
request.httpMethod = "GET"
request.allHTTPHeaderFields = ["accept": "application/json"]
request.httpBody = nil


let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
    if let error = error {
        print(error)
    } else {
        print(response)
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print(json)
        }
    }
})

task.resume()
