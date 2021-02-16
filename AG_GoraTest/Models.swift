//
//  Models.swift
//  AG_GoraTest
//
//  Created by iMac on 29.01.2021.
//

import UIKit

struct User: Decodable {
    
    let id: Int
    let name: String
    
}

struct Album: Decodable {
    
    let userId: Int
    let id: Int
}

struct Photo: Decodable {
    
    let albumId: Int
    let title: String
    let url: String
}




