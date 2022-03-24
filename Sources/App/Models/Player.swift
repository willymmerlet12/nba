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
    var image: Data
    
    init() { }
    
    init(id: UUID?, name: String, team: String, position: String, image: Data) {
        self.id = id
        self.name = name
        self.team = team
        self.position = position
        self.image = image
    }
    
//    enum CodingKeys: String, CodingKey {
//            case id = "id"
//            case name = "name"
//            case team = "team"
//            case position = "position"
//            case image = "image"
//        }
//
    struct Output: Content {
            var id: UUID?
            var name: String
            var team: String
            var position: String
            var image : Data
        }
//
//    struct Input: Content {
//            var id: UUID?
//            var name: String
//            var team: String
//            var position: String
//            var image : String?
//
//        }
        
    }

//extension Player {
//    func responseFrom(baseUrl: String)-> Player.Output {
//        let r = self
//        return .init(id: r.id, name: r.name, team: r.team, position: r.position, image: r.image.map {baseUrl + $0})
//    }
//}


extension Request {
    var baseUrl: String {
        let configuration = application.http.server.configuration
        let scheme = configuration.tlsConfiguration == nil ? "http" : "https"
        let host = configuration.hostname
        let port = configuration.port
        return "\(scheme)://\(host):\(port)"
    }
}
