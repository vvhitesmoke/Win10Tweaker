#########################################
# WinTweaker WTOut class                #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

Using module .\WTConfig.psm1

class WTOut {
    hidden static [int]$_errorsCtr = 0

# Logging/diagnostics
    static [void] Initialize() {
        [WTOut]::_errorsCtr = 0
    }

    static [void] Print([string]$message) {
        if (! [WTConfig]::GetSilentSwitch()) {
            Write-Host $message
        }
    }

    static [void] Fail([string]$message) {
        if (! [WTConfig]::GetSilentSwitch()) {
            [string]$callerName = (Get-PSCallStack)[1].FunctionName
            Write-Error "Fail: $message in: $callerName"
        }
    }

    static [void] Error([string]$message) {
        [WTOut]::_errorsCtr++
        if (! [WTConfig]::GetSilentSwitch()) {
            Write-Host "Error # $([WTOut]::_errorsCtr): $message"
        }
    }

    static [void] Info([string]$message) {
        if (! [WTConfig]::GetSilentSwitch()) {
            Write-Host "Info: $message"
        }
    }

    static [void] Trace([string]$message) {
        if ([WTConfig]::GetVerboseSwitch()) {
            Write-Host "Trace: $message"
        }
    }

    static [int] GetErrorsCount() {
        return [WTOut]::_errorsCtr
    }
}
