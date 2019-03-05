echo "Starting make-nupkg"
rd -Recurse buildtrees\python3
echo "Deleted python3"
rd -Recurse buildtrees\boost-core
echo "Deleted boost-core"
rd -Recurse buildtrees\hyperscan\x64-windows-static-dbg\bin
echo "Deleted hyperscan dbg bin"
rd -Recurse buildtrees\hyperscan\x64-windows-static-dbg\CMakeFiles
echo "Deleted hyperscan dbg CMakeFiles"
rd -Recurse buildtrees\hyperscan\x64-windows-static-dbg\unit
echo "Deleted hyperscan dbg unit"

md custom-nupkg\installed\x64-windows-static\debug\lib
md custom-nupkg\installed\x64-windows-static\lib
md custom-nupkg\installed\x64-windows-static\include\hs
md custom-nupkg\_rels

echo copying hs.lib
cp buildtrees\hyperscan\x64-windows-static-dbg\lib\hs.lib custom-nupkg\installed\x64-windows-static\debug\lib
cp buildtrees\hyperscan\x64-windows-static-rel\lib\hs.lib custom-nupkg\installed\x64-windows-static\lib
cp buildtrees\hyperscan\src\*\src\*.h custom-nupkg\installed\x64-windows-static\include\hs
cp ports\hyperscan\'``[Content_Types``].xml' custom-nupkg
cp ports\hyperscan\_rels\.rels custom-nupkg\_rels
cp ports\hyperscan\hyperscan-5.1.0.nuspec custom-nupkg

cd custom-nupkg
Compress-Archive -Path * -DestinationPath ..\hyperscan-5.1.0.zip
cd ..
sleep 60
move hyperscan-5.1.0.zip hyperscan-5-1-0.1.0.0.nupkg
