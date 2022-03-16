REM 【基本情報】
REM robocopy 保存元 保存先 コマンド
REM %USERNAME%はログインしているユーザー名を取得する
REM /MIRは保存元のデータ情報（空フォルダ含む）を保存先に同期する
REM /R:1はコピー失敗時に1回再試行する
REM /W:1はコピー失敗と判断するまでの待ち時間
REM /LOG+:は""で囲んだ場所にログファイルを追記出力する
REM /Eは空フォルダもコピーする
REM /Sは空フォルダをコピーしない
REM /maxage:は実行した日付（%DATE:/=_%で日付を取得）よりも古いファイルは除外する
REM /FFTはFATの場合（Linux搭載型LinkStationが該当）ファイルの時刻が2秒の精度でしか記録できないため2秒以内の誤差なら一致していることにする
REM /XA:SHは指定された属性のファイルを除外。「S」はシステムファイル、「H」は隠しファイル
REM /XDは特定のフォルダを除外する
REM mkdirは新規フォルダ作成

REM 【注意事項】
REM 差分は空のフォルダはコピーされない
REM 保存の時、文字コードはANSIにしないと実行画面で文字化けを起こす

REM 【使用するとき】
REM FドライブかNASどちらかをREMで記述するか、削除して使用してください

REM （ここから）PCからFドライブにバックアップと差分を行う場合

REM ------------------------------------------------------------------------------------------------------

REM ログ用フォルダの新規作成
mkdir C:\PC_Maintenance\robocopy\log\PC\Mirror

REM デスクトップからFドライブへの同期とログファイルの作成
robocopy C:\Users\%USERNAME%\Desktop F:\Backup\robocopy\Desktop /MIR /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Desktop_%DATE:/=_%.log"

REM ドキュメントからFドライブへの同期とログファイルの作成
robocopy C:\Users\%USERNAME%\Documents F:\Backup\robocopy\Documents /MIR /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Documents_%DATE:/=_%.log"

REM 付箋からFドライブへの同期とログファイルの作成
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState F:\Backup\robocopy\StickyNotes /MIR /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM ログ用フォルダの新規作成
mkdir C:\PC_Maintenance\robocopy\log\PC\Sabun

REM デスクトップからFドライブへの差分とログファイルの作成
robocopy C:\Users\%USERNAME%\Desktop F:\Backup\robocopy_Sabun\%DATE:/=_%\Desktop /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Desktop_%DATE:/=_%.log"

REM ドキュメントからFドライブへの差分とログファイルの作成
robocopy C:\Users\%USERNAME%\Documents F:\Backup\robocopy_Sabun\%DATE:/=_%\Documents /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Documents_%DATE:/=_%.log"

REM 付箋からFドライブへの差分とログファイルの作成
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState F:\Backup\robocopy_Sabun\%DATE:/=_%\StickyNotes /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM 「robocopy_Sabun」フォルダ内のフォルダの更新日が31日以上だと削除する
set backupdir=F:\Backup\robocopy_Sabun
set count=31
for /f "skip=%count%" %%a in ('dir "%backupdir%" /B /O-N') do (
rmdir /S /Q %backupdir%\%%a
)
REM ------------------------------------------------------------------------------------------------------

REM 「Mirror」と「Sabun」フォルダ内の.logの更新日が31日以上だと削除する
forfiles /p C:\PC_Maintenance\robocopy\log\Mirror /d -31 /m "*.log" /c "cmd /c del @file"

forfiles /p C:\PC_Maintenance\robocopy\log\Sabun /d -31 /m "*.log" /c "cmd /c del @file"

REM ------------------------------------------------------------------------------------------------------

REM （ここまで）PCからFドライブにバックアップと差分を行う場合

REM （ここから）PCからNASにバックアップと差分を行う場合

REM NASに接続する共有フォルダーとユーザー名とパスワード
net use \\192.168.0.117\share /user:admin password

REM ------------------------------------------------------------------------------------------------------

REM ログ用フォルダの新規作成
mkdir C:\PC_Maintenance\robocopy\log\PC\Mirror

REM デスクトップからNASへの同期とログファイルの作成
robocopy C:\Users\%USERNAME%\Desktop \\192.168.0.117\share\Backup\robocopy\Desktop /MIR /FFT /XA:SH /XD "trashbox" /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Desktop_%DATE:/=_%.log"

REM ドキュメントからNASへの同期とログファイルの作成
robocopy C:\Users\%USERNAME%\Documents \\192.168.0.117\share\Backup\robocopy\Documents /MIR /FFT /XA:SH /XD "trashbox" /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Documents_%DATE:/=_%.log"

REM 付箋からNASへの同期とログファイルの作成
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState \\192.168.0.117\share\Backup\robocopy\StickyNotes /MIR /FFT /XA:SH /XD "trashbox" /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM フォルダの新規作成
mkdir C:\PC_Maintenance\robocopy\log\PC\Sabun

REM デスクトップからNASへの差分とログファイルの出力
robocopy \\192.168.0.117\share \\192.168.0.109\share\test_Sabun\%DATE:/=_% /S /FFT /XA:SH /XD "trashbox" /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Desktop_%DATE:/=_%.log"

REM ドキュメントからNASへの差分とログファイルの作成
robocopy C:\Users\%USERNAME%\Documents F:\Backup\robocopy_Sabun\%DATE:/=_%\Documents /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Documents_%DATE:/=_%.log"

REM 付箋からNASへの差分とログファイルの作成
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState F:\Backup\robocopy_Sabun\%DATE:/=_%\StickyNotes /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM 「\\192.168.0.109\share\Backup\robocopy_Sabun」フォルダ内のフォルダの更新日が31日以上だと削除する
set backupdir=\\192.168.0.109\share\Backup\robocopy_Sabun
set count=31
for /f "skip=%count%" %%a in ('dir "%backupdir%" /B /O-N') do (
rmdir /S /Q %backupdir%\%%a
)

REM ------------------------------------------------------------------------------------------------------

REM 「Mirror」と「Sabun」フォルダ内の.logの更新日が31日以上だと削除する
forfiles /p C:\PC_Maintenance\robocopy\log\Mirror /d -31 /m "*.log" /c "cmd /c del @file"

forfiles /p C:\PC_Maintenance\robocopy\log\Sabun /d -31 /m "*.log" /c "cmd /c del @file"

REM ------------------------------------------------------------------------------------------------------

REM （ここまで）PCからNASにバックアップと差分を行う場合

pause