   @echo off
   setlocal EnableDelayedExpansion
   rem Process all .xml files in current directory
   for %%a in (*.XML) do (
  rem Locate the line numbers where "CHANGETIME" and "/ENTRIES" appears
  set "insertLine="
  for /F "delims=:" %%b in ('findstr /N "CHANGETIME /ENTRIES" "%%a"') do (
     if not defined insertLine (
        set "insertLine=%%b"
     ) else (
        set "lastLine=%%b"
     )
  )
  rem Block used to read-input-file/create-output-file
  < "%%a" (
          rem Read the first line from input file
          set /P "line="
          rem Copy lines up to the insertion point
          for /L %%i in (1,1,!insertLine!) do set /P "line=!line!" & echo/
          rem Insert the corresponding REMARK file
          type "H:\soundcheck_test\Soundcheck_dbx\RemarksFolder\%%a"
          rem Copy the rest of lines
          set /A insertLine+=1
          for /L %%i in (!insertLine!,1,!lastLine!) do set /P "line=!line!" & echo/
          ) > "output.tmp"
  rem Block-end
  rem Replace input file with created output file
  move /Y "output.tmp" "%%a" > NULL
   )
