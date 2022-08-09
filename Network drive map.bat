:: Lines starting with :: are comments
:: Delete all previous drive mappings
NET USE L: /d /y
NET USE Q: /d /y

:: Connect to the Inter-process Communication CIFS path on each server with the end user's credentials so "If Exists" logic works properly
NET USE \\CMT-FS-01.DeltaCMT.local\IPC$ /user:DeltaCMT\NFUSCO TESTPASSWORD
NET USE \\LGA.DeltaCMT.local\IPC$ /user:DeltaCMT\NFUSCO TESTPASSWORD

:: If CMT-FS-01\Turner exists, map it to Q
if exist \\CMT-FS-01.DeltaCMT.local\Turner (net use Q: \\CMT-FS-01.DeltaCMT.local\Turner /user:DeltaCMT\NFUSCO TESTPASSWORD /persistent:yes & Start Q:)

:: If exists on the old LGA server, map to LGA, else map to new server (CMT-FS-01)
if exist \\LGA.DeltaCMT.local\data (net use L: \\LGA.DeltaCMT.local\data /user:DeltaCMT\NFUSCO TESTPASSWORD /persistent:yes & Start L:) else (GOTO L-on-CMT)

Echo The batch file is complete
exit


:L-on-CMT

Echo L has been moved. Mapping to CMT-FS-01

:: If CMT-FS-01\data exists, map it to L
if exist \\CMT-FS-01.DeltaCMT.local\Data (net use L: \\CMT-FS-01.DeltaCMT.local\Data /user:DeltaCMT\NFUSCO TESTPASSWORD /persistent:yes & Start L:)

Echo The batch file is complete
exit
