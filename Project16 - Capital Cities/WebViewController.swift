//
//  WebViewController.swift
//  Project16 - Capital Cities
//
//  Created by Travis Brigman on 6/30/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView = WKWebView()
    var progressView = UIProgressView()
    
    var selectedCapital: String?
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCapital = selectedCapital {
            let baseUrl = "https://en.wikipedia.org/wiki/"
            var url: URL
            if selectedCapital.contains(" ") {
                let webName = selectedCapital.replacingOccurrences(of: " ", with: "_")
                url = URL(string: baseUrl + webName)!
            } else {
                url = URL(string: baseUrl + selectedCapital)!
            }
            
            webView.load(URLRequest(url: url))
            
            webView.allowsBackForwardNavigationGestures = true
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
            
            let progressView = UIProgressView(progressViewStyle: .default)
            progressView.sizeToFit()
            let progressButton = UIBarButtonItem(customView: progressView)
            
            let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
            let backward = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
            toolbarItems = [progressButton, spacer,forward, backward, refresh]
            navigationController?.isToolbarHidden = false
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
