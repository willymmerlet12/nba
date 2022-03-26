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
        
    }
    
    // GET players route
    func index(req: Request) throws -> EventLoopFuture<[Player]> {
        return Player.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {

        let player = try req.content.decode(Player.self)
        return player.save(on: req.db).transform(to: .ok)
    }
    
    
    
//    func createe(req: Request) throws -> EventLoopFuture<Player.Output> {
//            struct Entity: Content {
//                var images: [File]
//            }
//            let uploadPath = req.application.directory.publicDirectory + "uploads/"
//            let player = try req.content.decode(Player.self)
//            let input = try req.content.decode(Entity.self)
//
//            return input.images.map { file -> EventLoopFuture<String> in
//                let filename = "\(Date().timeIntervalSince1970)_" + file.filename.replacingOccurrences(of: " ", with: "")
//                return req.fileio.writeFile(file.data, at: uploadPath + filename ).map { filename }
//            }.flatten(on: req.eventLoop).map { filenames in
//                player.image = filenames
//            }.flatMap { _ in
//                return player.save(on: req.db).map {
//                    return player.responseFrom(baseUrl: req.baseUrl)
//                }
//            }
//        }
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
