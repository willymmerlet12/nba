//
//  CreatePlayers.swift
//  
//
//  Created by Willy Merlet on 24/03/22.
//

import Fluent

struct CreatePlayers: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("players")
            .id()
            .field("name", .string, .required)
            .field("team", .string, .required)
            .field("position", .string, .required)
            .field("image", .string, .required)
            .create()
            }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("players").delete()
    }
    
    
}

