REM �y��{���z
REM robocopy �ۑ��� �ۑ��� �R�}���h
REM %USERNAME%�̓��O�C�����Ă��郆�[�U�[�����擾����
REM /MIR�͕ۑ����̃f�[�^���i��t�H���_�܂ށj��ۑ���ɓ�������
REM /R:1�̓R�s�[���s����1��Ď��s����
REM /W:1�̓R�s�[���s�Ɣ��f����܂ł̑҂�����
REM /LOG+:��""�ň͂񂾏ꏊ�Ƀ��O�t�@�C����ǋL�o�͂���
REM /E�͋�t�H���_���R�s�[����
REM /S�͋�t�H���_���R�s�[���Ȃ�
REM /maxage:�͎��s�������t�i%DATE:/=_%�œ��t���擾�j�����Â��t�@�C���͏��O����
REM /FFT��FAT�̏ꍇ�iLinux���ڌ^LinkStation���Y���j�t�@�C���̎�����2�b�̐��x�ł����L�^�ł��Ȃ�����2�b�ȓ��̌덷�Ȃ��v���Ă��邱�Ƃɂ���
REM /XA:SH�͎w�肳�ꂽ�����̃t�@�C�������O�B�uS�v�̓V�X�e���t�@�C���A�uH�v�͉B���t�@�C��
REM /XD�͓���̃t�H���_�����O����
REM mkdir�͐V�K�t�H���_�쐬

REM �y���ӎ����z
REM �����͋�̃t�H���_�̓R�s�[����Ȃ�
REM �ۑ��̎��A�����R�[�h��ANSI�ɂ��Ȃ��Ǝ��s��ʂŕ����������N����

REM �y�g�p����Ƃ��z
REM F�h���C�u��NAS�ǂ��炩��REM�ŋL�q���邩�A�폜���Ďg�p���Ă�������

REM �i��������jPC����F�h���C�u�Ƀo�b�N�A�b�v�ƍ������s���ꍇ

REM ------------------------------------------------------------------------------------------------------

REM ���O�p�t�H���_�̐V�K�쐬
mkdir C:\PC_Maintenance\robocopy\log\PC\Mirror

REM �f�X�N�g�b�v����F�h���C�u�ւ̓����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Desktop F:\Backup\robocopy\Desktop /MIR /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Desktop_%DATE:/=_%.log"

REM �h�L�������g����F�h���C�u�ւ̓����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Documents F:\Backup\robocopy\Documents /MIR /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Documents_%DATE:/=_%.log"

REM �tⳂ���F�h���C�u�ւ̓����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState F:\Backup\robocopy\StickyNotes /MIR /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM ���O�p�t�H���_�̐V�K�쐬
mkdir C:\PC_Maintenance\robocopy\log\PC\Sabun

REM �f�X�N�g�b�v����F�h���C�u�ւ̍����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Desktop F:\Backup\robocopy_Sabun\%DATE:/=_%\Desktop /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Desktop_%DATE:/=_%.log"

REM �h�L�������g����F�h���C�u�ւ̍����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Documents F:\Backup\robocopy_Sabun\%DATE:/=_%\Documents /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Documents_%DATE:/=_%.log"

REM �tⳂ���F�h���C�u�ւ̍����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState F:\Backup\robocopy_Sabun\%DATE:/=_%\StickyNotes /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM �urobocopy_Sabun�v�t�H���_���̃t�H���_�̍X�V����31���ȏゾ�ƍ폜����
set backupdir=F:\Backup\robocopy_Sabun
set count=31
for /f "skip=%count%" %%a in ('dir "%backupdir%" /B /O-N') do (
rmdir /S /Q %backupdir%\%%a
)
REM ------------------------------------------------------------------------------------------------------

REM �uMirror�v�ƁuSabun�v�t�H���_����.log�̍X�V����31���ȏゾ�ƍ폜����
forfiles /p C:\PC_Maintenance\robocopy\log\Mirror /d -31 /m "*.log" /c "cmd /c del @file"

forfiles /p C:\PC_Maintenance\robocopy\log\Sabun /d -31 /m "*.log" /c "cmd /c del @file"

REM ------------------------------------------------------------------------------------------------------

REM �i�����܂ŁjPC����F�h���C�u�Ƀo�b�N�A�b�v�ƍ������s���ꍇ

REM �i��������jPC����NAS�Ƀo�b�N�A�b�v�ƍ������s���ꍇ

REM NAS�ɐڑ����鋤�L�t�H���_�[�ƃ��[�U�[���ƃp�X���[�h
net use \\192.168.0.117\share /user:admin password

REM ------------------------------------------------------------------------------------------------------

REM ���O�p�t�H���_�̐V�K�쐬
mkdir C:\PC_Maintenance\robocopy\log\PC\Mirror

REM �f�X�N�g�b�v����NAS�ւ̓����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Desktop \\192.168.0.117\share\Backup\robocopy\Desktop /MIR /FFT /XA:SH /XD "trashbox" /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Desktop_%DATE:/=_%.log"

REM �h�L�������g����NAS�ւ̓����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Documents \\192.168.0.117\share\Backup\robocopy\Documents /MIR /FFT /XA:SH /XD "trashbox" /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\Documents_%DATE:/=_%.log"

REM �tⳂ���NAS�ւ̓����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState \\192.168.0.117\share\Backup\robocopy\StickyNotes /MIR /FFT /XA:SH /XD "trashbox" /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Mirror\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM �t�H���_�̐V�K�쐬
mkdir C:\PC_Maintenance\robocopy\log\PC\Sabun

REM �f�X�N�g�b�v����NAS�ւ̍����ƃ��O�t�@�C���̏o��
robocopy \\192.168.0.117\share \\192.168.0.109\share\test_Sabun\%DATE:/=_% /S /FFT /XA:SH /XD "trashbox" /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Desktop_%DATE:/=_%.log"

REM �h�L�������g����NAS�ւ̍����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\Documents F:\Backup\robocopy_Sabun\%DATE:/=_%\Documents /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\Documents_%DATE:/=_%.log"

REM �tⳂ���NAS�ւ̍����ƃ��O�t�@�C���̍쐬
robocopy C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe\LocalState F:\Backup\robocopy_Sabun\%DATE:/=_%\StickyNotes /S /maxage:%DATE:/=% /R:1 /W:1 /LOG+:"C:\PC_Maintenance\robocopy\log\PC\Sabun\StickyNotes_%DATE:/=_%.log"

REM ------------------------------------------------------------------------------------------------------

REM �u\\192.168.0.109\share\Backup\robocopy_Sabun�v�t�H���_���̃t�H���_�̍X�V����31���ȏゾ�ƍ폜����
set backupdir=\\192.168.0.109\share\Backup\robocopy_Sabun
set count=31
for /f "skip=%count%" %%a in ('dir "%backupdir%" /B /O-N') do (
rmdir /S /Q %backupdir%\%%a
)

REM ------------------------------------------------------------------------------------------------------

REM �uMirror�v�ƁuSabun�v�t�H���_����.log�̍X�V����31���ȏゾ�ƍ폜����
forfiles /p C:\PC_Maintenance\robocopy\log\Mirror /d -31 /m "*.log" /c "cmd /c del @file"

forfiles /p C:\PC_Maintenance\robocopy\log\Sabun /d -31 /m "*.log" /c "cmd /c del @file"

REM ------------------------------------------------------------------------------------------------------

REM �i�����܂ŁjPC����NAS�Ƀo�b�N�A�b�v�ƍ������s���ꍇ

pause