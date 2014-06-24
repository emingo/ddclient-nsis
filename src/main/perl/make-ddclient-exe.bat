
set DDCLIENT_VERSION=%1

rem see http://search.cpan.org/~rschupp/PAR-Packer-1.014/lib/pp.pm
rem NB(1): supplying an .ico containing anything over 32x32 here doesn't work
rem NB(2): calling  c:\perl\site\bin\pp.bat here doesn't work
rem NB(3): this doesn't seem to work in 64-bit perl, either

rem --icon no longer supported in pp (see http://stackoverflow.com/questions/22607334 )
rem %PERL% %PERL%\..\..\site\bin\pp --icon "..\resources\ddclient32.ico" -o ..\..\..\target\ddclient.exe ddclient
rem %PERL% %PERL%\..\..\site\bin\pp --gui --icon "..\resources\ddclient32.ico" -o ..\..\..\target\ddclient-noconsole.exe ddclient

%PERL% %PERL%\..\..\site\bin\pp -o ..\..\..\target\ddclient.exe ddclient
%PERL% -e "use Win32::Exe; $exe = Win32::Exe->new('..\..\..\target\ddclient.exe'); $exe->set_single_group_icon('..\resources\ddclient32.ico'); $exe->write;"

%PERL% %PERL%\..\..\site\bin\pp --gui -o ..\..\..\target\ddclient-noconsole.exe ddclient
%PERL% -e "use Win32::Exe; $exe = Win32::Exe->new('..\..\..\target\ddclient-noconsole.exe'); $exe->set_single_group_icon('..\resources\ddclient32.ico'); $exe->write;"


rem verpath sourced from http://www.codeproject.com/Articles/37133/Simple-Version-Resource-Tool-for-Windows
rem NB(3): verpatch appears to trim the last character from the strings here in procexp (but not in windows explorer)

verpatch ..\..\..\target\ddclient.exe %DDCLIENT_VERSION% /fn /s company "randomnoun" /s description "A Dynamic DNS client" /s copyright "(c) 2013-2014 randomnoun Creative Commons Attribution 3.0 Unported License" /s product ddclient /pv %DDCLIENT_VERSION%

verpatch ..\..\..\target\ddclient-noconsole.exe %DDCLIENT_VERSION% /fn /s company "randomnoun" /s description "A Dynamic DNS client" /s copyright "(c) 2013-2014 randomnoun Creative Commons Attribution 3.0 Unported License" /s product ddclient /pv %DDCLIENT_VERSION%

exit 0