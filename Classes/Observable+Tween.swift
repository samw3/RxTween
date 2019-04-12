//
//  RxTween.swift
//  RxTween_Example
//
//  Created by Sam Washburn on 4/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxSwift

public extension ObservableType {

    // Based on Robert Penner's easing equations: http://robertpenner.com/easing/

    func tweenLinear<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                return change * time + begin
        }
    }

    func tweenBackIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, overshoot: T = 1.70158, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                let overshoot = (overshoot + 1.0) * time - overshoot
                return change * time * time * overshoot + begin
        }
    }

    func tweenBackOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, overshoot: T = 1.70158, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration - 1)
                let overshoot = (overshoot + 1) * time + overshoot
                return change * (time * time * overshoot + 1) + begin
        }
    }

    func tweenBackInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, overshoot: T = 1.70158, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        let overshoot = overshoot * 1.525
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / (duration / 2))
                if time < 1 {
                    let overshoot = (overshoot + 1) * time - overshoot
                    return change / 2 * (time * time * overshoot) + begin
                } else {
                    let time = time - 2
                    let overshoot = (overshoot + 1) * time + overshoot
                    return change / 2 * (time * time * overshoot + 2) + begin
                }
        }
    }

    func tweenCircIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                return -change * (sqrt(1 - time * time) - 1) + begin
        }
    }

    func tweenCircOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration - 1)
                return change * sqrt(1 - time * time) + begin
        }
    }

    func tweenCircInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / (duration / 2))
                if (time < 1) {
                    let magnitude = sqrt(1 - time * time) - 1
                    return -change / 2 * magnitude + begin
                } else {
                    let time = time - 2
                    let magnitude = sqrt(1 - time * time) + 1
                    return change / 2 * magnitude + begin
                }
        }
    }

    func tweenCubicIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                return change * time * time * time + begin
        }
    }

    func tweenCubicOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration - 1)
                return change * (time * time * time + 1) + begin
        }
    }

    func tweenCubicInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / (duration / 2))
                if (time < 1) {
                    return change / 2 * time * time * time + begin
                } else {
                    let time = time - 2
                    return change / 2 * (time * time * time + 2) + begin
                }
        }
    }

    func tweenQuadIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                return change * time * time + begin
        }
    }

    func tweenQuadOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                return -change * time * (time - 2) + begin
        }
    }

    func tweenQuadInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / (duration / 2))
                if (time < 1) {
                    return change / 2 * time * time + begin
                } else {
                    let time = time - 1
                    let magnitude = (time * (time - 2) - 1)
                    return -change / 2 * magnitude + begin
                }
        }
    }

    func tweenQuartIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                let magnitude = time * time * time * time
                return change * magnitude + begin
        }
    }

    func tweenQuartOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration - 1)
                let magnitude = time * time * time * time - 1
                return -change * magnitude + begin
        }
    }

    func tweenQuartInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / (duration / 2))
                if (time < 1) {
                    let magnitude = time * time * time * time
                    return change / 2 * magnitude + begin
                } else {
                    let time = time - 2
                    let magnitude = time * time * time * time - 2
                    return -change / 2 * magnitude + begin
                }
        }
    }

    func tweenQuintIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                let magnitude = time * time * time * time * time
                return change * magnitude + begin
        }
    }

    func tweenQuintOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration - 1)
                let magnitude = time * time * time * time * time + 1
                return change * magnitude + begin
        }
    }

    func tweenQuintInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / (duration / 2))
                if (time < 1) {
                    let magnitude = time * time * time * time * time
                    return change / 2 * magnitude + begin
                } else {
                    let time = time - 2
                    let magnitude = time * time * time * time * time + 2
                    return change / 2 * magnitude + begin
                }
        }
    }

    func tweenSineIn<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                let magnitude = T(cos(Double(time * (T.pi / 2))))
                return -change * magnitude + change + begin
        }
    }

    func tweenSineOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                let magnitude = sin(Double(time * (T.pi / 2)))
                return change * T(magnitude) + begin
        }
    }

    func tweenSineInOut<T:BinaryFloatingPoint>(begin: T, change: T, duration: RxTimeInterval, interval: RxTimeInterval = (1.0 / 60.0)) -> Observable<T> {
        return self
            .scan(Int(0)) { step, _ in step + 1 }
            .takeWhile { step in RxTimeInterval(step) * interval <= duration }
            .map { step in
                let step = RxTimeInterval(step)
                let time = T((step * interval) / duration)
                return -change / 2 * T(cos(Double(T.pi * time)) - 1) + begin
        }
    }
}
