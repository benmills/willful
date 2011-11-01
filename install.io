"Installing Willful" println

"  1. Moving willful to /usr/local/bin" println
System runCommand("cp willful /usr/local/bin")

"  2. Making willful executable" println
System runCommand("chmod +x /usr/local/bin/willful")

writeln("  3. Moving willful.io to " .. System ioPath .. "/willful.io")
System runCommand("cp -r lib " .. System ioPath .. "/willful/")
