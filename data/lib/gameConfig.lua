GameConfig = {}

GameConfig['sharedExpPercentage'] = 1.2
GameConfig['autoGhostStaffMembers'] = true

GameConfig['Tutor'] = {}
GameConfig.Tutor['WelcomeMessageRules'] = [[ Tutor Rules
1 *> 3 Warnings you lose the job.
2 *> Without parallel conversations with players in Help, if the player starts offending, you simply mute it.
3 *> Be educated with the players in Help and especially in the Private, try to help as much as possible.
4 *> Always be on time, if you do not have a justification you will be removed from the staff.
5 *> Help is only allowed to ask questions related to tibia.
6 *> It is not allowed to divulge time up or to help in quest.
7 *> You are not allowed to sell items in the Help.
8 *> If the player encounters a bug, ask to go to the website to send a ticket and explain in detail.
9 *> Always keep the Tutors Chat open. (required).
10 *> You have finished your schedule, you have no tutor online, you communicate with some CM in-game or ts and stay in the help until someone logs in, if you can.
11 *> Always keep a good Portuguese in the Help, we want tutors who support, not that they speak a satanic ritual.
12 *> If you see a tutor doing something that violates the rules, take a print and send it to your superiors. "
- Commands -
Mute Player: /mute nick, 90. (90 seconds)
Unmute Player: /unmute nick.
- Commands -]]

GameConfig['God'] = {}
GameConfig.God['WelcomeMessageCommands'] = [[
-- COMMANDS --
/ban {username},{reason},{time in days}
/banid - works the same as /ban without time
/i {itemId},{amount}
-- COMMANDS --
]]

GameConfig['StartItems'] = {
    --club, coat
    items = {{2175, 1}},
    --container rope, shovel, red apple
    container = {{2674, 2}}
}


GameConfig['PremiumTile'] = {
  StepInActionId = 50241,
  kickEffect = CONST_ME_MAGIC_BLUE,
  kickMsg = "Only noble citizens can pass, get your premium account on our website!",
  enterMsg = "Welcome to a premium area!",
  enterEffect = CONST_ME_MAGIC_BLUE
}

GameConfig['LevelTile'] = {
  TileStepOut = 446,
  TileStepIn = 447,
  kickMsg = "Only players with level %s and above may leave the town!"
}