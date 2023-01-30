#########################################
# WinTweaker WTOut class                #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

class WTOut {
    hidden static [bool]$_verbose = $false
    hidden static [bool]$_silent  = $false

    hidden static [int]$_errorsCtr = 0

    static [void] Initialize([bool]$verbose, [bool]$silent) {
        if ($silent) {
            $verbose = $false
        }

        [WTOut]::_verbose   = $verbose
        [WTOut]::_silent    = $silent
        [WTOut]::_errorsCtr = 0
    }

# Logging/diagnostics
    static [void] Print([string]$message) {
        if (! [WTOut]::_silent) {
            Write-Host $message
        }
    }

    static [void] Fail([string]$message) {
        if (! [WTOut]::_silent) {
            [string]$callerName = (Get-PSCallStack)[1].FunctionName
            Write-Error "Fail: $message in: $callerName" -ForegroundColor Red
        }
    }

    static [void] Error([string]$message) {
        [WTOut]::_errorsCtr++
        if (! [WTOut]::_silent) {
            Write-Host "Error #$([WTOut]::_errorsCtr): $message" -ForegroundColor Red
        }
    }

    static [void] Info([string]$message) {
        if (! [WTOut]::_silent) {
            Write-Host "Info: $message" -ForegroundColor Green
        }
    }

    static [void] Trace([string]$message) {
        if ([WTOut]::_verbose) {
            Write-Host "Trace: $message" -ForegroundColor Cyan
        }
    }

    static [int] GetErrorsCount() {
        return [WTOut]::_errorsCtr
    }
}
