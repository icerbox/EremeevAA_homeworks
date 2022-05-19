//
//  ViewInputDelegate.swift
//  MVP-v002
//
//  Created by Андрей Антонен on 13.05.2022.
//

import Foundation

protocol ViewInputDelegate: AnyObject {
    func setupInitialState()
    func setupData(with testData: ([Crypto]))
    func displayData(i: Int)
}


