import UIKit

// Задание 1

func nextNumber(_ number: Int) -> Int
{
    let newNumber = number + 1 // Объявляем константу newNumber которой присваиваем сумму входного аргумента number и число 1
    return newNumber // Возвращаем полученное число
}

nextNumber(6) // Проверка 1
nextNumber(52) // Проверка 2
nextNumber(121) // Проверка 3

// Задание 2

func getSquare(_ number:Int) -> Int
{
    let value = number*number // Объявляем константу value которую присваиваем квадрату входного аргумента number
    return(value) // Возвращаем полученное значение
}

getSquare(3)

// Задание 3

func getTime(_ timeInSeconds: Int) {
    let minutes = timeInSeconds/60 // Константа minutes показывает количество минут во входном аргументе timeInSeconds
    let seconds = timeInSeconds%60 // Константа seconds показывает количество секунд во входном аргументе timeInSeconds
    let result: (minutes: Int, seconds: Int) = (minutes, seconds) // В условии задачи сказано что кортеж должен хранится в переменной, но так как наша переменная по условию задачи не меняется, мы будем хранить в константе.
    print(result.minutes) // Воводим в консоль первое значение кортежа
    print(result.seconds) // Выводим в консоль второе значение кортежа
}
getTime(70)

// Задание 4

func concStrings(_ firstStr: String, _ secondStr: String) -> String {
    let result = firstStr + " " + secondStr // Выполняем конкатенацию входных аргументов firstStr и secondStr
    return result // возвращаем результат
}
var totalResult = concStrings("Writing Swift code", "is interactive and fun") // Присваиваем переменной totalResult выданные вызовом функции результаты
print(totalResult) // Выводим результат в консоль

// Задание 5

func dateFormatter(_ myDate: String) -> Date {
    let formattedDate = DateFormatter() // Преобразуем строку в дату используя DateFormatter()
    formattedDate.dateFormat = "yyyy-MM-dd" // Указываем формат нашей строки
    let date = formattedDate.date(from: myDate) ?? Date() // Так как DateFormatter при форматировании возвращает опционал, для раскрытия указываем значение по умолчанию - текущую дату. Т.е. если строка пустая или значение будет с некорректным форматом, вместо nil выводится текущая дата
    return date
}

dateFormatter("2004-11-23")
