//
//  Model.swift
//  space-finder
//
//  Created by Turma01-4 on 30/07/24.
//

import Foundation

struct Model: Codable {
    let _id: String
    let _rev: String
    let bloco_A: [vaga]
   
}

struct vaga: Codable {
    let id: String
    let disponivel: Bool
}
