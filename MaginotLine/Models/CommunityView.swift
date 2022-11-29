//
//  CommunityView.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/29.
//

import Foundation

struct Community{
    var boardImg:String
    var boardNum:Int
    var boardName:String
}

let communities:[String:[Community]]
= [
    
    "커뮤니티":[Community(
        boardImg: "line1com",
        boardNum: 1, boardName: "1호선"),
            Community(
                boardImg: "line2com",
                boardNum: 2, boardName: "2호선"),Community(
                    boardImg: "line3com",
                    boardNum: 3, boardName: "3호선"),
            Community(
                boardImg: "line4com",
                boardNum: 4, boardName: "4호선"),
            Community(
                boardImg: "line5com",
                boardNum: 5, boardName: "5호선"),
            Community(
                boardImg: "line6com",
                boardNum: 6, boardName: "6호선"),
            Community(
                boardImg: "line7com",
                boardNum: 7, boardName: "7호선"),
            Community(
                boardImg: "line8com",
                boardNum: 8, boardName: "8호선"),
            Community(
                boardImg: "line9com",
                boardNum: 9, boardName: "9호선"),
            Community(
                boardImg: "ectlinecom",
                boardNum: 10, boardName: "기타호선")
    ]
]
