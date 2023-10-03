//
//  GeneralResponse.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/04.
//

import Foundation

struct GeneralResponse<T: Decodable>: Decodable {
    var success: Bool
    var message: String
    var data: T?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = (try? values.decode(Bool.self, forKey: .success)) ?? true
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
