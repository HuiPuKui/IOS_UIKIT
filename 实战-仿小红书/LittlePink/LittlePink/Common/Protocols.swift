//
//  Protocols.swift
//  LittlePink
//
//  Created by 惠蒲葵 on 2025/11/29.
//

import Foundation

protocol ChannelVCDelegate {
    
    /// 用户从选择话题页面返回编辑笔记页面传值用
    /// - Parameters:
    ///   - channel: 传回来的 channel
    ///   - subChannel: 传回来的 subChannel
    func updateChannel(channel: String, subChannel: String)
    
}

protocol POIVCDelegate {
    
    /// 用户从选择地址页面返回编辑笔记页面传值用
    /// - Parameter poiName: 传回来的 poiName
    func updatePOIName(_ poiName: String)
    
}

protocol IntroVCDelegate {
    
    /// 用户从个人简介页面返回个人页面传值用
    /// - Parameter intro: 传回来的 intro
    func updateIntro(_ intro: String)
    
}

protocol EditProfileTableVCDelegate {
    
    /// 更新用户信息（编辑个人资料回传）
    ///
    /// - Parameters:
    ///   - avatar: 用户头像（可选）
    ///   - nickName: 用户昵称
    ///   - gender: 性别（true = 男，false = 女，建议后续用 enum 更清晰）
    ///   - birth: 生日（可选）
    ///   - intro: 个人简介
    func updateUser(_ avatar: UIImage?, _ nickName: String, _ gender: Bool, _ birth: Date?, _ intro: String)
    
}
