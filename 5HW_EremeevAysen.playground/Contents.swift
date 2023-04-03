import UIKit

//Что нужно сделать
//1. Выполните шесть практических заданий.
//2. Посмотрите основные принципы ОПП.
// Прочитано
//3. Прочитайте статью на английском про ООП.
//Потренируйтесь находить разницу между классом и объектом. Решите задачу разделения сущностей на классы (используя наследование, где нужно) и протоколы в следующих программах:

//3.1. В игре есть сундук с инвентарём. Инвентарь — различные игровые объекты, например: растения, оружие, квестовые предметы.

// Решение:

// Протокол для типа данных Inventory

protocol InventoryProtocol {
    var type: String { get set }
    var name: String { get set }
}

// Создаем класс Sunduk который имеет свойство array содержащее массив Inventory

class Sunduk {
    var array: [Inventory] = []
    // Метод для добавления указанного экземпляра класса Inventory в массив array класса Sunduk
    func add(element: Inventory) {
        self.array.append(element)
    }
    // Метод для удаления указанного экземпляра класса Inventory из массива array класса Sunduk
    func delete(element: Inventory) {
        self.array = self.array.filter() { $0 !== element }
        }
    
    // Метод для проверки наличия экземпляров в массиве
    func checkIn() {
        if array.count == 0 {
            print("Тут ничего нет")
        }
        else {
            print("Здесь есть элементы")
        }
    }
}
// Класс для объектов инвентаря
class Inventory: InventoryProtocol  {
    var type: String
    var name: String
    init(type: String, name: String) {
        self.type = type
        self.name = name
    }
}

// Подкласс для оружия
class Weapon: Inventory {

}

// Подкласс для зелья
class Potion: Inventory {

}

var Item = Weapon(type: "меч", name: "фальшион")
var sword = Inventory(type: "меч", name: "фальшион")
var smallPotion = Potion(type: "зелье", name: "легкий отвар")
var newArray = Sunduk()
newArray.add(element:Item)
newArray.add(element:sword)
newArray.add(element:smallPotion)
newArray.checkIn()
newArray.delete(element:smallPotion)
newArray.delete(element:sword)
newArray.delete(element:Item)
newArray.checkIn()


// 3.2. В игре показывается карта: с игроками, монстрами (ими управляет компьютер), интерактивными предметами и неподвижными элементами (например, деревья, стены).

// Главный протокол для всех объектов

protocol MainProtocol {
    var type: String { get set }
    var name: String { get set }
}

protocol Drawable: MainProtocol {
    func draw(in map: Map) -> String
}

// Суперкласс для всех объектов

class CommonData: Drawable {
    func draw(in map: Map) -> String {
        return ""
    }
    var type: String
    var name: String
    init(type: String, name: String) {
        self.type = type
        self.name = name
    }
    
}

class Map {
    func draw(objects: Drawable...) -> String {
        var result = ""
        for object in objects {
            result += object.draw(in: self) + "; "
        }
        return result
    }
}

// Подкласс на основе суперкласса для всех объектов

class Player: CommonData {

    
    func move() -> String {
        return "Вы передвинули игрока"
    }
    override func draw(in map: Map) -> String {
        return "Игрок помещен на карту"
    }
}

class Monster: CommonData {
    let fallen = CommonData(type: "Demon", name: "Демон")
    let zombie = CommonData(type: "Undead", name: "Зомби")
    func aiMove() -> String {
        return "Монстр сделал шаг"
    }
    override func draw(in map: Map) -> String {
         return "Монстр помещен на карту"
     }
}

class InteractiveItem: CommonData {
    func itemTaken() -> String {
        return "Вы передвинули интерактивный предмет"
    }
    override func draw(in map: Map) -> String {
         return "Интерактивный предмет помещен на карту"
     }
}

class StaticItem: CommonData {
    func staticItemTaken() -> String {
        return "Этот элемент нельзя передвинуть"
    }
    override func draw(in map: Map) -> String {
         return "Неподвижный элемент помещен на карту"
     }
}

let map = Map()
let player = Player(type: "Human", name: "Варвар")
let monster = Monster(type: "Demon", name: "Демон")
let item = InteractiveItem(type: "Stone", name: "Камень")
let tree = StaticItem(type: "Tree", name: "Дерево")


map.draw(objects: player, monster, item, tree)
player.move

// 3.3. В приложении есть три модели машин, у каждой из которых есть три комплектации. Модели отличаются названием, картинкой. Комплектации — названием, ценой, цветом, объёмом двигателя.


//  Протокол

protocol Car {
    var modelName: String { get }
    var modelImage: String { get set }
    var equipment: [Equipment] { get set }
}

// Класс для комплектаций

class Equipment {
    var equipmentColor: String
    let equipmentName: String
    let equipmentPrice: Int
    let equipmentVolume: Double
    init(equipmentColor: String, equipmentName: String, equipmentPrice: Int, equipmentVolume: Double) {
        self.equipmentColor = equipmentColor
        self.equipmentName = equipmentName
        self.equipmentPrice = equipmentPrice
        self.equipmentVolume = equipmentVolume
    }
}

// Класс для методов

// Класс для первой модели машины

class ToyotaVitz: Car {
    var modelName = "Toyota Vitz"
    var modelImage = "ToyotaVitz.jpg"
    var equipment: [Equipment] = []
    func add(element: Equipment) {
        self.equipment.append(element)
        }
        // Метод для удаления указанного экземпляра класса Inventory из массива array класса Sunduk
    func delete(element: Inventory) {
        self.equipment = self.equipment.filter() { $0 !== element }
        }
}

// Инициализируем комплектации для модели ToyotaVitz

let standart = Equipment(equipmentColor: "Белый", equipmentName: "Стандартная комплектация", equipmentPrice: 700000, equipmentVolume: 1.0)
let econom = Equipment(equipmentColor: "Серый", equipmentName: "Эконом комплектация", equipmentPrice: 600000, equipmentVolume: 0.7)
let business = Equipment(equipmentColor: "Черный", equipmentName: "Бизнес комплектация", equipmentPrice: 800000, equipmentVolume: 1.3)
var newEquipment = ToyotaVitz()
newEquipment.add(element: standart)
newEquipment.add(element: econom)
newEquipment.add(element: business)

// Класс для второй модели машины
class ToyotaRav4: Car {
    var modelName = "Toyota Rav 4"
    var modelImage = "ToyotaRav4.jpg"
    var equipment: [Equipment] = []
    func add(element: Equipment) {
        self.equipment.append(element)
        }
        // Метод для удаления указанного экземпляра класса Inventory из массива array класса Sunduk
    func delete(element: Inventory) {
        self.equipment = self.equipment.filter() { $0 !== element }
        }
}

// Инициализируем комплектации для модели ToyotaRav4
let standart2 = Equipment(equipmentColor: "Белый", equipmentName: "Стандартная комплектация", equipmentPrice: 2500000, equipmentVolume: 2.5)
let econom2 = Equipment(equipmentColor: "Серый", equipmentName: "Эконом комплектация", equipmentPrice: 2000000, equipmentVolume: 2.0)
let business2 = Equipment(equipmentColor: "Черный", equipmentName: "Бизнес комплектация", equipmentPrice: 2700000, equipmentVolume: 3.5)
var newEquipment2 = ToyotaRav4()
newEquipment2.add(element: standart)
newEquipment2.add(element: econom)
newEquipment2.add(element: business)

// Класс для третьей модели машины

class ToyotaLandCruiser: Car {
    var modelName = "Toyota Land Cruiser"
    var modelImage = "ToyotaLandCruiser.jpg"
    var equipment: [Equipment] = []
    func add(element: Equipment) {
        self.equipment.append(element)
        }
        // Метод для удаления указанного экземпляра класса Inventory из массива array класса Sunduk
    func delete(element: Inventory) {
        self.equipment = self.equipment.filter() { $0 !== element }
        }
}

// Инициализируем комплектации для модели ToyotaRav4
let standart3 = Equipment(equipmentColor: "Белый", equipmentName: "Стандартная комплектация", equipmentPrice: 5500000, equipmentVolume: 4.7)
let econom3 = Equipment(equipmentColor: "Серый", equipmentName: "Эконом комплектация", equipmentPrice: 5000000, equipmentVolume: 4.0)
let business3 = Equipment(equipmentColor: "Черный", equipmentName: "Бизнес комплектация", equipmentPrice: 6000000, equipmentVolume: 5.7)

var newEquipment3 = ToyotaLandCruiser()
newEquipment3.add(element: standart)
newEquipment3.add(element: econom)
newEquipment3.add(element: business)

// 4. В каких случаях лучше использовать наследование, а в каких — расширения (extension)?

//Ответ: Если требуется создать класс не с нуля, а на базе уже существующего класса то лучше использовать наследование. Если необходимо добавить новую функциональность к уже существующему объектному типу (классу, структуре, перечислению) или протоколу то лучше использовать расширения (extension)

//5. Ответьте, не используя Xcode:
//Что выведется в консоль в результате выполнения следующего кода?
//Если код некорректен, какая строчка не скомпилируется и почему?

// Протокол A требует любой соответствующий ему тип иметь метод экземпляра a.

//protocol A{
//    func a()
//}
//

// Протокол B требует любой соответствующий ему тип иметь метод экземпляра b.

//protocol B{
//    func b()
//}
// Расширение добавляет новое требование к протоколу B, которое указывает, что принимающие его объектные типы должны содержать в методе экземпляра "b" строку "print("extB")"
//
//extension B{
//    func b(){
//        print("extB")
//    }
//}

// Класс "C" принимает протокол A, и полностью удовлетворяет требованиям протокола
//
//class C: A{
//    func a() {
//        print("A")
//    }
//    func c(){
//        print("C")
//    }
//}
// Класс "D" наследует класс C и  принимает протокол B, и полностью удовлетворяет требованиям протоколов B и A - т.к. из-за наследования класса C он уже содержит в себе функцию a, которую требует протокол А

//class D: C, B{
//    func b() {
//        print("B")
//    }
//    func d(){
//        print("D")
//    }
//}
//

//
//let v1: A = D() // объявляется константа "v1" имеющий тип протокола "А" и присваивается классу "D" который наследует класс "А" и принимает протокол "B".
//      v1.a()   // 5.1. Ответ: Данная строка скомпилируется нормально, т.к. класс "D" наследует класс "C" который содержит в себе метод экземпляра "a". В консоли выведется строка "A".
//let v2: B = C() // объявляется константа "v2", имеющий тип протокол "B" и присваивается классу "C" который принимает протокол "A". Класс С не реализует протокол В
//      v2.c() // 5.2. Ответ: Данная строка вызовет ошибку, т.к. тип "В" не содержит в себе метод экземпляра "c".
// let v3: C = D() // Объявляется константа "v3" с типом данных класса "C" и присваивается классу "D"
//      v3.d() // 5.3. Ответ: Данная строка вызовет ошибку т.к. тип класса "С" не содержит метод "d"
//let v4: D = D() // Объявляется констанка v4 с типом данных класса "D" и присваивается классу "D"
//      v4.a() // 5.4. Ответ: Данная строка скомпилируется нормально т.к. тип класса "D" наследует класс "С" который содержит в себе метод экземпляра "a". В консоли выведется строка "A".
//
//
//6. Заучите определения полиморфизма, инкапсуляции и наследования — об этом могут спрашивать на собеседовании. Если их суть не до конца понятна, пересмотрите видео, перечитайте статью или задайте вопрос в Telegram-чат. Понимать их крайне важно.

// Ответ: Выполнено
