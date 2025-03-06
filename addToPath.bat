@echo off
SET SCRIPT_DIR=%~dp0

REM Check if dockerdu.bat exists in the script directory
IF EXIST "%SCRIPT_DIR%dockerdu.bat" (
    echo Found dockerdu.bat in %SCRIPT_DIR%
    
    REM Check if the script directory is already in the PATH
    echo Checking if the directory is already in the PATH...
    echo %PATH% | findstr /i "%SCRIPT_DIR%" >nul
    IF %ERRORLEVEL% == 0 (
        echo Directory already in PATH: %SCRIPT_DIR%
    ) ELSE (
        echo Adding directory to PATH...
        SETX PATH "%PATH%;%SCRIPT_DIR%"
        echo Directory added to PATH successfully.
    )
) ELSE (
    echo dockerdu.bat not found in %SCRIPT_DIR%. No changes made.
)

pause
