//
//  Models.swift
//  Instagram
//
//  Created by Alex on 31/10/2022.
//

import Foundation

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public enum Gender {
    case male, female, other
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let postURL: URL
    let thumbnailImage: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let profilePhoto: URL
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}
