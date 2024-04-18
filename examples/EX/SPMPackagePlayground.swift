import MacroCodableKit

import DebugKit
import GoogleMaps
import OpenTelemetrySdk
import Orcam
import SnapKit
import SwiftUIX
import SwiftyBeaver

@AllOfCodable // MacroCodableKit
@Init // Orcam
struct Foo {
  let x: Int

  func check() {
    print(AnyButtonStyle.self) // SwiftUIX
    print(SwiftyBeaver.self) // SwiftyBeaver
    print(Constraint.self) // SnapKit
    print(DoubleCounterSdk.self) // OpenTelemetrySdk
    print(DebugKit.self) // DebugKit
    print(GMSAddress.self) // GoogleMaps
  }
}
