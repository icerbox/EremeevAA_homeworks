import Foundation

class DataModel {
  // Объявляем массив для хранения объектов класса Checklist
  var lists = [Checklist]()
  
  init() {
    loadChecklists()
    registerDefaults()
    handleFirstTime()
  }
  // MARK: - Data Saving
  
  // Метод documentsDirectory возвращает полный путь к папке Документы
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  // dataFilePath использует documentsDirectory() для получения полного пути к файлу который будет хранить экземпляры ChecklistItem. Этот файл называется Checklist.plist и находится внутри папки Документы
  // Оба метода возвращают объект URL. iOs использует URL для ссылки на файлы внутри файловой системы.
  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  // Этот метод берет содержимое массива checklist.items, конвертирует его в блок бинарных данных и затем записывает эти данные в файл.
  func saveChecklists() {
    // Сначала создаем экземпляр PropertyListEncoder который будет конвертировать массив checklist.items, и все элементы ChecklistItems в нем, в некоторый бинарный формат данных который будет записан в файл.
    let encoder = PropertyListEncoder()
    // Ключевое слово do, устанавливает блок кода чтобы поймать ошибки Swift. Swift обрабатывает ошибки под определенными условиями, выбрасывая ошибку. В таких случаях, есть необходимость поймать ошибку и обработать ее. Ключевое слово do означает начало такого блока.
    do {
      // Энкодер который был создан ранее, используется для попытки энкодировать элементы массива. Ключевое слово try означает что вызов энкодера может потерпеть неудачу, и если это случится то будет выведена ошибка.
      let data = try encoder.encode(lists)
      // Если константа data был успешно создан вызовом encode в предыдущей строке, то записываем данные в файл используя путь файла возвращенного методом dataFilePath(). Надо отметить, что метод write может выдать ошибку. Поэтому опять, вы должны перед вызовом метода использовать try.
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
      // Оператор catch указывает на блок кода который будет выполнен при выдаче ошибки любой из строк во внутреннем блоке do.
    } catch {
      // Здесь мы просто печатаем сообщение об ошибке в консоль Xcod'a.
      print("Error encoding list array: \(error.localizedDescription)")
    }
  }
  
  func loadChecklists() {
    // 1. Сначала кладем результаты dataFilePath() во временную константу path
    let path = dataFilePath()
    // 2. Пробуем загрузить содержимое Checklist.plist в новый объект Data. Команда try? пробует создать объект Data, но возвращает nil если он завершается неудачей. Когда оно может завершится неудачей? Например если нет файла Checklist.plist, то есть очевидно что нет объектов ChecklistItem для загрузки. Это будет происходить во время первоначальной загрузке приложения. В таком случае мы пропускаем этот загрузку данных.
    if let data = try? Data(contentsOf: path)
    {
      // 3. Когда приложение находит Checklist.plist, мы загружаем весь массив и его содержимое используя PropertyListDecoder. И создаем экземпляр декодера.
      let decoder = PropertyListDecoder()
      do {
        // 4. Загружаем сохраненные данные обратно в checklist.checklist.items используя метод декодера decode. Декодеру необходимо знать какого типа данные мы должны получить в результате операции докодирования и мы даем ему знать, указав что это будет массив объектов ChecklistItem
        lists = try decoder.decode([Checklist].self, from: data)
        // запускаем метод для сортировки чеклистов
        sortChecklists()
      } catch {
        print("Error decoding list array: \(error.localizedDescription)")
      }
    }
  }
  // Метод registerDefaults задает значение по умолчанию для значения "ChecklistIndex" в UserDefaults. Так как при первом запуске приложения это значение пусто и приложение будет крашится.
  func registerDefaults() {
    // Значение "FirstTime" используется для того, чтобы узнать является ли запуск приложения первым
    let dictionary = ["ChecklistIndex": -1, "FirstTime": true] as [String: Any]
    UserDefaults.standard.register(defaults: dictionary)
  }
  
  var indexOfSelectedChecklist: Int {
    get {
      return UserDefaults.standard.integer(forKey: "ChecklistIndex")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
    }
  }
  
  func handleFirstTime() {
    let userDefaults = UserDefaults.standard
    let firstTime = userDefaults.bool(forKey: "FirstTime")
    
    if firstTime {
      let checklist = Checklist(name: "List")
      lists.append(checklist)
      
      indexOfSelectedChecklist = 0
      userDefaults.set(false, forKey: "FirstTime")
    }
  }
  // Метод для сортировки списков задач по названию
  func sortChecklists() {
    lists.sort { list1, list2 in
      return list1.name.localizedStandardCompare(list2.name) == .orderedAscending
    }
  }
  
  
  
  // Этот метод берет текущее значение "ChecklistitemID" из UserDefaults, добавляет 1 к нему и записывает обратно в UserDefaults. И возвращает предыдущее значение тому кто его вызвал. При первом вызове nextChecklistItemID(), он вернет ID равное 0, при втором вызове 1, при третьем вернет 2 и т.д. Идентификатор каждый раз будет инкрементироваться на 1.
  class func nextChecklistItemID() -> Int {
    let userDefaults = UserDefaults.standard
    let itemID = userDefaults.integer(forKey: "ChecklistItemID")
    userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
    return itemID
  }
  
}


