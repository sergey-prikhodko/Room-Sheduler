//
//  AgeStepper.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 26.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit
import Combine

final class AgeStepper: UIView {
    
    private let countLabel = UILabel()
    private let stepper = UIStepper()
    
    private var store: Store<Int, TypeAction<Int>>?
    private var storeCancellable: Cancellable?
    private var uiCancellable: Cancellable?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupStepper()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func apply(_ store: Store<Int, TypeAction<Int>>) {
        self.store = store
        stepper.value = Double(store.state)
        stepper.addTarget(self, action: #selector(new(_:)), for: .valueChanged)
//        storeCancellable = stepper.publisher(for: \.value).map { .set(Int($0)) }.sink(receiveValue: store.provide)
        uiCancellable = stepper.publisher(for: \.value).map { "\(Int($0))" }.assign(to: \.text, on: countLabel)
    }
    
    private func setupStepper() {
        stepper.minimumValue = 0.0
        stepper.maximumValue = 100.0
        stepper.stepValue = 1.0
    }
    
    @objc
    private func new(_ sender: UIStepper) {
        store?.provide(.set(Int(sender.value)))
        countLabel.text = "\(Int(sender.value))"
    }
}

// MARK: - UI

private extension AgeStepper {
    
    func setupUI() {
        setupCountLabel()
        setupStepperUI()
    }
    
    func setupCountLabel() {
        addSubview(countLabel)
        countLabel.layout {
            $0.leading == leadingAnchor
            $0.top == topAnchor + 5.0
            $0.bottom == bottomAnchor - 5.0
        }
        countLabel.font = .systemFont(ofSize: 15.0)
        countLabel.textColor = .label
    }
    
    func setupStepperUI() {
        addSubview(stepper)
        stepper.layout {
            $0.leading == countLabel.trailingAnchor + 15.0
            $0.top == topAnchor + 5.0
            $0.trailing == trailingAnchor
            $0.bottom == bottomAnchor - 5.0
        }
    }
}
