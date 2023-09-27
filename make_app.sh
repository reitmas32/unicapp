#! bash

rm -r apk
mkdir apk

# Production
echo "======> Build Production"
sed -i 's/development/production/g' .env
sed -i 's/__name__app__/UNICapp/g' android/app/src/main/AndroidManifest.xml

# Build
flutter build apk
mv build/app/outputs/apk/release/app-release.apk apk/UNICapp-v0.0.1.apk

sed -i 's/production/__environment__/g' .env
sed -i 's/UNICapp/__name__app__/g' android/app/src/main/AndroidManifest.xml

# Development
echo "======> Build Development"
sed -i 's/__environment__/development/g' .env
sed -i 's/__name__app__/UNICappDEV/g' android/app/src/main/AndroidManifest.xml

# Build
flutter build apk
mv build/app/outputs/apk/release/app-release.apk apk/UNICappDEV-v0.0.1.apk

sed -i 's/development/__environment__/g' .env
sed -i 's/UNICappDEV/__name__app__/g' android/app/src/main/AndroidManifest.xml

# Staging
echo "======> Build Staging"
sed -i 's/__environment__/staging/g' .env
sed -i 's/__name__app__/UNICappSTG/g' android/app/src/main/AndroidManifest.xml

# Build
flutter build apk
mv build/app/outputs/apk/release/app-release.apk apk/UNICappSTG-v0.0.1.apk

sed -i 's/staging/development/g' .env
sed -i 's/UNICappSTG/__name__app__/g' android/app/src/main/AndroidManifest.xml
