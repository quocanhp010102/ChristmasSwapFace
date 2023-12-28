//
//  AdmobManager.swift
//  MangaReader
//
//  Created by Thanh Cong on 9/9/18.
//  Copyright © 2018 Thanh Cong. All rights reserved.
//

import UIKit
//https://apps.admob.com/v2/apps/4912926119/adunits/list
import GoogleMobileAds
//VALUE
var PER_PAGE = 30
var DEVICE_WIDTH = UIScreen.main.bounds.width
var DEVICE_HEIGHT = UIScreen.main.bounds.height
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let adSize = UIDevice.current.userInterfaceIdiom == .pad ? kGADAdSizeBanner: kGADAdSizeBanner

class AdmobManager: NSObject {
    
    static let shared = AdmobManager()
    
    var interstitial: GADInterstitial!

    var isShowAds = false
    var counter = 1
    
    var fullRootViewController: UIViewController!

    //Native ads
    private var adLoader: GADAdLoader!
    var admobNativeAds: [GADUnifiedNativeAd] = []
    var loadErrorNativeAdmob = 0
    var loadErrorFullAdmob = 0
    
    var nativeAdmobIndex = 0
    
    var isTimer = true
    
    override init() {
        super.init()
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [(kGADSimulatorID as? String) ?? "", "c7f5d0314287e72fdcba00545320b656","48dc4326e9c28206e73446cdeeff5f86"]
//        self.createAndLoadInterstitial()
        //self.loadAllNativeAds()
        counter = numberToShowAd - 1
    }
    
    func openRateView(){
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
        }
    }
        
    func createBannerView(inVC: UIViewController) -> UIView{
        let witdh = DEVICE_WIDTH
        let frame = CGRect.init(x: (witdh - adSize.size.width)/2 , y: 0, width: adSize.size.width, height: adSize.size.height)
        let bannerView = GADBannerView.init(adSize: adSize)
        bannerView.adUnitID = admobBanner
        bannerView.rootViewController = inVC
        bannerView.delegate = self
        bannerView.frame = frame
        inVC.view.addSubview(bannerView)
        let request = GADRequest()
        bannerView.load(request)
        
        let tempView = UIView.init(frame: CGRect.init(x:0 , y: 0, width: DEVICE_WIDTH, height: adSize.size.height))
        tempView.addSubview(bannerView)
        return tempView
    }

    func createAndLoadInterstitial() {
        if loadErrorFullAdmob >= 2{
            return
        }
                
        interstitial = GADInterstitial(adUnitID: admobFull)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func loadAllNativeAds(){
        if !isTimer {
            return
        }
        isTimer = false
        let _ = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { [weak self] (timer) in
            self?.isTimer = true
        }
        self.loadAdmobNativeAds()
    }
            
    func getAdmobNativeAds() -> GADUnifiedNativeAd?{
        if admobNativeAds.count > nativeAdmobIndex{
            let item = admobNativeAds[nativeAdmobIndex]
            nativeAdmobIndex = nativeAdmobIndex + 1
            return item
        }
        return admobNativeAds.last
    }
    
    func loadAdmobNativeAds(){
        
        if loadErrorNativeAdmob >= 2{
            return
        }
        
        if nativeAdmobIndex > 0{
            if admobNativeAds.count > (nativeAdmobIndex){
                return
            }
        }
        print("loadAdmobNativeAds")
        adLoader = GADAdLoader(adUnitID: adNativeAd, rootViewController: fullRootViewController, adTypes: [GADAdLoaderAdType.unifiedNative], options: nil)
        adLoader.delegate = self
        let request = GADRequest()
        adLoader.load(request)
    }
        
    func logEvent(){
        if PaymentManager.shared.isPurchase(){
            return
        }
        counter = counter + 1
        if counter % 3 == 0 {
            if let interstitial = interstitial{
                if interstitial.isReady{
                    createAndLoadInterstitial()
                }
            }
        }
        if  counter >= numberToShowAd {
            isShowAds = true
            if interstitial.isReady{
                if let rootViewController = fullRootViewController {
                    interstitial.present(fromRootViewController: rootViewController)
                } else {
                    // Handle the case where fullRootViewController is nil
                    print("fullRootViewController is nil")
                }
//                interstitial.present(fromRootViewController: fullRootViewController!)
                counter = 1
            }
        }else{
            if isShowAds{
                isShowAds = false
                self.openRateView()
            }
        }
    }
    
    func forceShowAdd(){
        counter = numberToShowAd
        self.logEvent()
    }
}

extension AdmobManager: GADBannerViewDelegate{
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError bannerView")
    }
}

extension AdmobManager: GADInterstitialDelegate{
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.createAndLoadInterstitial()
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("didFailToReceiveAdWithError GADInterstitial")
        loadErrorFullAdmob = loadErrorFullAdmob + 1
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
    }
}

extension AdmobManager: GADAdLoaderDelegate{
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
        loadErrorNativeAdmob = loadErrorNativeAdmob + 1
    }
}

extension AdmobManager: GADUnifiedNativeAdLoaderDelegate {
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        print("didReceive nativeAd")
        admobNativeAds.append(nativeAd)
    }
}

