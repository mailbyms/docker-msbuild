# 说明
- Visual Studio 对应的 MSBuild 工具，.net 编译工具。参考了：<https://github.com/compulim/docker-msbuild>

- 可以编译 `.NET Framework`, `.NET Core`, `C#`, `F#`, `C++`, and `web` 项目。预装了 `Nuget 6.0.0`，`.NET Framework SDK 4.7.2`。编译项目前，要修改项目的 .csproj 文件，把 `TargetFrameworkVersion` 改为 `v4.7.2`

- 预装工具说明见：<https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools>.

- NuGet 的配置文件在 `%appdata%\NuGet\NuGet.Config`， 可以修改为自定义的源。其它配置项见 <https://docs.microsoft.com/zh-cn/nuget/consume-packages/configuring-nuget-behavior>

# 独立运行
`docker run --rm -it -v c:\src:c:\src mailbyms/msbuild:2019 cmd `

# drone 流水线配置
> 一般此镜像只作为基础镜像，项目使用此镜像之上另外集成 sonar-scanner 的 `mailbyms/msbuild-sonar:2019`

```
steps:
  - name: 编译及 Sonar 代码分析
    image: mailbyms/msbuild:2019
    pull: if-not-exists
    commands:
      - (Get-Content xxx.csproj) -replace "TargetFrameworkVersion>v4.6.2<","TargetFrameworkVersion>v4.7.2<" | Set-Content xxx.csproj
      - nuget restore
      - MSBuild.exe  /t:Rebuild
```
