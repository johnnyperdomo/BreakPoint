//
//  Group.swift
//  BreakPoint
//
//  Created by Johnny Perdomo on 4/18/18.
//  Copyright © 2018 Johnny Perdomo. All rights reserved.
//

import Foundation

//a group model

class Group {
    //these are the things a Group needs; all groups made will have the same structure
    private var _groupTitle: String
    private var _groupDesc: String
    private var _key: String //a unique key id
    private var _memberCount: Int
    private var _members: [String]
    
    //public variables to access private variables
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDesc: String {
        return _groupDesc
    }
    
    var key: String {
        return _key
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, description: String, key: String, memberCount: Int, members: [String]) {
        self._groupTitle = title
        self._groupDesc = description
        self._key = key
        self._memberCount = memberCount
        self._members = members
    }
}
