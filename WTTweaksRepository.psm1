#########################################
# WinTweaker WTTweaksRepository class   #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTOut.psm1
Using module .\Tweaks\WTTweakBase.psm1

class WTTweaksRepository {
    hidden static [WTTweakBase[]] $_modulesArray = @()

    static [void] Initialize() {
        [WTTweaksRepository]::_modulesArray = @()
    }

    static [void] RegisterTweakModule([string]$TweaksSubDir, [string]$Name) {
        [WTOut]::Trace("Registering: $Name")

        $scriptBody = "Using module .\$TweaksSubDir\$Name.psm1 ; function CreateInstance() { return [$Name]::new() }"
        $script = [ScriptBlock]::Create($scriptBody)
        . $script

        [WTTweakBase]$instance = (CreateInstance) 
        [WTTweaksRepository]::_modulesArray += $instance
    }

    static [WTTweakBase] GetTweakInstance([string]$Name) {
        [WTTweaksRepository]::_modulesArray.ForEach({
            if (($_.Name = $Name) -or ($_.Alias = $Name)) {
                return $_
            }
        })

        return $null
    }

    static [void] ShowTweaksList() {
        [WTTweaksRepository]::_modulesArray.ForEach({
            [WTOut]::Print("Name: $($_.Name)")
            [WTOut]::Print("Alias: $($_.Alias)")
            [WTOut]::Print("Description: $($_.Description)")
            [WTOut]::Print("Allowed operations: $($_.AllowedOperations)`n")
        })
    }

    static [int] GetTweaksCount() {
        return [WTTweaksRepository]::_modulesArray.Length
    }
}
