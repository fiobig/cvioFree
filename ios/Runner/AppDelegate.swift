import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var captureOverlay: UIView?
  private var isSecureEnabled = false

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
    setupScreenRecordingDetection()
    return result
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    guard let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "ScreenSecurityPlugin"
    ) else { return }

    let channel = FlutterMethodChannel(
      name: "com.fiore.cv_mobile_app/screen_security",
      binaryMessenger: registrar.messenger()
    )

    channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      DispatchQueue.main.async {
        switch call.method {
        case "enableSecure":
          self?.isSecureEnabled = true
          self?.updateCaptureOverlay()
          result(true)
        case "disableSecure":
          self?.isSecureEnabled = false
          self?.updateCaptureOverlay()
          result(true)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }

  // MARK: - Key window

  private func getKeyWindow() -> UIWindow? {
    if let w = self.window { return w }
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }

  // MARK: - Screen recording detection (overlay)

  private func setupScreenRecordingDetection() {
    NotificationCenter.default.addObserver(
      forName: UIScreen.capturedDidChangeNotification,
      object: nil,
      queue: .main
    ) { [weak self] _ in
      self?.updateCaptureOverlay()
    }
  }

  private func updateCaptureOverlay() {
    if isSecureEnabled && UIScreen.main.isCaptured {
      showCaptureOverlay()
    } else {
      hideCaptureOverlay()
    }
  }

  private func showCaptureOverlay() {
    guard captureOverlay == nil, let window = getKeyWindow() else { return }

    let overlay = UIView(frame: window.bounds)
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.backgroundColor = .black

    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.spacing = 12
    stack.translatesAutoresizingMaskIntoConstraints = false
    overlay.addSubview(stack)

    let icon = UIImageView(image: UIImage(systemName: "eye.slash.fill"))
    icon.tintColor = .white
    icon.contentMode = .scaleAspectFit
    icon.widthAnchor.constraint(equalToConstant: 48).isActive = true
    icon.heightAnchor.constraint(equalToConstant: 48).isActive = true
    stack.addArrangedSubview(icon)

    let label = UILabel()
    label.text = "Screen recording blocked"
    label.textColor = .white
    label.font = .systemFont(ofSize: 15, weight: .medium)
    stack.addArrangedSubview(label)

    NSLayoutConstraint.activate([
      stack.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
      stack.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
    ])

    window.addSubview(overlay)
    captureOverlay = overlay
  }

  private func hideCaptureOverlay() {
    captureOverlay?.removeFromSuperview()
    captureOverlay = nil
  }

}
