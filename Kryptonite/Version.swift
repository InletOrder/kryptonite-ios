//
//  Version.swift
//  Kryptonite
//
//  Created by Alex Grinman on 10/25/16.
//  Copyright © 2016 KryptCo. All rights reserved.
//

import Foundation

struct InvalidVersionStringError:Error{}

class Version: Comparable {
    let major:UInt
    let minor:UInt
    let patch:UInt
    
    init(major:UInt, minor:UInt, patch:UInt) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    //MARK: Comparisons
    
    func isMajorUpgrade(from version:Version) -> Bool {
        return self.major > version.major
    }
    
    //MARK: To/From String
    init(string:String) throws {
        let versionComponents = string.components(separatedBy: ".")
        
        guard versionComponents.count == 3 else {
            throw InvalidVersionStringError()
        }
        
        guard   let major = UInt(versionComponents[0]),
                let minor = UInt(versionComponents[1]),
                let patch = UInt(versionComponents[2])
        else {
            throw InvalidVersionStringError()
        }
        
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    
    var string:String {
        return "\(major).\(minor).\(patch)"
    }
}

func < (lhs:Version, rhs:Version) -> Bool {
    if lhs.major < rhs.major {
        return true
    }
    
    if  lhs.major == rhs.major &&
        lhs.minor < rhs.minor
    {
        return true
    }
    
    if  lhs.major == rhs.major &&
        lhs.minor == rhs.minor &&
        lhs.patch < rhs.patch
    {
        return true
    }
    
    return false
}

func ==(lhs:Version, rhs:Version) -> Bool {
    return  lhs.major == rhs.major &&
            lhs.minor == rhs.minor &&
            lhs.patch == rhs.patch
}



