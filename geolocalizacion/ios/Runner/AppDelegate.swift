import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

        // TODO: Add your API key
        GMSServices.provideAPIKey("AIzaSyB3p_YI-ea1yecLHdmepA_uIly2lZjed0c")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
