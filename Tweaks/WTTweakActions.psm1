#########################################
# WinTweaker WTTweakActions enum        #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

[Flags()] enum WTTweakActions {
    Invalid = -1
    None    =  0
    Enable  =  1
    Disable =  2
    Add     =  4
    Remove  =  8
    SetLow  = 16
    SetHigh = 32
}
