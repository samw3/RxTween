//
//  ViewController.swift
//  RxTween
//
//  Created by samw3 on 04/10/2019.
//  Copyright (c) 2019 samw3. All rights reserved.
//

import UIKit
import RxSwift
import RxTween
import RxDisplayLink

class ViewController: UIViewController {

    @IBOutlet var box: UIView?
    var bag = DisposeBag()

    func animate() -> Observable<CGFloat> {
        return CADisplayLink.rx.link().scan(0) { frame, _ in frame + 1.0 }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let box = self.box {
            let startFrame = box.frame

            // Tween opacity
            CADisplayLink.rx.link()
                .tweenSineInOut(begin: 0.0, change: 1.0, duration: 4.0)
                .subscribe(onNext: { alpha in
                    box.alpha = alpha
                })
                .disposed(by: bag)

            // Move the box around
            Observable
                .zip(
                    CADisplayLink.rx.link()
                        .tweenLinear(begin: CGFloat(0.0), change: CGFloat(100.0), duration: 1.0),
                    CADisplayLink.rx.link()
                        .tweenQuintIn(begin: CGFloat(100.0), change: CGFloat(-100.0), duration: 1.0)
                )
                .concat(Observable
                    .zip(
                        CADisplayLink.rx.link()
                            .tweenLinear(begin: CGFloat(100.0), change: CGFloat(-100.0), duration: 1.0),
                        CADisplayLink.rx.link()
                            .tweenQuintIn(begin: CGFloat(0.0), change: CGFloat(100.0), duration: 1.0)
                    )
                    .delay(2.0, scheduler: MainScheduler.instance)
                )
                .subscribe(onNext: { (x, y) in
                    let pos = CGPoint(x: startFrame.origin.x + x, y: startFrame.origin.y + y)
                    box.frame = CGRect(origin: pos, size: box.frame.size)
                })
                .disposed(by: bag)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

