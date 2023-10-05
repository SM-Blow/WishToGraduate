//
//  PostAPI.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/05.
//

import Foundation

import Moya

final class PostAPI {
    static let shared: PostAPI = PostAPI()
    
    private let postProvider = MoyaProvider<PostService>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var postListData: GeneralResponse<GetPostsResponseDto>?
    public private(set) var postListByCategoryData: GeneralResponse<GetPostsResponseDto>?
    public private(set) var scrapPostListData: GeneralResponse<GetScrapPostResponseDto>?
    public private(set) var scrapPost: GeneralResponse<PostScrapResponseDto>?
    public private(set) var searchListData: GeneralResponse<GetPostsResponseDto>?
    
    // MARK: - GET
    /// 게시물 전체 조회
    func getAllPost(completion: @escaping (GeneralResponse<GetPostsResponseDto>?) -> Void) {
        postProvider.request(.getAllPosts) { result in
            switch result {
            case .success(let response):
                do {
                    self.postListData = try response.map(GeneralResponse<GetPostsResponseDto>?.self)
                    guard let postListData = self.postListData else { return }
                    completion(postListData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    /// 카테고리별 게시물 조회
    func getPostByCategory(category: String,
                           completion: @escaping (GeneralResponse<GetPostsResponseDto>?) -> Void) {
        postProvider.request(.getPostByCategory(category: category)) { result in
            switch result {
            case .success(let response):
                do {
                    self.postListByCategoryData = try response.map(GeneralResponse<GetPostsResponseDto>?.self)
                    guard let postListByCategoryData = self.postListByCategoryData else { return }
                    completion(postListByCategoryData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    /// 스크랩한 게시글 조회
    func getScrapPost(completion: @escaping (GeneralResponse<GetScrapPostResponseDto>?) -> Void) {
        postProvider.request(.getScrapPost) { result in
            switch result {
            case .success(let response):
                do {
                    self.scrapPostListData = try response.map(GeneralResponse<GetScrapPostResponseDto>?.self)
                    guard let scrapPostListData = self.scrapPostListData else { return }
                    completion(scrapPostListData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    
    /// 검색 게시글
    func getSearchPost(keyword: String,
                       completion: @escaping (GeneralResponse<GetPostsResponseDto>?) -> Void) {
        postProvider.request(.getSearch(keyword: keyword)) { result in
            switch result {
            case .success(let response):
                do {
                    self.searchListData = try
                    response.map(GeneralResponse<GetPostsResponseDto>?.self)
                    guard let searchListData = self.searchListData else { return }
                    completion(searchListData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: POST
    /// 게시물 스크랩
    func postScrap(currentScrapStatus: Bool, targetPostId: Int,
                   completion: @escaping(GeneralResponse<PostScrapResponseDto>?) -> Void) {
        postProvider.request(.postScrap(currentScrapStatus: currentScrapStatus, targetPostId: targetPostId)) { result in
            switch result {
            case let .success(response):
                do {
                    self.scrapPost = try response.map(GeneralResponse<PostScrapResponseDto>.self)
                    guard let scrapPost = self.scrapPost else { return }
                    completion(scrapPost)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case let .failure(err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func createPost(borrow: Bool, category: String, content: String, duedate: String, photoUrl: String, title: String, completion: @escaping(GeneralResponse<VoidType>?) -> Void) {
        postProvider.request(.addPost(borrow: borrow, category: category, content: content, duedate: duedate, photoUrl: photoUrl, title: title)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(GeneralResponse<VoidType>.self)
                    completion(data)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    
    // MARK: - PATCH
    /// 게시물 상태 변경
    func patchUpdatePostStatus(postId: Int, status: Bool
                               , completion: @escaping(GeneralResponse<VoidType>?) -> Void) {
        postProvider.request(.postChangeStatus(postId: postId, status: status)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(GeneralResponse<VoidType>.self)
                    completion(data)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
    
