# Find .db file
Go to Android/Sdk/platform-tools
List emulators via adb
Connect to emulator via adb shell
Go to app's databases folder
Connect to db

cd $home\AppData\Local\Android\Sdk\platform-tools
.\adb devices
.\adb -s emulator-5554 shell
cd /data/user/0/com.prt/databases
sqlite3 prt.db

# Fix adb permission denied
.\adb root

# SQLite cheatsheet
.tables
.schema tableName
select * from tableName
.quit