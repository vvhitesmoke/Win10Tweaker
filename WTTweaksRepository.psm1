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

    static [WTTweakBase[]] GetMatchingTweaks([string]$Name) {
        return [WTTweaksRepository]::_modulesArray.Where({
            ($_.Name -match $Name) -or ($_.Alias -match $Name)
        })
    }

    static [WTTweakBase] GetTweak([string]$Name) {
        return [WTTweaksRepository]::_modulesArray.Where({
            ($_.Name -eq $Name) -or ($_.Alias -eq $Name)
        }, 'First')[0]
    }

    static [void] ShowTweak([WTTweakBase]$tweak) {
        [WTOut]::Print("Name: $($tweak.Name)")
        [WTOut]::Print("Alias: $($tweak.Alias)")
        [WTOut]::Print("Description: $($tweak.Description)")
        [WTOut]::Print("Allowed operations: $($tweak.AllowedOperations)")
        [WTOut]::Print("Categories: $($tweak.Categories -join ', ')`n")
    }

    static [void] ShowTweaksList() {
        [WTTweaksRepository]::_modulesArray.ForEach({
            [WTTweaksRepository]::ShowTweak($_)
        })
    }

    static [int] GetTweaksCount() {
        return [WTTweaksRepository]::_modulesArray.Length
    }
}
