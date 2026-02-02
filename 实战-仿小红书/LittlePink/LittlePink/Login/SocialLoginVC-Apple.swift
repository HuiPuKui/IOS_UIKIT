//
//  SocialLoginVC-Apple.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/25.
//

import AuthenticationServices
import LeanCloud

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
            
            let appleData: [String: Any] = [
                "uid": userID,
                "identity_token": String(decoding: identityToken, as: UTF8.self),
                "code": String(decoding: authorizationCode, as: UTF8.self)
            ]
            
            let user = LCUser()
            user.logIn(authData: appleData, platform: .apple) { (result) in
                switch result {
                case .success:
//                    assert(user.objectId != nil)
                    self.configAfterLogin(user, name, email)
                case .failure(error: let error):
                    DispatchQueue.main.async {
                        self.showTextHUD("登录失败", in: self.parent!.view, error.reason)
                    }
                }
            }
            
        case let passwordCredential as ASPasswordCredential:
            let _ = passwordCredential.user
            let _ = passwordCredential.password
            
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

extension SocialLoginVC {
    
    func checkSignInWithAppleState(with userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("用户已登录, 展示登录后的 UI 页面")
            case .revoked:
                print("用户已从设置里面退出登录或用其他的 AppleID 进行登录了")
            case .notFound:
                print("无此用户")
            case .transferred:
                print("Apple ID 凭据被“迁移/转移”")
            @unknown default:
                break
            }
        }
    }
    
}
