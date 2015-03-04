//
//  Server.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-23.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

// 服务器基础路径
let kServerBase = "http://www.oschina.net"

///
/// 更多模块
///
let kApiLoginValidate = "/action/api/login_validate"

///
/// 综合模块
///
let kApiBlogList = "/action/api/blog_list"
let kApiBlogDetail = "/action/api/blog_detail"
let kApiNewsList = "/action/api/news_list"
let kApiNewsDetail =  "/action/api/news_detail"

///
/// 问答模块
///
let kApiPostList = "/action/api/post_list"
let kApiPostDetail = "/action/api/post_detail"
let kApiPostPub = "/action/api/post_pub"
//#define api_tweet_list @"http://www.oschina.net/action/api/tweet_list"
//#define api_tweet_detail @"http://www.oschina.net/action/api/tweet_detail"
//#define api_tweet_delete @"http://www.oschina.net/action/api/tweet_delete"
//
//#define api_tweet_pub @"http://www.oschina.net/action/api/tweet_pub"
//#define api_software_tweet_pub @"http://www.oschina.net/action/api/software_tweet_pub"
//
//#define api_active_list @"http://www.oschina.net/action/api/active_list"
//#define api_message_list @"http://www.oschina.net/action/api/message_list"
//#define api_message_delete @"http://www.oschina.net/action/api/message_delete"
//#define api_message_pub @"http://www.oschina.net/action/api/message_pub"
//#define api_comment_list @"http://www.oschina.net/action/api/comment_list"
//#define api_comment_pub @"http://www.oschina.net/action/api/comment_pub"
//#define api_comment_reply @"http://www.oschina.net/action/api/comment_reply"
//#define api_comment_delete @"http://www.oschina.net/action/api/comment_delete"
//
//#define api_user_info @"http://www.oschina.net/action/api/user_info"
//#define api_user_information @"http://www.oschina.net/action/api/user_information"
//#define api_user_updaterelation @"http://www.oschina.net/action/api/user_updaterelation"
//#define api_notice_clear @"http://www.oschina.net/action/api/notice_clear"
//#define api_software_detail @"http://www.oschina.net/action/api/software_detail"

//#define api_favorite_list @"http://www.oschina.net/action/api/favorite_list"
//#define api_favorite_add @"http://www.oschina.net/action/api/favorite_add"
//#define api_favorite_delete @"http://www.oschina.net/action/api/favorite_delete"
//#define api_user_notice @"http://www.oschina.net/action/api/user_notice"
//#define api_search_list @"http://www.oschina.net/action/api/search_list"
//#define api_friends_list @"http://www.oschina.net/action/api/friends_list"
//#define api_softwarecatalog_list @"http://www.oschina.net/action/api/softwarecatalog_list"
//#define api_software_list @"http://www.oschina.net/action/api/software_list"
//#define api_softwaretag_list @"http://www.oschina.net/action/api/softwaretag_list"
//
//#define api_software_tweet_list @"http://www.oschina.net/action/api/software_tweet_list"
//
//#define api_blogcomment_list @"http://www.oschina.net/action/api/blogcomment_list"
//#define api_blogcomment_pub @"http://www.oschina.net/action/api/blogcomment_pub"
//#define api_my_information @"http://www.oschina.net/action/api/my_information"
//#define api_blogcomment_delete @"http://www.oschina.net/action/api/blogcomment_delete"
//#define api_userblog_delete @"http://www.oschina.net/action/api/userblog_delete"
//#define api_userblog_list @"http://www.oschina.net/action/api/userblog_list"

//#define api_userinfo_update @"http://www.oschina.net/action/api/portrait_update"
//#define api_report @"http://www.oschina.net/action/communityManage/report"