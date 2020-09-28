//
//  CustomizeNode.swift
//  Texture_master
//
//  Created by NDPhu on 9/23/20.
//  Copyright © 2020 ios. All rights reserved.
//

import AsyncDisplayKit

class ContainerNode: ASDisplayNode {
    var layoutDidFinishBlock: (() -> Void)?
    override func layoutDidFinish() {
        super.layoutDidFinish()
        self.layoutDidFinishBlock?()
    }
}

class TextFieldNode: ASDisplayNode {
    var textfield = UITextField()
    
    var contentNode: ASDisplayNode!
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        contentNode = ASDisplayNode(viewBlock: { [unowned self ] () -> UIView in
            return self.textfield
        })
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        contentNode.style.flexGrow = 1
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [contentNode])
    }
}

