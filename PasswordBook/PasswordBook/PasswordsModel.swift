import Foundation


// PasswordModel отвечает за декодирование данных загруженных из ответа от Network API. Загруженные данные парсятся, и декодируются в модель структуры Password

// Структура Password является моделью в которую будут декодированы наши данные.
struct Password: Decodable {
  var id: Int
  var position_order: Int
  var dep: String
  var fullname: String
  var login: String
  var mail: String
  var ip: String
  var mailrupass: String
  var netpass: String
  var docpass: String
}

class PasswordsModel {
    
    weak var delegate: Downloadable?
    let networkModel = Network()
  // Метод downloadPasswords выполняет следующие действия:
    func downloadPasswords(parameters: [String: Any], url: String) {
        print("Запускаем скачивание контактов")
//        print(parameters)
       // создает запрос URLSession,
        let request = networkModel.request(parameters: parameters, url: url)
        // а затем передает этот запрос в метод response из объекта Network API.
        networkModel.response(request: request) { (data) in
          // Наконец, ответ парсится и декодируется в модель Password
            let model = try! JSONDecoder().decode([Password]?.self, from: data) as [Password]?
//          print("Отпарсенная модель: \(model ?? [])")
          // Затем используется делегирование протокола для вызова метода didReceiveData() из протокола Downloadable. В итоге, эти данные будут доступны, и готовый обрабатываться для всех вьюконтроллеров которые реализуют протокол Downloadable
            self.delegate?.didReceiveData(data: model! as [Password])
        }
    }
}
