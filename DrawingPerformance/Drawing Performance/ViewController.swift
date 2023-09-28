//
//  ViewController.swift
//  Drawing Performance
//
//  Created by Besher on 2019-01-13.
//  Copyright © 2019 Besher Al Maleh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fpsLabel: UILabel!
    @IBOutlet weak var drawingContainer: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var displayLink: CADisplayLink!
    var previousTimestamp: CFTimeInterval = 0
    var frameCount = 0
    
    lazy var cpuSlowView: FreedrawingImageViewCG = setupView()
    lazy var cpuFastView: FreedrawingImageViewDrawRect = setupView()
    lazy var gpuSubLayer: FreeDrawingImageViewSubLayer = setupView()
    lazy var gpuDrawLayer: FreeDrawingImageViewDrawLayer = setupView()
    
    lazy var allViews: [Drawable] = [cpuSlowView, cpuFastView, gpuDrawLayer, gpuSubLayer]
    
    var displayedView: DisplayedView? {
        didSet { show(displayedView) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateFPS))
//        displayLink.preferredFrameRateRange = .init(minimum: 60, maximum: 120, preferred: 120)
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cpuSlowView.backgroundColor = .green
        cpuFastView.backgroundColor = .blue
        gpuSubLayer.backgroundColor = .purple
        gpuDrawLayer.backgroundColor = .orange
        
        displayedView = .cpuSlow(cpuSlowView)
    }
    
    @objc func updateFPS(_ displayLink: CADisplayLink) {
//        let actualFramesPerSecond = 1 / (displayLink.targetTimestamp - displayLink.timestamp)
//        print("actualFramesPerSecond: \(actualFramesPerSecond)")

        if previousTimestamp == 0 {
            previousTimestamp = displayLink.timestamp
            return
        }
        
        frameCount += 1
        let deltaTime = displayLink.timestamp - previousTimestamp
        if deltaTime >= 1.0 {
            let fps = Double(frameCount) / deltaTime
            print("FPS: \(fps) / fc: \(frameCount) / deltaTime: \(deltaTime)")
            frameCount = 0
            previousTimestamp = displayLink.timestamp
            
            fpsLabel.text = "FPS \(fps)"
        }
    }
    
    @IBAction func startDrawingLink(_ sender: UIBarButtonItem) {
        displayedView?.associatedView.startAutoDrawingLink()
    }
    
    @IBAction func startDrawingTimer(_ sender: UIBarButtonItem) {
        displayedView?.associatedView.startAutoDrawingTimer()
    }
    
    @IBAction func clearCanvas(_ sender: UIBarButtonItem) {
        displayedView?.associatedView.clear()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: displayedView = .cpuSlow(cpuSlowView)
        case 1: displayedView = .cpuFast(cpuFastView)
        case 2: displayedView = .gpuSubLayer(gpuSubLayer)
        case 3: displayedView = .gpuDrawLayer(gpuDrawLayer)
            
        default: break
        }
    }
    
    func show(_ view: DisplayedView?) {
        guard let view = view else { return }
        allViews.forEach { $0.hide() }
        view.associatedView.unHide()
        descriptionLabel.text = view.description
    }
    
    func setupView<T: UIView>() -> T {
        let view = T()
        view.bounds = drawingContainer.bounds
        view.frame.origin = .zero
        view.isHidden = true
        drawingContainer.addSubview(view)
        return view
    }
}
