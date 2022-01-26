import Foundation
import UIKit
import AsyncDisplayKit
import Display
import TelegramPresentationData
import TextSelectionNode
import ReactionSelectionNode
import TelegramCore
import SwiftSignalKit
import AccountContext

private let animationDurationFactor: Double = 1.0

private final class ContextControllerNode: ViewControllerTracingNode, UIScrollViewDelegate {
    private var presentationData: PresentationData
    
    private let effectView: UIVisualEffectView
    
    init(
        presentationData: PresentationData
    ) {
        self.presentationData = presentationData
        
        self.effectView = UIVisualEffectView()
        if #available(iOS 9.0, *) {
        } else {
            if presentationData.theme.rootController.keyboardColor == .dark {
                self.effectView.effect = UIBlurEffect(style: .dark)
            } else {
                self.effectView.effect = UIBlurEffect(style: .light)
            }
            self.effectView.alpha = 0.0
        }
    }
    
    override func didLoad() {
        super.didLoad()
        
//        self.dismissNode.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimNodeTapped)))
    }
    
    @objc private func dimNodeTapped() {
//        guard self.animatedIn else {
//            return
//        }
//        self.dismissedForCancel?()
//        self.beginDismiss(.default)
    }
    
}

public final class ContextWgTranslateController: ViewController, StandalonePresentableController {
    
}
