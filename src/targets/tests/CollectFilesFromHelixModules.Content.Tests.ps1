. "$PSScriptRoot/utils/WebConfig.ps1"
. "$PSScriptRoot/utils/MSBuild.ps1"
. "$PSScriptRoot/utils/MSDeploy.ps1"

$fixtures = @{
    default = @{
        Solution = "$PSScriptRoot\fixtures/default/HelixBuild.Sample.Web.sln";
        Project1 = "$PSScriptRoot\fixtures/default/Projects\HelixBuild.Sample.Web\HelixBuild.Sample.Web.csproj";
    }
    
}

$count = 1

Describe "CollectFilesFromHelixModules.Content" {

    Context "collecting helix modules for a project" {
        $projectPath = $fixtures.default.Project1

        $result = Invoke-MSBuildWithOutput -Project $projectPath -TargetName "CollectFilesFromHelixModulesContent" -OutputItem "FilesForPackagingFromHelixModules -> '%(DestinationRelativePath)'"

        Write-Host $result

        It "should include content from module projects" {
            $result -contains "App_Config\Include\HelixBuild.Feature1.config" | Should Be $true
            $result -contains "App_Config\Include\HelixBuild.Foundation1.config" | Should Be $true
        }
    }
}