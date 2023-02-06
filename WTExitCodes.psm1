#########################################
# WinTweaker WTExitCodes class          #
# created at: 2023-01-29                #
# author: Piotr Gludkowski, VillageTech #
#########################################

class WTExitCodes {
    static [int]$Success                 = 0
    static [int]$ArgsError               = 1
    static [int]$InsufficientRights      = 2
    static [int]$RecipeNotFound          = 11
    static [int]$RecipeFormatError       = 12
    static [int]$TweakNotFound           = 13
    static [int]$InvalidOperation        = 14
    static [int]$OtherError              = 100
}
