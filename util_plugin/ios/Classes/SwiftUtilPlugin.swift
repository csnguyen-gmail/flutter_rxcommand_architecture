import Flutter
import UIKit

public class SwiftUtilPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "util_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftUtilPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if ("locale" == call.method) {
            self.locale(flutterResult: result)
        } else if ("setAppBadgeNumber" == call.method) {
            let arguments = call.arguments as! NSDictionary
            self.setAppBadgeNumber(badgeNumber: arguments["badgeNumber"] as! Int)
        }
    }
    
    private func locale(flutterResult: FlutterResult) {
        let preferredLanguages = Locale.preferredLanguages.first?.split(separator: "-")
        
        var lanCode = "en"
        if (preferredLanguages != nil && (preferredLanguages?.count)! >= 1) {
            lanCode = String(preferredLanguages![0])
        }
        
        var countryCode = "US"
        if (preferredLanguages != nil && (preferredLanguages?.count)! >= 2) {
            countryCode = String(preferredLanguages![1])
        }
        let results = [
            "lanCode":lanCode,
            "countryCode":countryCode] as [String : Any]
        flutterResult(results)
    }
    
    private func setAppBadgeNumber(badgeNumber: Int) {
        UIApplication.shared.applicationIconBadgeNumber = badgeNumber
    }
}
