import UIKit
import Foundation

//Дополнительные задания:
//1. Посмотреть видео про методы композиции и агрегации по ссылке https://www.youtube.com/watch?v=N7DzmfLBolM
//Ответ: Просмотрено

//2. Привести по два примера с использованием композиции и агрегации. Объяснить, почему в каждом примере использована композиция/агрегация.

// 2.1. Пример композиции

// В данном примере используется метод композиции, т.е. внутри класса human включен класс brain, т.к. он неразрывно связан с вышестоящим классом и отдельно использован быть не может.

class human {
    class brain {
        func think(thought: String) -> String {
            return "Мозг человека в данное время думает о \(thought)"
        }
     }
}

var randomThought = human.brain()
randomThought.think(thought: "еде")

// 2.2. Пример агрегации

// В данном примере используется метод агрегации, т.е. класс Weapon позаимствовал свойства у класса Size. Класс Size может существовать без наличия класса Weapon и может быть использован другими вновь создаваемыми классами.

class Size {
    var length = 0
    var barrelLength = 0
    var weight = 0
}

class Weapon {
    var name: String = ""
    var size = Size()
}

let dragunovRifle = Weapon()
dragunovRifle.size.length = 1220
dragunovRifle.name = "cнайперская винтовка Драгунова"

print("Оружие \(dragunovRifle.name) имеет длину \(dragunovRifle.size.length) см.")


//3. Создается приложение интернет-магазин для продажи книг.
//Реализуйте модели данных (используя классы, структуры, перечисления на ваш выбор):
//- заказ
//- платеж
//- чек
//- книга
//- пользователь
//Добавьте любые свойства на ваше усмотрение, которые необходимы для работоспособности интернет-магазина.

// Создаем основную структуру на основе которой будем создавать товары интернет-магазина
struct Main {
    var nameOfProduct: String  // Наименование товара
    var quantity: Int   // Количество товара
    var price: Int  // Цена
    var date: Date  // Дата
    var userLogin: String   // Имя пользователя
}
// Объявляем класс Order в котором будут храниться переменные и методы для оформления заказов интернет-магазина
class Order {
    // Объявляем пустой массив ordersArray в которой будут храниться активные заказы
    static var ordersArray: [Main] = []
    // Объявляем функцию addOrder при помощи которой заказы добавляются в массив ordersArray
    static func addOrder(_ array: [Main]) -> [Main] {
        for order in array {
            ordersArray.append(order)
            // После оформления, в массив paymentArray сразу добавляется каждый заказ
            Payment.paymentArray.append(order)
        }
        return ordersArray
    }
    static func findUserOrders(_ login: String) -> [Main] {
        let result = ordersArray.filter { $0.userLogin.starts(with: login) }
    return result
    }
}
// Объявляем класс Payment в котором будем хранить переменные и методы для подсчета платежей сформированных при помощи класса Order
class Payment {
    // Объявляем пустой массив paymentArray в котором будут храниться платежи по заказам, для последующей оплаты
    static var paymentArray: [Main] = []
    // Метод invoiceForPayment выставляет счет по имени пользователя
    static func invoiceForPayment(_ invoiceFor: String) -> String {
        let result = Order.findUserOrders(invoiceFor)
        var sum = 0
        for i in result {
            sum = sum + i.price
        }
        return ("Сумма платежа по заказу пользователя  \"\(invoiceFor)\" составляет \(sum) рублей")
    }
}
// Объявляем класс Bill в котором будем хранить метод для распечатки чека в соответствии с заказами
class Bill {
    // Метод billPayment после оплаты выставленного счета распечатывает чек с общим итогом по заказам
    static func billPayment(_ invoiceFor: String, paid: Bool) -> String {
        var bill: String = ""
        let result = Order.findUserOrders(invoiceFor)
        var sum = 0
        for i in result {
            sum = sum + i.price
            if paid == true {
                bill = bill + "\(i.nameOfProduct), \(i.quantity) \"шт.\", \(i.date), \(i.price) руб."
            } else {
                bill = "Вам необходимо произвести оплату счета"
            }
        }
        return "ИТОГ: \(sum) руб." + bill
    }
}
// На основе структуры Main инициализируем два заказа
var newOrder = Main(nameOfProduct: "Конституция РФ", quantity: 1, price: 100, date: Date(), userLogin: "icer")
var newOrder2 = Main(nameOfProduct: "Уголовный кодекс РФ", quantity: 1, price: 85, date: Date(), userLogin: "icer")
// При помощи метода addOrder добавляем два заказа в массив ordersArray
Order.addOrder([newOrder])
Order.addOrder([newOrder2])
// Проверяем есть ли наши заказы в массиве
Order.ordersArray
// Пробуем найти заказы на определенного пользователя
Order.findUserOrders("icer")
// Выставляем счет по имени пользователя
Payment.invoiceForPayment("icer")
// Если счет не оплачен, просим оплатить
//Bill.billPayment("icer", paid: false)
// Если счет оплачен, распечатываем чек об оплате
Bill.billPayment("icer", paid: true)
