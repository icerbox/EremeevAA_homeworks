//
//  DiskResponse.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 02.04.2023.
//

import Foundation
import UIKit

struct DiskResponse: Codable {
  let items: [DiskFile]?
}

struct DiskFile: Codable {
  let name: String?
  let preview: String?
  let size: Int64?
}

struct Images {
  let imageCell: UIImage
}







