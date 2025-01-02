@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 获取当前目录
set "currentDir=%cd%"

:: 循环当前目录下的所有文件夹
for /d %%D in (*) do (
    :: 获取文件夹名的第一个字母
    set "folderName=%%~nxD"
    set "firstLetter=!folderName:~0,1!"

    :: 检查文件夹名是否是单字母命名，如果是则跳过
    if "!folderName!" neq "!firstLetter!" (
        :: 将第一个字母转换为小写（如有需要）
        for %%A in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
            if /I "!firstLetter!"=="%%A" set "firstLetter=%%A"
        )

        :: 创建目标文件夹（如果不存在）
        if not exist "!currentDir!\!firstLetter!" (
            mkdir "!currentDir!\!firstLetter!"
        )

        :: 移动文件夹到相应的字母文件夹中
        move "!currentDir!\%%D" "!currentDir!\!firstLetter!\"
		echo move "!currentDir!\%%D"
    )
)

echo 文件夹分类完成
pause
