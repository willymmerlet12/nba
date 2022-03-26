//
//  Player.swift
//  
//
//  Created by Willy Merlet on 24/03/22.
//

import Foundation
import Fluent
import Vapor

final class Player: Codable, Model, Content {
    static let schema = "players"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "team")
    var team: String
    
    @Field(key: "position")
    var position: String
    
    @Field(key: "image")
    var image: String
    
    init() { }
    
    init(id: UUID?, name: String, team: String, position: String, image: String) {
        self.id = id
        self.name = name
        self.team = team
        self.position = position
        self.image = image
    }
    


}
