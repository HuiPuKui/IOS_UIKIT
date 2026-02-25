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
