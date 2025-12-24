//
//  SocialLoginVC-Apple.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/25.
//

import AuthenticationServices

extension SocialLoginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userID = appleIDCredential.user
            
            print(appleIDCredential.fullName?.familyName)
            print(appleIDCredential.fullName?.givenName)
            print(appleIDCredential.email)
            
            print(String(decoding: appleIDCredential.identityToken!, as: UTF8.self))
            print(String(decoding: appleIDCredential.authorizationCode!, as: UTF8.self))
        case let passwordCredential as ASPasswordCredential:
            print(passwordCredential)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("苹果登录失败: \(error)")
    }
    
}

extension SocialLoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
