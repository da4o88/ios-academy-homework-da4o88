//
//  AuthInfoData.swift
//  TV Show
//
//  Created by infinum on 29/07/2022.
//

import Foundation

final class AuthInfoData {
    static let shared = AuthInfoData()
    
    var user: User?
    var authInfo: AuthInfo?
    
    private init() {}
    
}
