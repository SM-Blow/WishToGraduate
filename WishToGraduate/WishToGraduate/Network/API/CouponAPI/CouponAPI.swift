//
//  CouponAPI.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/10/04.
//

import Foundation
import Moya

final class CouponAPI {
    
    static let shared: CouponAPI = CouponAPI()
    
    private let couponProvider = MoyaProvider<CouponService>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    public private(set) var couponListData: GeneralResponse<CouponListResponseDto>?
    
    // MARK: - GET
    func getCouponList(completion: @escaping (GeneralResponse<CouponListResponseDto>?) -> Void) {
        couponProvider.request(.couponList) { result in
            switch result {
            case .success(let response):
                do {
                    self.couponListData = try response.map(GeneralResponse<CouponListResponseDto>?.self)
                    guard let couponListData = self.couponListData else { return }
                    completion(couponListData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - POST
    func postCouponAdd(storeName: String, content: String, dueDate: String, couponCode: String, completion: @escaping(GeneralResponse<VoidType>?) -> Void) {
            couponProvider.request(.couponAdd(storeName: storeName, content: content, dueDate: dueDate, couponCode: couponCode)) { result in
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
    
    func postCouponUse(id: Int, completion: @escaping(GeneralResponse<VoidType>?) -> Void) {
        couponProvider.request(.couponUse(id: id)) { result in
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
