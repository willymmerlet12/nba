//
//  PlayerController.swift
//  
//
//  Created by Willy Merlet on 24/03/22.
//

import Fluent
import Vapor

struct PlayerController: RouteCollection {
    let logger = Logger(label: "imagecontroller")
    
    func boot(routes: RoutesBuilder) throws {
        let players = routes.grouped("players")
        players.get(use: index)
        players.post(use: create)
        players.delete("players", ":id", use: delete)
        
    }
    
    // GET players route
    func index(req: Request) throws -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {

        let player = try req.content.decode(Player.self)
        return player.save(on: req.db).transform(to: .ok)
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
            guard let id = req.parameters.get("id", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            return Player.find(id, on: req.db)
                .unwrap(or: Abort(.notFound))
                .flatMap { $0.delete(on: req.db) }
                .map { .ok }
        }
    
    }
   
    


extension PlayerController {
    fileprivate func saveFile(name: String, data: Data) throws {
        let path = FileManager.default
            .currentDirectoryPath.appending("/\(name)")
        if FileManager.default.createFile(atPath: path,
                                          contents: data,
                                          attributes: nil) {
            debugPrint("saved file\n\t \(path)")
        } else {
            throw FileError.couldNotSave
        }
    }
}

enum FileError: Error {
    case couldNotSave
}
