//
//  ICHomeManagerViewController.swift
//  Texture_master
//
//  Created by NDPhu on 9/23/20.
//  Copyright © 2020 ios. All rights reserved.
//

import AsyncDisplayKit

class ICHomeManagerViewController: ICBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
        title = "Danh sách Sản Phẩm"
    }
    
    override func initRootNode() -> ASDisplayNode {
        let node = ASDisplayNode()
        node.backgroundColor = .red
        return node
    }
}
