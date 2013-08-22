iOSFramework
============

Any third-part useful library for iOS

============

Github Page : https://github.com/pokeb/asi-http-request/tree

Setup :

1. Add Classes and External folder

2. Add CFNetwork.framework MobileCoreServices.framework Security.framework SystemConfiguration.framework libxml2.dylib and libz.dylib

3. Remove Classes/Test folder

4. Add -fno-objc-arc compiler flags in Targets Build Phases

5. Add ${SDK_DIR}/usr/include/libxml2 in Targets Header Search Paths settings

============

How To :

1. Change Build Configuration to Release in Run Scheme

2. Build product target for Device mode

3. Build product target for Simulator mode

4. Build aggregate target for Device or Simulator mode

5. Open the Derived Data path, the final framework is at {Derived Data Path}/Build/Products/{ProductName}.framework