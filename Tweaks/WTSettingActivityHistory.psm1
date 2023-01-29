#############################################
# WinTweaker WTSettingActivityHistory class #
# created at: 2023-01-27                    #
# author: Piotr Gludkowski, VillageTech     #
#############################################

Using module .\WTTweakBase.psm1

class WTSettingActivityHistory : WTTweakBase {
    WTSettingActivityHistory() {
        $this.Name        = "SettingActivityHistory"
        $this.Alias       = "ActivityHistory"
        $this.Description = "Activity History feed in Task View"
        $this.AllowedOperations = @( "Enable", "Disable" )
    }

    [bool]EnableTweak() {
        # ActivityHistory
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -ErrorAction SilentlyContinue
	    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -ErrorAction SilentlyContinue
        
        return $true
    }

    [bool]DisableTweak() {
        # ActivityHistory
    	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
	    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
    	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
        
        return $true
    }
}
