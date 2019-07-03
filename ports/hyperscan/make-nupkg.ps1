echo "Starting make-nupkg"
rd -Recurse buildtrees\python3
echo "Deleted python3"
rd -Recurse buildtrees\boost-core
echo "Deleted boost-core"
del buildtrees\hyperscan\x64-windows-dbg\bin\*.exe
del buildtrees\hyperscan\x64-windows-dbg\bin\*.ilk
del buildtrees\hyperscan\x64-windows-dbg\bin\*.pdb
echo "Deleted hyperscan dbg bin"
rd -Recurse buildtrees\hyperscan\x64-windows-dbg\CMakeFiles
echo "Deleted hyperscan dbg CMakeFiles"
rd -Recurse buildtrees\hyperscan\x64-windows-dbg\unit
echo "Deleted hyperscan dbg unit"

md custom-nupkg\build\x64
md custom-nupkg\include\hs
md custom-nupkg\_rels

echo copying hs.lib
cp buildtrees\hyperscan\x64-windows-dbg\bin\hs.dll custom-nupkg\build\x64\hs-gd.dll
cp buildtrees\hyperscan\x64-windows-rel\bin\hs.dll custom-nupkg\build\x64\hs.dll
cp buildtrees\hyperscan\x64-windows-dbg\lib\hs.lib custom-nupkg\build\x64\hs-gd.lib
cp buildtrees\hyperscan\x64-windows-rel\lib\hs.lib custom-nupkg\build\x64\hs.lib
cp buildtrees\hyperscan\x64-windows-dbg\bin\chimera.dll custom-nupkg\build\x64\chimera-gd.dll
cp buildtrees\hyperscan\x64-windows-rel\bin\chimera.dll custom-nupkg\build\x64\chimera.dll
cp buildtrees\hyperscan\x64-windows-dbg\lib\chimera.lib custom-nupkg\build\x64\chimera-gd.lib
cp buildtrees\hyperscan\x64-windows-rel\lib\chimera.lib custom-nupkg\build\x64\chimera.lib
cp buildtrees\hyperscan\src\*\src\*.h custom-nupkg\include\hs
cp buildtrees\hyperscan\src\*\chimera\*.h custom-nupkg\include\hs
cp ports\hyperscan\'``[Content_Types``].xml' custom-nupkg
cp ports\hyperscan\_rels\.rels custom-nupkg\_rels
cp ports\hyperscan\hyperscan_5_1_1.targets custom-nupkg\build
cp ports\hyperscan\hyperscan-5.1.1.nuspec custom-nupkg

cd custom-nupkg
Compress-Archive -Path * -DestinationPath ..\hyperscan-5.1.1.zip
cd ..
sleep 60
move hyperscan-5.1.1.zip hyperscan_5_1_1.1.0.7.nupkg
