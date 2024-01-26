//
//  videoModel.swift
//  playVideoApp
//
//  Created by 윤규호 on 1/25/24.
//

import Foundation

struct videoModel : Codable {
    let id: String
    let title: String
    let thumbnailUrl: String
    let videoUrl: String
}
