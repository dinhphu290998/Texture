//
//  ICRegisterViewController.swift
//  Texture_master
//
//  Created by NDPhu on 9/23/20.
//  Copyright © 2020 ios. All rights reserved.
//

import AsyncDisplayKit

class ICRegisterViewController: ICBaseViewController {
    lazy var containerNode = ASDisplayNode()
    private var titleText = ASTextNode()
    
    private var locationNode = ASDisplayNode()
    private var locationText = ASTextNode()
    private var leftIcon = ASImageNode()
    private var selectLocationButton = ASButtonNode()
    
    private var areaCodeNode = ASDisplayNode()
    private var selectAreaCodeButton = ASButtonNode()
    
    private var phonenumberNode = ASDisplayNode()
    private var phonenumberEditText = TextFieldNode()

    private var passwordNode = ASDisplayNode()
    private var passwordEditText = TextFieldNode()
    
    private var confirmPasswordNode = ASDisplayNode()
    private var confirmPasswordEditText = TextFieldNode()
    
    private var nextButton = ASButtonNode()
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    //MARK: Init Node
    let node = ASDisplayNode()
    override func initRootNode() -> ASDisplayNode {
        node.automaticallyManagesSubnodes = true
        containerNode.automaticallyManagesSubnodes = true
        locationNode.automaticallyManagesSubnodes = true
        phonenumberNode.automaticallyManagesSubnodes = true
        areaCodeNode.automaticallyManagesSubnodes = true
        passwordNode.automaticallyManagesSubnodes = true
        confirmPasswordNode.automaticallyManagesSubnodes = true
        layoutSubNode()
        return node
    }
    
    private func layoutSubNode() {
        titleText.attributedText = NSAttributedString.init(string: "Đăng kí tài khoản", attributes: [.font: UIFont.boldSystemFont(ofSize: 20)])
        //Location
        locationText.attributedText = NSAttributedString.init(string: "Việt Nam", attributes: [.foregroundColor: UIColor.rgb(0x057DDA) ,.font: UIFont.boldSystemFont(ofSize: 20)])
        locationText.style.flexGrow = 1
        locationText.style.flexShrink = 1
        
        leftIcon.image = UIImage.init(named: "ic_arrow_right_gray_24px")
        leftIcon.style.preferredSize = CGSize.init(width: 24, height: 24)
        
        let contentLocation = ASDisplayNode()
        contentLocation.automaticallyManagesSubnodes = true
        contentLocation.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .stretch, children: [self.locationText,self.leftIcon])
            return layout
        }

        let lineLocation = ASDisplayNode()
        lineLocation.style.height = ASDimensionMake(1)
        lineLocation.style.width = ASDimensionMake("100%")
        lineLocation.backgroundColor = UIColor.lightGray
        
        let containerLocationNode = ASDisplayNode()
        containerLocationNode.automaticallyManagesSubnodes = true
        containerLocationNode.layoutSpecBlock = { node, size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [contentLocation,lineLocation])
            return layout
        }
        
        selectLocationButton.backgroundColor = .clear
        locationNode.style.width = ASDimensionMake("100%")
        locationNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASOverlayLayoutSpec.init(child: containerLocationNode, overlay: self.selectLocationButton)
            return layout
        }
    
        //Area Code
        selectAreaCodeButton.setTitle("+84", with: .boldSystemFont(ofSize: 25), with: .gray, for: .normal)
        selectAreaCodeButton.style.height = ASDimensionMake(40)
        
        let lineAreaCode = ASDisplayNode()
        lineAreaCode.style.height = ASDimensionMake(1)
        lineAreaCode.style.width = ASDimensionMake("100%")
        lineAreaCode.backgroundColor = UIColor.lightGray
        
        areaCodeNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [self.selectAreaCodeButton,lineAreaCode])
            return layout
        }
        areaCodeNode.style.preferredSize = CGSize.init(width: 50, height: 50)
        
        //PhoneNumber
        phonenumberEditText.textfield.keyboardType = .numberPad
        phonenumberEditText.textfield.textAlignment = .center
        phonenumberEditText.style.width = ASDimensionMake("100%")
        phonenumberEditText.style.height = ASDimensionMake(40)
        phonenumberEditText.textfield.font = .systemFont(ofSize: 25)
        phonenumberEditText.textfield.attributedPlaceholder = NSAttributedString.init(string: "Nhập số điện thoại", attributes: [.foregroundColor: UIColor.lightGray])
        
        let linePhoneNumber = ASDisplayNode()
        linePhoneNumber.style.height = ASDimensionMake(1)
        linePhoneNumber.style.width = ASDimensionMake("100%")
        linePhoneNumber.backgroundColor = UIColor.lightGray

        phonenumberNode.style.flexGrow = 1
        phonenumberNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [self.phonenumberEditText,linePhoneNumber])
            return layout
        }
         //Container Input NumberPhone
        let containerInputPhone = ASDisplayNode()
        containerInputPhone.style.height = ASDimensionMake(50)
        containerInputPhone.style.width = ASDimensionMake("100%")
        containerInputPhone.automaticallyManagesSubnodes = true
        containerInputPhone.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [self.areaCodeNode,self.phonenumberNode])
            return layout
        }

        //Password
        passwordEditText.textfield.placeholder = "Nhập mật khẩu"
        passwordEditText.textfield.font = .systemFont(ofSize: 16)
        passwordEditText.style.height = ASDimensionMake(30)
        passwordEditText.style.width = ASDimensionMake("100%")
        passwordEditText.textfield.isSecureTextEntry = true
        
        let linePassword = ASDisplayNode()
        linePassword.style.height = ASDimensionMake(1)
        linePassword.style.width = ASDimensionMake("100%")
        linePassword.backgroundColor = UIColor.lightGray
        
        passwordNode.automaticallyManagesSubnodes = true
        passwordNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [self.passwordEditText,linePassword])
            return layout
        }
        
        //RetypePassword
        confirmPasswordEditText.textfield.placeholder = "Nhập lại mật khẩu"
        confirmPasswordEditText.textfield.font = .systemFont(ofSize: 16)
        confirmPasswordEditText.style.height = ASDimensionMake(30)
        confirmPasswordEditText.style.width = ASDimensionMake("100%")
        confirmPasswordEditText.textfield.isSecureTextEntry = true
        
        let lineRetypePassword = ASDisplayNode()
        lineRetypePassword.style.height = ASDimensionMake(1)
        lineRetypePassword.style.width = ASDimensionMake("100%")
        lineRetypePassword.backgroundColor = UIColor.lightGray
        
        confirmPasswordNode.automaticallyManagesSubnodes = true
        confirmPasswordNode.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [self.confirmPasswordEditText,lineRetypePassword])
            return layout
        }
        
        //Container Node
        containerNode.layoutSpecBlock = { [unowned self] node,size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .center, children: [self.titleText,self.locationNode,containerInputPhone,self.passwordNode,self.confirmPasswordNode])
            return layout
        }
        
        nextButton.style.height = ASDimensionMake(40)
        nextButton.setTitle("Tiếp tục", with: .systemFont(ofSize: 14), with: .white, for: .normal)
        nextButton.backgroundColor = .lightGray
        nextButton.cornerRadius = 4
        
        //Super Node
        node.layoutSpecBlock = { [unowned self] node, size in
            let layout = ASStackLayoutSpec.init(direction: .vertical, spacing: 0, justifyContent: .spaceBetween, alignItems: .stretch, children: [self.containerNode, self.nextButton])
            return ASInsetLayoutSpec.init(insets: .init(top: 30, left: 30, bottom: 10, right: 30), child: layout)
        }
    }
}
