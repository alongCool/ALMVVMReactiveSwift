//
//  SignalProducer+EVReflectable.swift
//  bbxServerSwift
//
//  Created by xlshi on 2017/12/23.
//  Copyright © 2017年 kuanyinjeji. All rights reserved.
//
import EVReflection
import ReactiveSwift
import Moya

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension SignalProducerProtocol where Value == Moya.Response, Error == MoyaError {
    
    /// Maps data received from the signal into an object which implements the Mappable protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: NSObject>(to type: T.Type, forKeyPath: String? = nil) -> SignalProducer<T, Error> where T: EVReflectable {
        return producer.flatMap(.latest) { response -> SignalProducer<T, Error> in
            return SignalProducer(value: T(data: response.data, forKeyPath: forKeyPath))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Mappable
    /// protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: NSObject>(toArray type: T.Type, forKeyPath: String? = nil) -> SignalProducer<[T], Error> where T: EVReflectable {
        return producer.flatMap(.latest) { response -> SignalProducer<[T], Error> in
            return SignalProducer(value: [T](data: response.data, forKeyPath: forKeyPath))
        }
    }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(_ throwable: () throws -> T) -> SignalProducer<T, Moya.MoyaError> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! Moya.MoyaError)
    }
}
