//
//  ViewController.swift
//  Instagram
//
//  Created by Alex on 21/10/2022.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}
class HomeViewController: InitialViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createMockModels()
    }
    
    private func createMockModels() {
        let user = User(username: "joe", bio: "", name: (first: "", last: ""), birthDate: Date(), profilePhoto: URL(string: "https://www.google.com")!, gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "", postType: .photo, postURL: URL(string: "https://www.google.com")!, thumbnailImage: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@dave", text: "Great post!", createdDate: Date(), likes: []))
        }
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType:                                                .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }

    func handleNotAuthenticated() {
        // Check auth status
        if FirebaseAuth.Auth.auth().currentUser == nil {
            // Show log in VC
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        let position = section % 4 == 0 ? section / 4 : ((section - (section % 4)) / 4)
        model = feedRenderModels[position]
        let subSection = section % 4
        if subSection == 0 { // header
            return 1
        } else if subSection == 1 { // post
            return 1
        } else if subSection == 2 { // actions
            return 1
        } else if subSection == 3 { // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            case .header(_), .actions(_), .primaryContent(_):
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        let position = indexPath.section % 4 == 0 ? indexPath.section / 4 : ((indexPath.section - (indexPath.section % 4)) / 4)
        model = feedRenderModels[position]
        let subSection = indexPath.section % 4
        if subSection == 0 { // header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .comments(_), .actions(_), .primaryContent(_):
                return UITableViewCell()
            }
        } else if subSection == 1 { // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .comments(_), .actions(_), .header(_):
                return UITableViewCell()
            }
        } else if subSection == 2 { // actions
            switch model.actions.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            case .comments(_), .header(_), .primaryContent(_):
                return UITableViewCell()
            }
        } else if subSection == 3 { // comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header(_), .actions(_), .primaryContent(_):
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 { // header
            return 70
        } else if subSection == 1 { // post
            return tableView.width
        } else if subSection == 2 { // actions
            return 60
        } else if subSection == 3 { // comments
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section % 4 == 3 {
            return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
