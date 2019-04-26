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

md custom-nupkg\installed\x64-windows\debug\lib
md custom-nupkg\installed\x64-windows\lib
md custom-nupkg\installed\x64-windows\debug\bin
md custom-nupkg\installed\x64-windows\bin
md custom-nupkg\installed\x64-windows\include\hs
md custom-nupkg\_rels

echo copying hs.lib
cp buildtrees\hyperscan\x64-windows-dbg\bin\hs.dll custom-nupkg\installed\x64-windows\debug\bin
cp buildtrees\hyperscan\x64-windows-rel\bin\hs.dll custom-nupkg\installed\x64-windows\bin
cp buildtrees\hyperscan\x64-windows-dbg\lib\hs.lib custom-nupkg\installed\x64-windows\debug\lib
cp buildtrees\hyperscan\x64-windows-rel\lib\hs.lib custom-nupkg\installed\x64-windows\lib
cp buildtrees\hyperscan\src\*\src\*.h custom-nupkg\installed\x64-windows\include\hs
cp ports\hyperscan\'``[Content_Types``].xml' custom-nupkg
cp ports\hyperscan\_rels\.rels custom-nupkg\_rels
cp ports\hyperscan\hyperscan-5.1.1.nuspec custom-nupkg

cd custom-nupkg
Compress-Archive -Path * -DestinationPath ..\hyperscan-5.1.1.zip
cd ..
sleep 60
move hyperscan-5.1.1.zip hyperscan_5_1_1.1.0.2.nupkg
