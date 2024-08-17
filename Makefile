splashicon:
	flutter clean
	flutter pub get
	flutter pub run flutter_native_splash:create
	flutter pub run flutter_launcher_icons:main

tr:
	python3 -Xutf8 lib/lang/xml_to_dart.py

iosfix:
	rm -rf pubspec.lock ios/Pods ios/Podfile.lock
	flutter pub get
	pod install --repo-update --project-directory=ios

appbundle:
	flutter clean && flutter build appbundle
	
apk:
	flutter clean && flutter build apk --split-per-abi

ipa:
	flutter clean && flutter build ipa
