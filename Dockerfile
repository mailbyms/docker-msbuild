# Read servercore images from: https://hub.docker.com/_/microsoft-windows-servercore
# image's os version should be earlier than host machine. My host PC is windows 10 1903

# docker build -t mailbyms/msbuild:2019 .

FROM mcr.microsoft.com/windows/servercore:ltsc2019
LABEL maintainer=mailbyms@gmail.com description="MSBuild 2019"

ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\\Downloads\\vs_buildtools.exe
ADD https://dist.nuget.org/win-x86-commandline/v6.0.0/nuget.exe C:\\Nuget\\nuget.exe

RUN C:\\Downloads\\vs_buildtools.exe --add Microsoft.VisualStudio.Workload.MSBuildTools --add Microsoft.VisualStudio.Workload.NetCoreBuildTools --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Workload.WebBuildTools --quiet --wait
RUN SETX /M Path "%Path%;C:\\Nuget;C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\MSBuild\\Current\\Bin"