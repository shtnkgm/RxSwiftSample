//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Shota Nakagami on 2017/09/18.
//  Copyright © 2017年 Shota Nakagami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = textField1.rx.text
            .flatMap { $0.flatMap(Observable.just) ?? Observable.empty() }
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        _ = textField2.rx.text
            .bind(to: label.rx.text)
        
        Observable
            .combineLatest(textField1.rx.text, textField2.rx.text) { "\($0) \($1)" }
            .sample(button.rx.tap)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

