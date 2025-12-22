//
//  SocialLoginVC-Alipay.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/12/21.
//

import Alamofire
import Foundation

extension SocialLoginVC {
    //集成或使用时遇到问题可点右边的智能在线,若无答案,之后可请求人工. 注:直接搜问题基本搜不到
    
    // MARK: 1.支付宝登录大体流程:
    //https://opendocs.alipay.com/open/218/105329
    //跳至支付宝App或H5页面--用户点同意--我们获得authCode--用authCode跟支付宝换token--获取后可直接登录或继续获取其他信息并登录
    //可获取支付宝用户的基本开放信息（用户ID、用户头像、昵称、性别、省份、城市等六个字段）
    
    // MARK: 2.接入准备
    //https://opendocs.alipay.com/open/218/105326
    
    // MARK: 3.集成并配置完整版SDK
    //https://opendocs.alipay.com/open/204/105295
    
    // MARK: 4.调用接口
    //https://opendocs.alipay.com/open/218/105325
    
    func signInWithAlipay() {
        let infoStr = "apiname=com.alipay.account.auth&app_id=\(kAliPayAppID)&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=\(kAliPayPID)&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20210122"
        
        guard
            let signer = APRSASigner(privateKey: kAlipayPrivateKey),
            let signedStr = signer.sign(infoStr, withRSA2: true)
        else { return }
        
        let authInfoStr = "\(infoStr)&sign=\(signedStr)"
        
        // 发起支付宝登录请求
        AlipaySDK.defaultService().auth_V2(withInfo: authInfoStr, fromScheme: kAppScheme) { res in
            guard let res = res else { return }
            
            let resultStatus = res["resultStatus"] as! String
            if resultStatus == "9000" {
                let resultStr = res["result"] as! String
                let resultArr = resultStr.components(separatedBy: "&")
                
                for subRes in resultArr {
                    let equalIndex = subRes.firstIndex(of: "=")!
                    let equalEndIndex = subRes.index(after: equalIndex)
                    let suffix = subRes[equalEndIndex...]
                    
                    if subRes.hasPrefix("auth_code") {
                        var parameters = [
                            "timestamp": Date().format(with: "yyyy-MM-dd HH:mm:ss"),
                            "method": "alipay.system.oauth.token",
                            "app_id": kAliPayAppID,
                            "sign_type": "RSA2",
                            "version": "1.0",
                            "charset": "utf-8",
                            "grant_type": "authorization_code",
                            "code": String(suffix)
                        ]
                        
                        // 拼接为表单形式
                        let urlParameters = parameters.map { "\($0)=\($1)" }.sorted().joined(separator: "&")
                        guard
                            let signer = APRSASigner(privateKey: kAlipayPrivateKey),
                            let signedStr = signer.sign(urlParameters, withRSA2: true)
                        else { return }
                        
                        parameters["sign"] = signedStr.removingPercentEncoding ?? signedStr
                        
                        AF.request("https://openapi.alipay.com/gateway.do", parameters: parameters).responseJSON { res in
                            
                        }
                    }
                }
            }
        }
    }
}
