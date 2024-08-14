//
//  Model.swift
//  space-finder
//
//  Created by Turma01-4 on 30/07/24.
//

import Foundation

struct Model: Codable, Hashable {
    let _id: String
    let _rev: String
    let bloco_A: [vaga]
   
}

struct vaga: Codable, Hashable {
    let id_vaga: String
    let situacao: String
}
