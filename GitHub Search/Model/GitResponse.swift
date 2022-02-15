//
//  GitResponse.swift
//  GitHub Search
//
//  Created by Katerina Ulasik on 10.02.2022.
//

import Foundation


struct GitResponse: Decodable {
    let total_count: Int64
    let incomplete_results: Bool
    let items: [GitResponseItems]
}

struct GitResponseItems: Decodable  {
    let name: String
    let path: String
    let sha: String
    let url: String
    let git_url: String
    let html_url: String
    let repository: GitResponseRepository
}

struct GitResponseRepository: Decodable {
    let id: Int64
    let node_id: String
    let name: String
    let full_name: String
//    let `private`: String
    let owner: GitResponseOwner
}

struct GitResponseOwner: Decodable {
    let id: Int64
    let node_id: String
//    let avatar_url: String
//    let gravatar_url: String
//    let url: String
//    let html_url: String
//    let followers_url: String
//    let following_url: String
//    let gists_url: String
//    let starred_url: String
//    let subscriptions_url: String
//    let organizations_url: String
//    let repos_url: String
//    let events_url: String
//    let received_events_url: String
//    let type: String
//    let site_admin: String
}

struct GitResponseHtmlUrl: Decodable {
    let html_url: String
    let description: String
    let fork: String
    let url: String
    let forks_url: String
    let keys_url: String
    let collaborators_url: String
    let teams_url: String
    let hooks_url: String
    let issue_events_url: String
    let events_url: String
    let assignees_url: String
    let branches_url: String
    let tags_url: String
    let blobs_url: String
    let git_tags_url: String
    let git_refs_url: String
    let trees_url: String
    let statuses_url: String
    let languages_url: String
    let stargazers_url: String
    let contributors_url: String
    let subscribers_url: String
    let subscription_url: String
    let commits_url: String
    let git_commits_url: String
    let comments_url: String
    let issue_comment_url: String
    let contents_url: String
    let compare_url: String
    let merges_url: String
    let archive_url: String
    let downloads_url: String
    let issues_url: String
    let pulls_url: String
    let milestones_url: String
    let notifications_url: String
    let labels_url: String
    let releases_url: String
    let deployments_url: String
}

struct GitResponseScore: Decodable {
    let score: Int
}

struct GitResponseName {
    let name: String
    let path: String
    let sha: String
    let url: String
    let git_url: String
    let html_url: String
    let repository: GitResponseRepositoryNumber2
}

struct GitResponseRepositoryNumber2 {
    let id: Int
    let node_id: String
    let full_name: String
    let `private`: String
    let owner:  GitResponseOwnerNumber2
}

struct  GitResponseOwnerNumber2 {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
}


struct GitResponseHtmlUrlNumber2 {
    let html_url: String
    let description: String
    let fork: Bool
    let url: String
    let forks_url: String
    let keys_url: String
    let collaborators_url: String
    let teams_url:  String
    let hooks_url:  String
    let issue_events_url:  String
    let events_url:  String
    let assignees_url:  String
    let branches_url:  String
    let tags_url:  String
    let blobs_url:  String
    let git_tags_url:  String
    let git_refs_url:  String
    let trees_url:  String
    let statuses_url:  String
    let languages_url:  String
    let stargazers_url:  String
    let contributors_url:  String
    let subscribers_url:  String
    let subscription_url:  String
    let commits_url:  String
    let git_commits_url:  String
    let comments_url:  String
    let issue_comment_url:  String
    let contents_url:  String
    let compare_url:  String
    let merges_url:  String
    let archive_url:  String
    let downloads_url:  String
    let issues_url:  String
    let pulls_url:  String
    let milestones_url:  String
    let notifications_url:  String
    let labels_url:  String
    let releases_url:  String
    let deployments_url:  String
}

struct GitResponseScoreNumber2: Decodable {
    let score: Int
}

struct GitResponseNameNumber2 {
    let name: String
    let path: String
    let sha: String
    let url: String
    let git_url: String
    let html_url: String
    let repository: GitResponseRepositoryNumber3
}

struct GitResponseRepositoryNumber3 {
    let id: Int
    let node_id: String
    let name: String
    let full_name: String
    let `private`: String
    let owner:  GitResponseOwnerNumber3
}

struct  GitResponseOwnerNumber3 {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let gravatar_id: String
    let url: String
    let html_url: String
    let followers_url: String
    let following_url: String
    let gists_url: String
    let starred_url: String
    let subscriptions_url: String
    let organizations_url: String
    let repos_url: String
    let events_url: String
    let received_events_url: String
    let type: String
    let site_admin: Bool
}
