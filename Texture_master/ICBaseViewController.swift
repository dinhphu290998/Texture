//
//  ICBaseViewController.swift
//  Texture_master
//
//  Created by NDPhu on 9/21/20.
//  Copyright © 2020 ios. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ICBaseViewController: UIViewController {
    lazy var rootNode = initRootNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubnode(rootNode)
        rootNode.backgroundColor = .clear
        rootNode.automaticallyManagesSubnodes = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         rootNode.frame = view.bounds
    }
    
    func initRootNode() -> ASDisplayNode {
        return ASDisplayNode()
    }
}
