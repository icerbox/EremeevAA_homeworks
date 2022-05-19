//
//  Presenter.swift
//  MVP-v002
//
//  Created by Андрей Антонен on 13.05.2022.
//

import Foundation

class Presenter {
    weak private var viewInputDelegate: ViewInputDelegate?
    var testData = Crypto.testData
    
    func setViewInputDelegate(viewInputDelegate: ViewInputDelegate?) {
        self.viewInputDelegate = viewInputDelegate
    }
    
    private func loadTestData() {
        self.viewInputDelegate?.setupData(with: self.testData)
        self.viewInputDelegate?.displayData(i: 0)
    }
    
    private func random() {
        let randomCount = Int.random(in: 0 ..< testData.count)
        self.viewInputDelegate?.displayData(i: randomCount)
    }
}

extension Presenter: ViewOutputDelegate {
    func getRandomCount() {
        random()
    }
    func getData() {
        self.loadTestData()
    }
    
    func saveData() {
    }
    
    
}
