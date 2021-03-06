@echo off

cd C:\projects\caffe\windows

copy CommonSettings.props.example CommonSettings.props

nuget restore Caffe.sln -PackagesDirectory ..\..\NugetPackages -ConfigFile nuget.config

set PATH=%PATH:nuget=hello%

msbuild Caffe.sln /m /v:m /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll" /p:Configuration=Debug;CpuOnlyBuild=true;UseCuDNN=false

msbuild Caffe.sln /m /v:m /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll" /p:Configuration=Release;CpuOnlyBuild=true;UseCuDNN=false;WholeProgramOptimization=false

cd ..

Build\x64\Release\test_all.exe --gtest_filter=-*TestTimer*