//
//  NotificationBar.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Furqan Muhammad Khan <furqanmk9>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import UIKit

class NotificationBar {
    
    static var sharedBar: NotificationBar = NotificationBar()
    
    private var activeViewController: UIViewController? {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        let window = appDel?.window
        let navigationController = window?.rootViewController as? UINavigationController
        return navigationController?.visibleViewController
    }
    
    private var startY: CGFloat {
        if ((activeViewController?.navigationController?.isNavigationBarHidden) ?? false) {
            return -70.0
        } else {
            return -2.0
        }
    }
    
    private var height: CGFloat {
        if ((activeViewController?.navigationController?.isNavigationBarHidden) ?? false) {
            return 50.0
        } else {
            return 30.0
        }
    }
    
    private var displacment: CGFloat {
        if ((activeViewController?.navigationController?.isNavigationBarHidden) ?? false) {
            return 10.0
        } else {
            return 0.0
        }
    }
    
    func show (message: String, background: UIColor = UIColor.red, permenantly permanent: Bool = false, loadingIndicator: Bool = false, completion: (() -> Void)? = nil) {
        if messageView == nil, let activeViewController = activeViewController {
            backgroundView = UIView(frame: activeViewController.view.frame)
            backgroundView.backgroundColor = UIColor.clear
            activeViewController.view.addSubview(backgroundView)
            
            let font = UIFont.systemFont(ofSize: 16.0)
            let attributes = [NSFontAttributeName: font]
            let size = (message as NSString).size(attributes: attributes)
            let lines = Int(size.width / activeViewController.view.frame.width)
            
            messageView = UIView(frame: CGRect(x: 0, y: startY, width: activeViewController.view.frame.width, height: height + CGFloat(lines) * size.height))
            messageView.backgroundColor = background
            messageView.alpha = 0
            
            let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: messageView.bounds.width, height: messageView.bounds.height))).then(block: {
                $0.center = messageView.center
                $0.text = message
                $0.font = font
                $0.numberOfLines = 0
                $0.lineBreakMode = NSLineBreakMode.byWordWrapping
                $0.textAlignment = NSTextAlignment.center
                $0.textColor = UIColor.white
            })
            messageView.addSubview(label)
            
            
            if loadingIndicator {
                let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
                indicator.center.x = messageView.frame.width - indicator.frame.width
                indicator.center.y = messageView.frame.height / 2 + displacment
                self.messageView.addSubview(indicator)
                indicator.startAnimating()
            }
            
            activeViewController.view.addSubview(messageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.backgroundView.alpha = 0.2
                self.messageView.alpha = 1
                self.messageView.center.y += 65
                
                }, completion: nil)
            
            if !permanent {
                UIView.animate(withDuration: 0.5, delay: 2.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    
                    self.messageView.alpha = 0
                    self.messageView.center.y -= 65
                    self.backgroundView.alpha = 0
                    
                    }, completion:
                    {
                        _ in
                        self.backgroundView.removeFromSuperview()
                        self.backgroundView = nil
                        self.messageView.removeFromSuperview()
                        self.messageView = nil
                        completion?()
                })
            }
        }
    }
    
    func hide (completion: (() -> Void)? = nil) {
        guard let messageView = messageView, let backgroundView = backgroundView else { return }
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            messageView.alpha = 0
            messageView.center.y -= 65
            backgroundView.alpha = 0
            
            }, completion:
            {
                _ in
                backgroundView.removeFromSuperview()
                self.backgroundView = nil
                messageView.removeFromSuperview()
                self.messageView = nil
                completion?()
        })
    }
    
    
    private var messageView: UIView!, backgroundView: UIView!
    
    private init () {
    } //To restrict initialization
    
}

public protocol Then {}

extension Then where Self: AnyObject {
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}

