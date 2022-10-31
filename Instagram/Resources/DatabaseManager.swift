//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Alex on 21/10/2022.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    /// Check if username and email are available
    /// - Parameters:
    ///   - email: String representing email
    ///   - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts new user data to database
    /// - Parameters:
    ///   - email: String representing email
    ///   - username: String representing username
    ///   - completion: Async callback for result if databse entry succeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
