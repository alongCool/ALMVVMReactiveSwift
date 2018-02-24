//
//  ALRequestAPI.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/22.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//

import Foundation
import Result
import Moya

enum RequestAPI {
    case login(account: String, password: String)
    case registerSecurity(account: String, newPassword: String, code: String)
    case getCode(account: String)
}

extension RequestAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://106.14.169.84/")!
    }
    
    var path: String {
        switch self {
        case .login(_,_):
            return "/mobile/api/security/v1/login"
        case .registerSecurity(_,_,_):
            return "/mobile/api/security/v1/registerSecurity"
        case .getCode(_):
            return "/mobile/api/system/v1/sendMessageCode"
        }
    }
    
    var task: Task {
        switch self {
        case .login(let account, let password):
            return .requestParameters(parameters: ["phone" : account, "password" : password], encoding: URLEncoding.queryString)
        case .registerSecurity(let account,let newPassword,let code):
            return .requestParameters(parameters: ["phone" : account, "password" : newPassword, "messageCode" : code], encoding: URLEncoding.queryString)
        case .getCode(let account):
            return .requestParameters(parameters: ["phone" : account], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        return nil
    }
    
}

public final class customRequestPlugin: PluginType {

    /// Called immediately before a request is sent over the network (or stubbed).
    public func willSend(_ request: RequestType, target: TargetType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        print("*--------------------------Request--------------------------*")
        print(target.baseURL.absoluteString + target.path)
        print("*Method:")
        print(target.method)
        print("*Parameters:")
        print(target.task)
        print("*Header:")
        print(target.headers ?? "")
        print("*--------------------------------------------------------------*")
    }
    
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("*---------------------------Response---------------------------*")

        switch result {
        case .success(let response):
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: response.data, options: .mutableLeaves)
                let prettyData =  try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                print(String(data: prettyData, encoding: .utf8) ?? "")
            } catch {
                print(error)
            }
        case .failure(let error):
            print(error)
        }
        print("*-------------------------------------------------------------*")

    }

}

struct ALRequestAPI {
    static func sharedInstance() -> MoyaProvider<RequestAPI> {
        return MoyaProvider<RequestAPI>(plugins: [customRequestPlugin()])
    }
}
