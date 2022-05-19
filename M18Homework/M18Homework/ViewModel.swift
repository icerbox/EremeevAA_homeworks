import UIKit

// Объявляем структуру которая будет использоваться в качестве вьюмодели данных

struct APIResponse: Codable {
    var results: [APIResponseResults]
    var expression: String
    var searchType: SearchTypeEnum
    var errorMessage: String
}

struct APIResponseResults: Codable {
    let description: String
    let id: String
    let image: String
    let resultType: SearchTypeEnum
    let title: String
    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case description
    }
}

// Объявляем структуру которая будет использоваться в качестве вьюмодели для изображений
struct Images {
    let imageCell: UIImage
}

// Объявляем массив в который будем добавлять загруженные изображения

var imagesArray: [Images] = []


// Объявляем метод для загрузки изображений
func loadImage(urlString: String) {
    guard
        let url = URL(string: urlString),
        let data = try? Data(contentsOf: url)
    else {
        print("Ошибка, не удалось загрузить изображения")
        return
    }
    let image = UIImage(data: data) ?? UIImage()
    imagesArray.append(Images(imageCell: image))
}

enum SearchTypeEnum: String, Codable {
    case title = "Title"
}

// Объявляем массив данных с типом ViewModel

var moviesArray: [APIResponseResults] = [
]
