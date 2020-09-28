//
//  ICAuthViewController.swift
//  Texture_master
//
//  Created by NDPhu on 9/21/20.
//  Copyright © 2020 ios. All rights reserved.
//
import AsyncDisplayKit
import RxSwift
import RxCocoa

class ICAuthViewController: ICBaseViewController {
    //MARK: Node
    private var backgroundNode = ASDisplayNode()
    private var headerImageNode = ASImageNode()
    private var foregroundNode = ASDisplayNode()
    private var closeButtonNode = ASButtonNode()
    private var logoImageNode = ASImageNode()
    private var loginButtonNode = ASButtonNode()
    private var registerButtonNode = ASButtonNode()
    private var containerNode = ContainerNode()
    
    //MARK: Variable
    private var isFirstLayout: Bool = true
    
    //MARK: Child ViewController
    let loginVC = ICLoginViewController()
    let signupVC = ICRegisterViewController()
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initContainNode()
        configAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Init Node
    private func initContainNode() {
        backgroundNode.automaticallyManagesSubnodes = true // tự động add nodes
        foregroundNode.automaticallyManagesSubnodes = true // tự động add nodes
        
        rootNode.layoutSpecBlock = { [unowned self] node, size in
            // tạo View background và View foreground đè lên background sử dụng ASOverlayLayoutSpec
            let layout = ASOverlayLayoutSpec.init(child: self.backgroundNode, overlay: self.foregroundNode)
            return layout
        }
        layoutSubNode()
    }
    
    private func layoutSubNode() {
        //Tạo ảnh header trên View background sử dụng ASStackLayoutSpec
        headerImageNode.image = UIImage.init(named: "img_header_login")
        backgroundNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .start,
                                           alignItems: .stretch,
                                           children: [self.headerImageNode])
            return layout
        }
        
        //Tạo header View và action View trên foreground sử dụng ASStackLayoutSpec
        //B1: Tạo header View chứa button close và logo
        let headerNode = ASDisplayNode()
        headerNode.automaticallyManagesSubnodes = true
        
        closeButtonNode.imageNode.style.preferredSize = CGSize.init(width: 24, height: 24)
        closeButtonNode.setImage(UIImage.init(named: "ic_close"), for: .normal)
        
        logoImageNode.image = UIImage.init(named: "img_logo_login")
        logoImageNode.style.flexBasis = ASDimensionMake("25%")
        let spaceNode = ASDisplayNode()
        spaceNode.style.preferredSize = CGSize.init(width: 24, height: 24)
        
        let headerLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .spaceBetween, alignItems: .start, children: [self.closeButtonNode,self.logoImageNode,spaceNode])
        headerNode.layoutSpecBlock = { node, size in
            return ASInsetLayoutSpec.init(insets: .init(top: 45, left: 10, bottom: 0, right: 10), child: headerLayout)
        }
        
        //B2 Tạo action View chứa button Login , Register
        let actionNode = ASDisplayNode()
        actionNode.automaticallyManagesSubnodes = true
        
        loginButtonNode.setTitle("Đăng Nhập", with: .boldSystemFont(ofSize: 16), with: UIColor.white.withAlphaComponent(0.5), for: .normal)
        loginButtonNode.setTitle("Đăng Nhập", with: .boldSystemFont(ofSize: 18), with: UIColor.white, for: .selected)
        loginButtonNode.isSelected = true
        loginButtonNode.isEnabled = false
        
        registerButtonNode.setTitle("Đăng Ký", with: .boldSystemFont(ofSize: 16), with: UIColor.white.withAlphaComponent(0.5), for: .normal)
        registerButtonNode.setTitle("Đăng Ký", with: .boldSystemFont(ofSize: 18), with: UIColor.white, for: .selected)
        registerButtonNode.isSelected = false
        
        actionNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec(direction: .horizontal, spacing: 60, justifyContent: .center, alignItems: .stretch, children: [self.loginButtonNode,self.registerButtonNode])
            return layout
        }
        actionNode.style.height = ASDimensionMake(30)
        
        //B3 Thêm header View , action View, container View vào foreground View
        self.containerNode.style.flexShrink = 1
        self.containerNode.style.flexGrow = 1
        self.containerNode.backgroundColor = .white
        
        foregroundNode.layoutSpecBlock = { node, size in
            let layout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 15,
                                            justifyContent: .start,
                                            alignItems: .stretch,
                                            children: [headerNode,actionNode,self.containerNode])
            return layout
        }
                
        self.containerNode.layoutDidFinishBlock = { [unowned self] in
            self.containerNode.corner([.topLeft,.topRight], radius: 20)
            if self.isFirstLayout {
                self.addWithAnimation(childViewController: self.loginVC, sourceView: self.containerNode.view, fromRight: false)
                self.isFirstLayout = false
            }
            
        }
    }
    
    //MARK: Action
    private func configAction() {
        loginButtonNode.addTarget(self, action: #selector(tapLogin), forControlEvents: .touchUpInside)
        registerButtonNode.addTarget(self, action: #selector(tapRegister), forControlEvents: .touchUpInside)
    }
    @objc func tapLogin() {
        changeStatusButton(isSelectedLogin: true)
    }
    @objc func tapRegister() {
        changeStatusButton(isSelectedLogin: false)
    }
    private func changeStatusButton(isSelectedLogin: Bool) {
        loginButtonNode.isSelected = isSelectedLogin
        loginButtonNode.isEnabled = !isSelectedLogin
        registerButtonNode.isSelected = !isSelectedLogin
        registerButtonNode.isEnabled = isSelectedLogin
        if isSelectedLogin {
            self.removeWithAnimation(childViewController: self.signupVC)
            self.addWithAnimation(childViewController: self.loginVC, sourceView: self.containerNode.view, fromRight: false)
        } else {
            self.removeWithAnimation(childViewController: self.loginVC, fromRight: false)
            self.addWithAnimation(childViewController: signupVC, sourceView: self.containerNode.view)
        }
    }
    
}

