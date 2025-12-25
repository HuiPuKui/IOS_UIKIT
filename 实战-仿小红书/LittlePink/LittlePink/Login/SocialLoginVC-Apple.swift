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
            
            var name = ""
            if appleIDCredential.fullName?.familyName != nil || appleIDCredential.fullName?.givenName != nil {
                let familyName = appleIDCredential.fullName?.familyName ?? ""
                let givenName = appleIDCredential.fullName?.givenName ?? ""
                name = "\(familyName)\(givenName)"
                
                UserDefaults.standard.setValue(name, forKey: kNameFromAppleID)
            } else {
                name = UserDefaults.standard.string(forKey: kNameFromAppleID) ?? ""
            }
            
            var email = ""
            if let unwrappedEmail = appleIDCredential.email {
                email = unwrappedEmail
                
                UserDefaults.standard.setValue(email, forKey: kEmailFromAppleID)
            } else {
                email = UserDefaults.standard.string(forKey: kEmailFromAppleID) ?? ""
            }
            
            guard
                let identityToken = appleIDCredential.identityToken,
                let authorizationCode = appleIDCredential.authorizationCode
            else { return }
            
            print(String(decoding: identityToken, as: UTF8.self))
            print(String(decoding: authorizationCode, as: UTF8.self))
            
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
