//
//  EventAPI.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation

import Moya

final class EventAPI {
    static let shared: EventAPI = EventAPI()
    
    private let eventProvider = MoyaProvider<EventService>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var eventListData: GeneralArrayResponse<EventListResponseDto>?
    public private(set) var eventDetailData: GeneralResponse<EventDetailResponseDto>?
    
    // MARK: - GET
    func getEventList(completion: @escaping (GeneralArrayResponse<EventListResponseDto>?) -> Void) {
        eventProvider.request(.getEventList) { result in
            switch result {
            case .success(let response):
                do {
                    self.eventListData = try response.map(GeneralArrayResponse<EventListResponseDto>?.self)
                    guard let eventListData = self.eventListData else { return }
                    completion(eventListData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getEventDetail(eventId: Int, completion: @escaping (GeneralResponse<EventDetailResponseDto>?) -> Void) {
        eventProvider.request(.getEventDetail(eventId: eventId)) { result in
            switch result {
            case .success(let response):
                do {
                    self.eventDetailData = try response.map(GeneralResponse<EventDetailResponseDto>?.self)
                    guard let eventDetailData = self.eventDetailData else { return }
                    completion(eventDetailData)
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
    func postAddEvent(acceptCount: Int, content: String, dueDate: String, host: String, title: String, completion: @escaping(GeneralResponse<VoidType>?) -> Void) {
        eventProvider.request(.addEvent(acceptCount: acceptCount, content: content, dueDate: dueDate, host: host, title: title)) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(GeneralResponse<VoidType>.self)
                    completion(data)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case let .failure(err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func postApplyEvent(eventId: Int, completion: @escaping(GeneralResponse<VoidType>?) -> Void) {
        eventProvider.request(.applyEvent(eventId: eventId)) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(GeneralResponse<VoidType>.self)
                    completion(data)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case let .failure(err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
