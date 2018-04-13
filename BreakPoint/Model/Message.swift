//
//  MessageModel.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/12/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import Foundation

//a message model

class Message {
    private var _content: String //only we can set them here.
    private var _senderId: String
    
    //public variables that access the private variables
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) { //access only through the initializer
        self._content = content //encapsulate data and hide it; '_content' can only be accessed through here.
        self._senderId = senderId
    }
    
}
