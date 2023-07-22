# android
function load_android() {
	export ANDROID_SDK_ROOT=$HOME/Library/Android/Sdk
	export ANDROID_HOME=$HOME/Library/Android/Sdk
	export PATH="$HOME/Library/Android/Sdk/emulator:$PATH"
	alias run_avd="emulator -avd $(emulator -list-avds | head --lines=1) -netdelay none -netspeed full"
}
