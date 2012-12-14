:: TODO: Ugh, i had to use ugly loop nesting...
@echo off
echo BUILDING CLRBCLINLUA...
cd ..
echo REMOVING 'BIN' FOLDER
rmdir /s /q bin
mkdir bin
mkdir bin\ClrBclInLua
mkdir bin\ClrBclInLua\System

echo BUILDING CLRBCLINLUA LOADER...
for %%f in (*.lua) do luac %1 -o "bin\ClrBclInLua\%%fc" "%%f"
::del bin\ClrBclInLua\interact.luac

cd System
echo BUILDING FOLDER System
for %%f in (*.lua) do luac %1 -o "..\bin\ClrBclInLua\System\%%fc" "%%f"

for /D %%d in (*) do (
	echo BUILDING FOLDER System\%%d
	mkdir ..\bin\ClrBclInLua\System\%%d
	cd "%%d"
	for %%f in (*.lua) do luac %1 -o "..\..\bin\ClrBclInLua\System\%%d\%%fc" "%%f"

	for /D %%e in (*) do (
		echo BUILDING FOLDER System\%%d\%%e
		mkdir ..\..\bin\ClrBclInLua\System\%%d\%%e
		cd "%%e"
		for %%f in (*.lua) do luac %1 -o "..\..\..\bin\ClrBclInLua\System\%%d\%%e\%%fc" "%%f"
		for /D %%g in (*) do (
			echo BUILDING FOLDER System\%%d/%%e\%%g
			mkdir ..\..\..\bin\ClrBclInLua\System\%%d\%%e\%%g
			cd "%%g"
			for %%f in (*.lua) do luac %1 -o "..\..\..\..\bin\ClrBclInLua\System\%%d\%%e\%%g\%%fc" "%%f"
			cd ..
		)
		cd ..
	)
	cd ..
)

cd ..

echo DONE BUILDING CLRBCLINLUA
PAUSE
