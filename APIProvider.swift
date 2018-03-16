//
//  APIProvider.swift
//  
//
//  Created by 原野誉大 on 2018/03/16.
//

import Foundation
import Moya
import RxSwift

public enum API {
    case zen
}

extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .zen:
            return "/zen"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .zen:
            return "[{\"message\":\"test1\"},{\"message\":\"test2\"}]".data(using:String.Encoding.utf8)!
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
}

