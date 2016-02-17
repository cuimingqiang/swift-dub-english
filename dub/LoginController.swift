//
//  ViewController.swift
//  dub
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import Alamofire
class LoginController: UIViewController {

    lazy var navigation = UINavigationBar.init()
    lazy var mobile = UITextField.init()
    lazy var password = UITextField.init()
    lazy var scrollView = UIScrollView.init()
    lazy var login = UIButton.init()
    
    let bag = DisposeBag.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0xef/0xff, green: 0xef/0xff, blue: 0xef/0xff, alpha: 1.0)
        initNav()
        initContainer()
        initInput()
        initLogin()
        print(UIScreen.mainScreen().bounds)
    }
    
    override func viewDidAppear(animated: Bool) {
//        gotoMain()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoMain(){
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MainTabController") as! MainTabController
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
extension LoginController{
    func initNav(){
        let title = UINavigationItem.init(title: "登陆")
        navigation.pushNavigationItem(title, animated: false)
        self.view.addSubview(navigation)
        navigation.snp_makeConstraints{
            $0.width.equalTo(view)
            $0.height.equalTo(64)
            $0.centerX.equalTo(view)
        }
    }
}
extension LoginController{
    func initContainer(){
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints {
            $0.top.equalTo(80)
            $0.width.equalTo(view)
            $0.height.equalTo(view)
        }
    }
}
extension LoginController{
    func initInput(){
        let container = UIView.init()
        container.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(container)
        container.snp_makeConstraints {
            $0.top.equalTo(scrollView)
            $0.centerX.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.equalTo(89)
        }
        mobile.text = "18957107621"
        mobile.clearButtonMode = UITextFieldViewMode.WhileEditing
        mobile.keyboardType = UIKeyboardType.NamePhonePad
        container.addSubview(mobile)
        mobile.snp_makeConstraints {
            $0.top.equalTo(container)
            $0.centerX.equalTo(container)
            $0.leftMargin.equalTo(10)
            $0.height.equalTo(44)
        }
        let line = UIView.init()
        line.backgroundColor = UIColor.init(red: 0xef/0xff, green: 0xef/0xff, blue: 0xef/0xff, alpha: 1.0)
        container.addSubview(line)
        line.snp_makeConstraints {
            $0.center.equalTo(container)
            $0.height.equalTo(1)
            $0.leftMargin.equalTo(10.0)
        }
        
        password.text = "cmq123456"
        password.clearButtonMode = UITextFieldViewMode.WhileEditing
        container.addSubview(password)
        password.snp_makeConstraints {
            $0.bottom.equalTo(container)
            $0.height.equalTo(44)
            $0.centerX.equalTo(container)
            $0.leftMargin.equalTo(10)
        }
        Observable.combineLatest(mobile.rx_text, password.rx_text) {
            return (!$0.isEmpty) && (!$1.isEmpty)
        }.subscribeNext {
            self.login.enabled = $0
        }.addDisposableTo(bag)
    }
}
extension LoginController{
    func initLogin(){
        login.setTitle("登陆", forState: UIControlState.Normal)
        login.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        login.backgroundColor = UIColor.greenColor()
        login.layer.cornerRadius = 5
        scrollView.addSubview(login)
        login.snp_makeConstraints{
            $0.top.equalTo(password.snp_bottom).offset(20)
            $0.height.equalTo(44)
            $0.centerX.equalTo(scrollView)
            $0.leftMargin.equalTo(10)
        }
        login.rx_controlEvent(UIControlEvents.TouchDown)
        .subscribeNext {
            self.login.backgroundColor = UIColor.grayColor()
        }.addDisposableTo(bag)
        login.rx_controlEvent(UIControlEvents.TouchUpInside)
            .subscribeNext{
            self.login.backgroundColor = UIColor.greenColor()
            self.login.enabled = false
            self.doLogin()
        }.addDisposableTo(bag)
    }

    func doLogin(){
        API.login(mobile: mobile.text!, password: password.text!)
            .subscribeOn(Schedulers.IO())
            .observeOn(Schedulers.MainScheduler())
            .subscribe {
                switch $0{
                case Event.Completed:
                    self.login.enabled = true
                case let Event.Next(data):
                    print(data.mj_JSONString())
                    RxBus.postEvent(data)
                    self.gotoMain()
                    return
                case let Event.Error(e):
                    self.login.enabled = true
                    print(e)
                }
            }.addDisposableTo(bag)
    }
}