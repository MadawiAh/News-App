//
//  NetworkConnectivity.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 10/02/1444 AH.
//
import Alamofire

class NetworkConnectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
