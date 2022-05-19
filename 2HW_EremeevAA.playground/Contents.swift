import UIKit

// 1. Создайте переменную, которая будет хранить строку «Hello, Skillbox» и напечатайте её содержимое с помощью команды print().

var firstString = "Hello, Skillbox"
print(firstString)

// 2. Создайте переменную, которая будет хранить строку «Hello, Skillbox» и напечатайте её содержимое с помощью команды print().

let firstConstant = "Hello, Skillbox"
print(firstString)

// 3. Создайте переменную с явным указанием типа, присвойте ей значение 0.5 и напечатайте её содержимое с помощью команды print().

var firstNumber: Double = 0.5
print(firstNumber)

// 4. Возьмите optional-переменную ниже, извлеките из неё значение (раскройте optional) и напечатайте её значение. Результат не должен содержать обозначения optional.

var swiftString: String? = "String"
print(swiftString ?? "У переменной значение nil")


// 5. Напишите код, который складывает два числа: 10 и 0,5. Выведите результат командой print().

let a: Double = 10
let b = 0.5
let summa = a + b
print(summa)
