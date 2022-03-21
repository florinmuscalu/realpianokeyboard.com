@ECHO OFF

rem *********** Search the current folder for html and css files
rem *********** Search folder img for png, ico and jpg files
rem *********** Iterate over the list of files and uplad them to aws, and then set their permission to public
rem *********** Finally invalidate cloudfront distribution

setlocal enabledelayedexpansion
for %%f in (*.html, *.css, img\*.png, img\*.ico, img\*.jpg) do (
  set "f=%%f"
  set "f=!f:\=/!"
  aws s3 cp "%%~f" s3://realpianokeyboard.com/!f!
  aws s3api put-object-acl --bucket realpianokeyboard.com --key !f! --acl public-read
)

aws cloudfront create-invalidation --distribution-id EK190CJSMXW14 --paths "/*"