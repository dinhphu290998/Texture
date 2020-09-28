//
//  ICLoginViewController.swift
//  Texture_master
//
//  Created by NDPhu on 9/22/20.
//  Copyright © 2020 ios. All rights reserved.
//

import AsyncDisplayKit

class ICLoginViewController: ICBaseViewController {
    lazy var containerNode = initContainerNode()
    private var line1 = ASDisplayNode()
    private var line2 = ASDisplayNode()
    private var phonenumberEditText = TextFieldNode()
    private var passwordEditText = TextFieldNode()
    private var loginButton = ASButtonNode()
    private var supportNode = ASDisplayNode()
    private var forgetButton = ASButtonNode()
    private var supportButton = ASButtonNode()
    private var otherNode = ASDisplayNode()
    private var loginOTPButton = ASButtonNode()
    private var otherText = ASTextNode()
    private var loginFBButton = ASButtonNode()
    private var loginAppleButton = ASButtonNode()
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configAction()
    }
    
    //MARK: Init Node
    override func initRootNode() -> ASDisplayNode {
        let node = ASDisplayNode()
        node.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .start,
                                           alignItems: .stretch,
                                           children: [self.containerNode])
            return layout
        }
        containerNode.automaticallyManagesSubnodes = true
        supportNode.automaticallyManagesSubnodes = true
        otherNode.automaticallyManagesSubnodes = true
        return node
    }
    
    private func initContainerNode() -> ASDisplayNode {
        let node = ASScrollNode()
        node.view.showsVerticalScrollIndicator = false
        node.backgroundColor = .white
        node.automaticallyManagesContentSize = true
        
        var nodes = [ASLayoutElement]()
        nodes.append(self.phonenumberEditText)
        nodes.append(self.line1)
        nodes.append(self.passwordEditText)
        nodes.append(self.line2)
        nodes.append(self.loginButton)
        nodes.append(self.supportNode)
        nodes.append(self.loginOTPButton)
        nodes.append(self.otherNode)
        nodes.append(self.loginFBButton)
        nodes.append(self.loginAppleButton)
        
        node.layoutSpecBlock = { node, size in
            let layout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 20,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: nodes)
            return ASInsetLayoutSpec.init(insets: .init(top: 40, left: 60, bottom: 20, right: 60), child: layout)
        }
        
        layoutSubNode()
        
        return node
    }
    
    private func layoutSubNode() {
        
        line1.style.height = ASDimensionMake(1)
        line1.backgroundColor = UIColor.lightGray
        line2.style.height = ASDimensionMake(1)
        line2.backgroundColor = UIColor.lightGray
        
        phonenumberEditText.textfield.keyboardType = .numberPad
        phonenumberEditText.textfield.placeholder = "Nhập số điện thoại"
        phonenumberEditText.textfield.font = .systemFont(ofSize: 14)
        phonenumberEditText.textfield.textAlignment = .center
        phonenumberEditText.style.width = ASDimensionMake("100%")
        phonenumberEditText.style.height = ASDimensionMake(30)
        
        passwordEditText.textfield.isSecureTextEntry = true
        passwordEditText.textfield.placeholder = "Nhập mật khẩu"
        passwordEditText.textfield.font = .systemFont(ofSize: 14)
        passwordEditText.style.width = ASDimensionMake("100%")
        passwordEditText.style.height = ASDimensionMake(30)
        passwordEditText.textfield.textAlignment = .center
        
        loginButton.setTitle("Đăng nhập", with: .boldSystemFont(ofSize: 16), with: .white, for: .normal)
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.style.height = ASDimensionMake(40)
        loginButton.cornerRadius = 4
        loginButton.style.width = ASDimensionMake("100%")
        
        forgetButton.setTitle("Quên Mật Khẩu", with: .systemFont(ofSize: 12), with: UIColor.rgb(0x757575), for: .normal)
        let dot = ASTextNode()
        dot.attributedText = NSAttributedString.init(string: ".")
        supportButton.setTitle("Bạn gặp vấn đề về đăng nhập?", with: .systemFont(ofSize: 12), with: UIColor.rgb(0x757575), for: .normal)
        
        supportNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .horizontal, spacing: 5, justifyContent: .spaceBetween, alignItems: .stretch, children: [self.forgetButton,dot,self.supportButton])
            return layout
        }
        
        loginOTPButton.setTitle("Đăng nhập bằng OTP", with: .boldSystemFont(ofSize: 16), with: UIColor.rgb(0x057DDA), for: .normal)
        loginOTPButton.backgroundColor = .white
        loginOTPButton.borderColor = UIColor.rgb(0x057DDA).cgColor
        loginOTPButton.borderWidth = 1
        loginOTPButton.cornerRadius = 4
        loginOTPButton.style.height = ASDimensionMake(40)
        loginOTPButton.style.width = ASDimensionMake("100%")
        
        otherText.attributedText = NSAttributedString.init(string: "Hoặc đăng nhâp bằng", attributes: [.foregroundColor: UIColor.rgb(0x757575)])
        
        otherNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .horizontal, spacing: 10, justifyContent: .spaceBetween, alignItems: .stretch, children: [self.otherText])
            return layout
        }
        
        loginFBButton.borderWidth = 1
        loginFBButton.borderColor = UIColor.rgb(0x757575).cgColor
        loginFBButton.style.width = ASDimensionMake(160)
        loginFBButton.style.height = ASDimensionMake(40)
        loginFBButton.cornerRadius = 20
        loginFBButton.setImage(UIImage.init(named: "ic_facebook"), for: .normal)
        loginFBButton.setTitle("Facebook", with: .boldSystemFont(ofSize: 14), with: .black, for: .normal)
        
        loginAppleButton.borderWidth = 1
        loginAppleButton.borderColor = UIColor.rgb(0x757575).cgColor
        loginAppleButton.style.width = ASDimensionMake(160)
        loginAppleButton.style.height = ASDimensionMake(40)
        loginAppleButton.cornerRadius = 20
        loginAppleButton.setImage(UIImage.init(named: "ic_apple"), for: .normal)
        loginAppleButton.setTitle("Tài khoản Apple", with: .boldSystemFont(ofSize: 14), with: .black, for: .normal)
    }
    
    //MARK: Action
    private func configAction() {
        loginOTPButton.addTarget(self, action: #selector(tapLoginOTP), forControlEvents: .touchUpInside)
    }
    
    @objc func tapLoginOTP() {
        self.navigationController?.pushViewController(ICHomeManagerViewController(), animated: true)
    }
}

