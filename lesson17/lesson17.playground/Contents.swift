import UIKit
import PlaygroundSupport
import Darwin
import Foundation

//import PlaygroundSupport

// Урок 1. Thread & Pthread

//--------- Низкоуровневое создание потоков
// Создаем поток
//var thread = pthread_t(bitPattern: 0)
//// Создаем аттрибут
//var attribut = pthread_attr_t()
//
//// Инициализируем атрибут
//pthread_attr_init(&attribut)
//// Вызываем поток
//pthread_create(&thread, &attribut, { (pointer) -> UnsafeMutableRawPointer? in
//    print("test")
//    return nil
//}, nil)
//
////2 Thread ------- Как это реализовано в свифте
//var nsthread = Thread {
//    print("test")
//}

//nsthread.start()

// Урок 2. Quality of service

//var lesson2 = "Quality of Service" + ("Качество обслуживания")

//var pthread = pthread_t(bitPattern: 0)
//var attribute = pthread_attr_t()
//pthread_attr_init(&attribute)
//pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)
//pthread_create(&pthread, &attribute, { (pointer) -> UnsafeMutableRawPointer? in
//    print("test")
//    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
//    return nil
//}, nil)

//let nsThread = Thread {
//    print("test")
//    print(qos_class_self())
//}
//nsThread.qualityOfService = .userInitiated
//nsThread.start()
//
//print(qos_class_main())

//Урок 3. Synchronization & Mutex

//class SafeThread {
//    // создаем мутекс
//    private var mutex = pthread_mutex_t()
//    // инициализируем
//    init() {
//        pthread_mutex_init(&mutex, nil)
//    }
//    // создадим метод
//    func someMethod(completion: () ->()) {
//        pthread_mutex_lock(&mutex)
//        // some data ---- то что находится между двумя блоками mutex защищено от других потоков
//        completion()
//        // defer нужен для освобождения потока если что-то между мутексами пойдет не так
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//    }
//}

//class SafeThread {
//    // создаем мутекс
//    private let lockMutex = NSLock()
//    // создадим метод
//    func someMethod(completion: () ->()) {
//        lockMutex.lock()
//        completion()
//        // defer нужен для освобождения потока если что-то между мутексами пойдет не так
//        defer {
//            lockMutex.unlock()
//        }
//    }
//}
//
//var array = [String]()
//let safeThread = SafeThread()
//
//safeThread.someMethod {
//    print("test")
//    array.append("1 thread")
//}
//
//array.append("2 thread")

// Урок 4. NSRecursiveLock & Mutex RecursiveLock4

//let recursiveLock = NSRecursiveLock()
//
//class RecursiveMutexTest {
//    // Создаем мутекс
//    private var mutex = pthread_mutex_t()
//    // Создаем атрибуты
//    private var attribute = pthread_mutexattr_t()
//    // Инициализируем атрибуты
//    init() {
//        pthread_mutexattr_init(&attribute)
//        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
//        pthread_mutex_init(&mutex, &attribute)
//    }
//    func firstTask() {
//        pthread_mutex_lock(&mutex)
//        pthread_mutex_unlock(&mutex)
//        twoTask()
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//    }
//    func twoTask() {
//        pthread_mutex_lock(&mutex)
//        print("Finish")
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//    }
//
//}
//
//let recursive = RecursiveMutexTest()
//recursive.firstTask()

//let recursiveLock = NSRecursiveLock()
//
//class RecursiveThread: Thread {
//    override func main() {
//        recursiveLock.lock()
//        print("Thread acquired lock")
//        callMe()
//        defer {
//            recursiveLock.unlock()
//        }
//        print("Exit main")
//    }
//
//    func callMe() {
//        recursiveLock.lock()
//        print("Thread acquired lock")
//        defer {
//            recursiveLock.unlock()
//        }
//        print("Exit callMe")
//    }
//}
//
//let thread = RecursiveThread()
//thread.start()

// Урок 5. NSCondition, NSLocking, pthread_cond_t

//var str = NSCondition()
//
//var available = false
//var condition = pthread_cond_t()
//var mutex = pthread_mutex_t()
//
//class ConditionMutexPrinter: Thread {
//
//    override init() {
//        pthread_cond_init(&condition, nil)
//        pthread_mutex_init(&mutex, nil)
//    }
//
//    override func main() {
//        printerMethod()
//    }
//
//    private func printerMethod() {
//        //
//        pthread_mutex_lock(&mutex)
//        print("Printer enter")
//        // если available = false то:
//        while (!available) {
//            // кондишн и мутекс пока ожидают
//            pthread_cond_wait(&condition, &mutex)
//        }
//        available = false
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//        print("Printer exit")
//    }
//}
//
//class ConditionMutexWriter: Thread {
//
//    override init() {
//        pthread_cond_init(&condition, nil)
//        pthread_mutex_init(&mutex, nil)
//    }
//
//    override func main() {
//        writerMethod()
//    }
//
//    private func writerMethod() {
//        //
//        pthread_mutex_lock(&mutex)
//        print("Writer enter")
//        // если available = false то:
//        pthread_cond_signal(&condition)
//        available = true
//        defer {
//            pthread_mutex_unlock(&mutex)
//        }
//        print("Writer exit")
//    }
//}
//
//let conditionMutexWriter = ConditionMutexWriter()
//let conditionMutexPrinter = ConditionMutexPrinter()
//
//conditionMutexPrinter.start()
//conditionMutexWriter.start()

//let condition = NSCondition()
//var available = false
//
//class WriterThread: Thread {
//    override func main() {
//        // блокируем поток от изменений при запуске
//        condition.lock()
//        print("WriterThread enter")
//        // пишем что поток доступен
//        available = true
//        // отказываемся от ранее установленной блокировки
//        condition.signal()
//        // разблокируем наш поток
//        condition.unlock()
//        print("WriterThread exit")
//    }
//}
//
//class PrinterThread: Thread {
//    override func main() {
//        // блокируем поток от изменений при запуске
//        condition.lock()
//        print("PrinterThread enter")
//
//        while(!available) {
//            condition.wait()
//        }
//        // пишем что поток недоступен
//        available = false
//        // разблокируем поток
//        condition.unlock()
//        print("PrinterThread exit")
//    }
//}
//
//let writer = WriterThread()
//let printer = PrinterThread()
//
//printer.start()
//writer.start()

// Урок 6. ReadWriteLock, SpinLock, UnfairLock, Synchronized in Objc

//class ReadWriteLock {
//    private var lock = pthread_rwlock_t()
//    private var attribute = pthread_rwlockattr_t()
//    private var globalProperty: Int = 0
//
//    init() {
//        pthread_rwlock_init(&lock, &attribute)
//    }
//
//    public var workProperty: Int {
//        get {
//            pthread_rwlock_wrlock(&lock)
//            let temp = globalProperty
//            pthread_rwlock_unlock(&lock)
//            return temp
//        }
//        set {
//            pthread_rwlock_wrlock(&lock)
//            globalProperty = newValue
//            pthread_rwlock_unlock(&lock)
//        }
//    }
//}

// deprecated in iOS 10.0

//class SpinLock {
//    private var lock = OS_SPINLOCK_INIT
//
//    func some() {
//        OSSpinLockLock(&lock)
//        // something
//        OSSpinLockUnlock(&lock)
//    }
//}

//с iOS 10.0
//class UnfairLock {
//    private var lock = os_unfair_lock_s()
//
//    var array = [Int]()
//
//    func some() {
//        os_unfair_lock_lock(&lock)
//        array.append(1)
//        os_unfair_lock_unlock(&lock)
//    }
//}

//class SynchronizedObjc {
//    private let lock = NSObject()
//
//    var array = [Int]()
//
//    func some() {
//        objc_sync_enter(lock)
//        array.append(1)
//        objc_sync_exit(lock)
//    }
//}

// Урок 7. GCD, Concurrent queues, serial queues, sync-async

//class QueueTest1 {
//    // Создаем последовательную очередь
//    private let serialQueue = DispatchQueue(label: "serialTest")
//    // Создаем параллельную очередь
//    private let concurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
//}
//
//class QueueTest2 {
//    // Глобальная очередь имеет 5 очередей
//    private let globalQueue = DispatchQueue.global()
//    // Main.queue входитв глобальную очередь
//    private let mainQueue = DispatchQueue.main
//}


// Урок 8. GCD Практика + Bonus, Syns-Async

// 1. Выбрать в какой очереди мы должны работать:
// 1. DispatchQueue.global DispatchQueue.main

// 2. Выбрать приоритет
// let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
// let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
// let utilityQueue = DispatchQueue.global(qos: .utility)

// самый низкий приоритет
// let backgroundQueue = DispatchQueue.global(.background)

// по умолчанию
// let defaultQueue = DispatchQueue.global()






















































//PlaygroundPage.current.needsIndefiniteExecution = true
//
//var str = "Dispatch Group"
//
////Последовательное выполнение задач
//
//class DispatchGroupTest1 {
//    private let queueSerial = DispatchQueue(label: "The Swift Developers")
//
//    private let groupRed = DispatchGroup()
//
//    func loadInfo() {
//        queueSerial.async(group: groupRed) {
//            sleep(1)
//            print("1")
//        }
//        queueSerial.async(group: groupRed) {
//            sleep(1)
//            print("2")
//        }
//        groupRed.notify(queue: .main) {
//            print("groupRed finished all tasks")
//        }
//    }
//}
//
//let dispatchGroupTest1 = DispatchGroupTest1()
////dispatchGroupTest1.loadInfo()
//
//
//// Параллельное выполнение задач
//
//class DispatchGroupTest2 {
//    private let queueConc = DispatchQueue(label: "The Swift Developers", attributes: .concurrent)
//
//    private let groupBlack = DispatchGroup()
//
//    func loadInfo() {
//        groupBlack.enter()
//        queueConc.async {
//            sleep(1)
//            print("1")
//            self.groupBlack.leave()
//        }
//        groupBlack.enter()
//        queueConc.async {
//            sleep(2)
//            print("2")
//            self.groupBlack.leave()
//        }
//        groupBlack.wait()
//        print("finished all")
//
//        groupBlack.notify(queue: .main) {
//            print("groupBlack finished all tasks")
//        }
//    }
//}
//
//let dispatchGroupTest2 = DispatchGroupTest2()
//dispatchGroupTest2.loadInfo()
//
//class EightImage: UIView {
//    public var ivs = [UIImageView]()
//
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        ivs.append(UIImageView(frame))
//    }
//}

//class MyViewController: UIViewController {
//    var button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "vc1"
//        view.backgroundColor = UIColor.white
//        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        initButton()
//    }
//
//    @objc func pressAction() {
//        let vc = SecondViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func initButton() {
//        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        button.center = view.center
//        button.setTitle("Press", for: .normal)
//        button.backgroundColor = UIColor.green
//        button.layer.cornerRadius = 10
//        button.setTitleColor(UIColor.white, for: .normal)
//        view.addSubview(button)
//    }
//}
//
//class SecondViewController: UIViewController {
//
//    var image = UIImageView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "vc1"
//        view.backgroundColor = UIColor.white
//        loadPhoto()
////        let imageURL: URL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
////        if let data = try? Data(contentsOf: imageURL) {
////            self.image.image = UIImage(data: data)
////        }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        initImage()
//    }
//
//    func initImage() {
//        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
//        image.center = view.center
//        view.addSubview(image)
//    }
//    func loadPhoto() {
//        let imageURL: URL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            if let data = try? Data(contentsOf: imageURL) {
//                DispatchQueue.main.async {
//                    self.image.image = UIImage(data: data)
//                }
//            }
//        }
//
//    }
//}
//
//let vc = MyViewController()
//
//let navbar = UINavigationController(rootViewController: vc)
//navbar.view.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
//PlaygroundPage.current.liveView = navbar

// Урок 10. GCD DispatchWorkItem, notify

//PlaygroundPage.current.needsIndefiniteExecution = true
//
////# classic
//class DispatchWorkItem1 {
//    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
//
//    func create() {
//        let workItem = DispatchWorkItem {
//            print(Thread.current)
//            print("Start task")
//        }
//        workItem.notify(queue: .main) {
//            print(Thread.current)
//            print("Task finished")
//        }
//        queue.async(execute: workItem)
//    }
//}
//
//let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()
//
//class DispatchWorkItem2 {
//    private let queue = DispatchQueue(label: "DispatchWorkItem2")
//
//    func create() {
//        queue.async {
//            sleep(1)
//            print("Task 1")
//        }
//
//        queue.async {
//            sleep(1)
//            print("Task 2")
//        }
//
//        let workItem = DispatchWorkItem {
//            print(Thread.current)
//            print("Start work item task")
//        }
//
//        queue.async(execute: workItem)
//
//        workItem.cancel()
//    }
//}
//
////let dispatchWorkItem2 = DispatchWorkItem2()
////dispatchWorkItem2.create()
//
//var view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//
//eiffelImage.backgroundColor = UIColor.yellow
//eiffelImage.contentMode = .scaleAspectFit
//view.addSubview(eiffelImage)
//
//PlaygroundPage.current.liveView = view
//
//let imageURL: URL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//
//func fetchImage() {
//    // Создали глобальную очередь с качеством обслуживания .utility
//    let queue = DispatchQueue.global(qos: .utility)
//    // Делаем асинхронный вызов задачи
//    queue.async {
//        // Помещаем задачу в замыкание
//        // Получили дату по ссылке из интернета
//        if let data = try? Data(contentsOf: imageURL) {
//            // Когда ссылка получена перевели ее в главный поток асинхронно
//            DispatchQueue.main.async {
//                eiffelImage.image = UIImage(data: data)
//            }
//        }
//    }
//}
////fetchImage()
//
//// # Dispatch work item
//
//func fetchImage2() {
//    var data: Data?
//    let queue = DispatchQueue.global(qos: .utility)
//
//    let workItem = DispatchWorkItem(qos: .userInteractive) {
//        data = try? Data(contentsOf: imageURL)
//        print(Thread.current)
//    }
//
//    queue.async(execute: workItem)
//    // Когда задача сверху завершится, запускается notify и переводим блок в главный поток и обновляем UI
//    workItem.notify(queue: DispatchQueue.main) {
//        if let imageData = data {
//            eiffelImage.image = UIImage(data: imageData)
//        }
//    }
//}
//
//
//fetchImage2()
//
//// # URLSession
//
//func fetchImage3() {
//    let task = URLSession.shared.dataTask(with: imageURL) {
//        (data, response, error) in
//        print(Thread.current)
//        if let imageData = data {
//            DispatchQueue.main.async {
//                eiffelImage.image = UIImage(data: imageData)
//            }
//        }
//    }
//    task.resume()
//}
//
//fetchImage3()
//

// Урок 11. GCD Semaphore
//
//let queue = DispatchQueue(label: "IceR", attributes: .concurrent)
//
//let semaphore = DispatchSemaphore(value: 2)
//
//// Помести в глобальную очередь
//queue.async {
//    semaphore.wait() //-1
//    sleep(3)
//    print("method 1")
//    semaphore.signal() //+1
//}
//
//queue.async {
//    semaphore.wait() //-1
//    sleep(3)
//    print("method 2")
//    semaphore.signal() //+1
//}
//
//queue.async {
//    semaphore.wait() //-1
//    sleep(3)
//    print("method 3")
//    semaphore.signal() //+1
//}
//
//let sem = DispatchSemaphore(value: 2)
//
//DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
//    sem.wait(timeout: DispatchTime.distantFuture)
//    print("Block", String(id))
//    sem.signal()
//}

//class SemaphorTest {
//    private let semaphore = DispatchSemaphore(value: 2)
//    private var array = [Int]()
//
//    private func methodWork(_ id: Int) {
//        semaphore.wait() // -1
//
//        array.append(id)
//        print("test array", array.count)
//
//        Thread.sleep(forTimeInterval: 2)
//        semaphore.signal() // +1
//    }
//    public func startAllThread() {
//        DispatchQueue.global().async {
//            self.methodWork(111)
////            print(Thread.current)
//        }
//        DispatchQueue.global().async {
//            self.methodWork(112)
////            print(Thread.current)
//        }
//        DispatchQueue.global().async {
//            self.methodWork(113)
////            print(Thread.current)
//        }
//        DispatchQueue.global().async {
//            self.methodWork(114)
////            print(Thread.current)
//        }
//        DispatchQueue.global().async {
//            self.methodWork(115)
////            print(Thread.current)
//        }
//    }
//}
//
//let semaphoreTest = SemaphorTest()
//semaphoreTest.startAllThread()

//# Урок 12. GCD Dispatch Group

PlaygroundPage.current.needsIndefiniteExecution = true

class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "IceR")
    
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print(Thread.current)
            print("1")
        }
        queueSerial.async(group: groupRed) {
            sleep(1)
            print(Thread.current)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("groupRed finished all ")
            print(Thread.current)
        }
    }
}

let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()

class DispatchGroupTest2 {
    private let queueConcurrent = DispatchQueue(label: "IceR", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queueConcurrent.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        groupBlack.enter()
        queueConcurrent.async {
            sleep(2)
            print("2")
            self.groupBlack.leave()
        }
        groupBlack.wait()
        
        print("finished all")
        groupBlack.notify(queue: .main) {
            print("groupBlack finished all")
        }
    }
}

let dispatchGroupTest2 = DispatchGroupTest2()
//dispatchGroupTest2.loadInfo()

class EightImage: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
view.backgroundColor = UIColor.red

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png", "https://media-cdn.tripadvisor.com/media/photo-s/0b/dc/76/7d/venice-beach-boardwalk.jpg" ]

var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    completionQueue: DispatchQueue,
                    completion: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async { completion(UIImage(data: data), nil) }
        } catch let error {
            completionQueue.async { completion(nil, error) }
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for i in 0...3 {
        aGroup.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i])!,
                       runQueue: .global(),
                       completionQueue: .main) { result, error in
                       guard let image1 = result else { return }
                       images.append(image1)
                       aGroup.leave()
        }
    }
    
    aGroup.notify(queue: .main) {
        for i in 0...3 {
            view.ivs[i].image = images[i]
        }
    }
}

func asyncURLSession() {
    for i in 4...7 {
        let url = URL(string: imageURLs[i - 4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                view.ivs[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

asyncURLSession()
//asyncGroup()



