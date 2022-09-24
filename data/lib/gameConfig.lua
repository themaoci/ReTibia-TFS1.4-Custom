GameConfig = {
  ['sharedExpPercentage'] = 1.2,
  ['autoGhostStaffMembers'] = true,
  ["God"] = {
    ['WelcomeMessageEnabled'] = false,
    ['WelcomeMessageCommands'] = [[
-- COMMANDS --
/ban {username},{reason},{time in days}
/banid - works the same as /ban without time
/i {itemId},{amount}
-- COMMANDS --
]]
  }, 
  ["Tutor"] = {
    ['WelcomeMessageEnabled'] = false,
    ['WelcomeMessageRules'] = [[ Tutor Rules
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
  },
  ['StartItems'] = {
      --club, coat
      items = {{2175, 1}},
      --container rope, shovel, red apple
      container = {{2674, 2}}
  },
  ['PremiumTile'] = {
    StepInActionId = 50241,
    kickEffect = CONST_ME_MAGIC_BLUE,
    kickMsg = "Only noble citizens can pass, get your premium account on our website!",
    enterMsg = "Welcome to a premium area!",
    enterEffect = CONST_ME_MAGIC_BLUE
  },
  ['LevelTile'] = {
    TileStepOut = 446,
    TileStepIn = 447,
    kickMsg = "Only players with level %s and above may leave the town!"
  },
  ["Vocations"] = {
    ["warrior"] = {
      text = "You have been blessed by ▒▒▒ ▒▒ and now you can call yourself a Warrior!",
      vocationId = 2,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 50}, -- health potion
        {7620, 10}, -- mana potion
        {2152, 20}  -- platinum coins
      }
    },		
    ["rogue"] = {
      text = "You have been blessed by ▒▒▒ ▒▒ and now you can call yourself a Rogue!",
      vocationId = 4,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 55}, -- health potion
        {7620, 5}, -- mana potion
        {2152, 40}  -- platinum coins
      }
    },
    ["mage"] = {
      text = "You have been blessed by ▒▒▒ ▒▒ and now you can call yourself a Mage!",
      vocationId = 3,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 10}, -- health potion
        {7620, 50}, -- mana potion
        {2152, 30}  -- platinum coins
      }
    },
    ["all_rounder"] = {
      text = "You have been blessed by ▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒ and now you can call yourself a All Rounder!",
      vocationId = 1,
      --equipment
      {
      },
      --container
      {
        {2120, 1},  -- rope
        {2554, 1},  -- shovel
        {7618, 30}, -- health potion
        {7620, 30}, -- mana potion
        {2152, 100} -- platinum coins
      }
    }
  },
  ["BuySpellsList"] = {
    {group="attack", price=20000, spellid="62", name="Annihilation", words="exori gran ico", level="110", premium="1", needlearn="1" },
    {group="attack", price=0, spellid="169", name="Apprentice's Strike", words="exori min flam", level="8", premium="0", needlearn="0" },
    {group="attack", price=2500, spellid="80", name="Berserk", words="exori", level="35", premium="1", needlearn="1" },
    {group="attack", price=1000, spellid="61", name="Brutal Strike", words="exori ico", level="16", premium="1", needlearn="1" },
    {group="attack", price=0, spellid="177", name="Buzz", words="exori infir vis", level="1", premium="0", needlearn="0" },
    {group="attack", price=0, spellid="173", name="Chill Out", words="exevo infir frigo hur", level="1", needlearn="0" },
    {group="attack", price=6000, spellid="139", name="Curse", words="utori mort", level="75", premium="1", needlearn="1" },
    {group="attack", price=800, spellid="87", name="Death Strike", words="exori mort", level="16", premium="1", needlearn="1" },
    {group="attack", price=3000, spellid="124", name="Divine Caldera", words="exevo mas san", level="50", premium="1", needlearn="1" },
    {group="attack", price=1800, spellid="122", name="Divine Missile", words="exori san", level="40", premium="1", needlearn="1" },
    {group="attack", price=2500, spellid="140", name="Electrify", words="utori vis", level="34", premium="1", needlearn="1" },
    {group="attack", price=1000, spellid="22", name="Energy Beam", words="exevo vis lux", level="23", needlearn="1" },
    {group="attack", price=800, spellid="88", name="Energy Strike", words="exori vis", level="12", premium="1", needlearn="1" },
    {group="attack", price=2500, spellid="13", name="Energy Wave", words="exevo vis hur", level="38", needlearn="1" },
    {group="attack", price=6000, spellid="142", name="Envenom", words="utori pox", level="50", premium="1", needlearn="1" },
    {group="attack", price=8000, spellid="118", name="Eternal Winter", words="exevo gran mas frigo", level="60", premium="1", needlearn="1" },
    {group="attack", price=1100, spellid="111", name="Ethereal Spear", words="exori con", level="23", premium="1", needlearn="1" },
    {group="attack", price=7500, spellid="105", name="Fierce Berserk", words="exori gran", level="90", premium="1", needlearn="1" },
    {group="attack", price=850, spellid="19", name="Fire Wave", words="exevo flam hur", level="18", needlearn="1" },
    {group="attack", price=800, spellid="89", name="Flame Strike", words="exori flam", level="14", premium="1", needlearn="1" },
    {group="attack", price=4000, spellid="59", name="Front Sweep", words="exori min", level="70", premium="1", needlearn="1" },
    {group="attack", price=1800, spellid="23", name="Great Energy Beam", words="exevo gran vis lux", level="29", needlearn="1" },
    {group="attack", price=1500, spellid="106", name="Groundshaker", words="exori mas", level="33", premium="1", needlearn="1" },
    {group="attack", price=8000, spellid="24", name="Hell's Core", words="exevo gran mas flam", level="60", premium="1", needlearn="1" },
    {group="attack", price=7500, spellid="143", name="Holy Flash", words="utori san", level="70", premium="1", needlearn="1" },
    {group="attack", price=800, spellid="112", name="Ice Strike", words="exori frigo", level="15", premium="1", needlearn="10" },
    {group="attack", price=850, spellid="121", name="Ice Wave", words="exevo frigo hur", level="18", needlearn="1" },
    {group="attack", price=1500, spellid="138", name="Ignite", words="utori flam", level="26", premium="1", needlearn="1" },
    {group="attack", price=2500, spellid="141", name="Inflict Wound", words="utori kor", level="40", premium="1", needlearn="1" },
    {group="attack", price=5000, spellid="149", name="Lightning", words="exori amp vis", level="55", premium="1", needlearn="1" },
    {group="attack", price=0, spellid="172", name="Mud Attack", words="exori infir tera", level="1", premium="0", needlearn="0" },
    {group="attack", price=800, spellid="148", name="Physical Strike", words="exori moe ico", level="16", premium="1", needlearn="1" },
    {group="attack", price=0, spellid="167", name="Practice Fire Wave", words="exevo dis flam hur", level="1", needlearn="0" },
    {group="attack", price=6000, spellid="119", name="Rage of the Skies", words="exevo gran mas vis", level="55", premium="1", needlearn="1" },
    {group="attack", price=0, spellid="178", name="Scorch", words="exevo infir flam hur", level="1", needlearn="0" },
    {group="attack", price=7500, spellid="151", name="Strong Energy Strike", words="exori gran vis", level="80", premium="1", needlearn="1" },
    {group="attack", price=10000, spellid="57", name="Strong Ethereal Spear", words="exori gran con", level="90", premium="1", needlearn="1" },
    {group="attack", price=6000, spellid="150", name="Strong Flame Strike", words="exori gran flam", level="70", premium="1", needlearn="1" },
    {group="attack", price=6000, spellid="152", name="Strong Ice Strike", words="exori gran frigo", level="80", premium="1", needlearn="1" },
    {group="attack", price=7500, spellid="43", name="Strong Ice Wave", words="exevo gran frigo hur", level="40", premium="1", needlearn="1" },
    {group="attack", price=6000, spellid="153", name="Strong Terra Strike", words="exori gran tera", level="70", premium="1", needlearn="1" },
    {group="attack", price=800, spellid="113", name="Terra Strike", words="exori tera", level="13", premium="1", needlearn="1" },
    {group="attack", price=2500, spellid="120", name="Terra Wave", words="exevo tera hur", level="38", needlearn="1" },
    {group="attack", price=15000, spellid="155", name="Ultimate Energy Strike", words="exori max vis", level="100", premium="1", needlearn="1" },
    {group="attack", price=15000, spellid="154", name="Ultimate Flame Strike", words="exori max flam", level="90", premium="1", needlearn="1" },
    {group="attack", price=15000, spellid="156", name="Ultimate Ice Strike", words="exori max frigo", level="100", premium="1", needlearn="1" },
    {group="attack", price=15000, spellid="157", name="Ultimate Terra Strike", words="exori max tera", level="90", premium="1", needlearn="1" },
    {group="attack", price=1500, spellid="107", name="Whirlwind Throw", words="exori hur", level="28", premium="1", needlearn="1" },
    {group="attack", price=6000, spellid="56", name="Wrath of Nature", words="exevo gran mas tera", level="55", premium="1", needlearn="1" },
    {group="healing", price=0, spellid="175", name="Bruise Bane", words="exura infir ico", level="1", needlearn="0" },
    {group="healing", price=2500, spellid="144", name="Cure Bleeding", words="exana kor", level="45", premium="1", needlearn="1" },
    {group="healing", price=2000, spellid="145", name="Cure Burning", words="exana flam", level="30", premium="1", needlearn="1" },
    {group="healing", price=6000, spellid="147", name="Cure Curse", words="exana mort", level="80", premium="1", needlearn="1" },
    {group="healing", price=1000, spellid="146", name="Cure Electrification", words="exana vis", level="22", premium="1", needlearn="1" },
    {group="healing", price=150, spellid="29", name="Cure Poison", words="exana pox", level="10", needlearn="1" },
    {group="healing", price=3000, spellid="125", name="Divine Healing", words="exura san", level="35", premium="0", needlearn="1" },
    {group="healing", price=800, spellid="84", name="Heal Friend", words="exura sio", level="18", premium="1", needlearn="1" },
    {group="healing", price=350, spellid="2", name="Intense Healing", words="exura gran", level="20", needlearn="1" },
    {group="healing", price=10000, spellid="160", name="Intense Recovery", words="utura gran", level="100", premium="1", needlearn="1" },
    {group="healing", price=6000, spellid="158", name="Intense Wound Cleansing", words="exura gran ico", level="80", premium="1", needlearn="1" },
    {group="healing", price=0, spellid="1", name="Light Healing", words="exura", level="8", needlearn="0" },
    {group="healing", price=0, spellid="174", name="Magic Patch", words="exura infir", level="1", needlearn="0" },
    {group="healing", price=2200, spellid="82", name="Mass Healing", words="exura gran mas res", level="36", premium="1", needlearn="1" },
    {group="healing", price=0, spellid="166", name="Practice Healing", words="exura dis", level="1", needlearn="0" },
    {group="healing", price=4000, spellid="159", name="Recovery", words="utura", level="50", premium="1", needlearn="1" },
    {group="healing", price=8000, spellid="36", name="Salvation", words="exura gran san", level="60", premium="1", needlearn="1" },
    {group="healing", price=1000, spellid="3", name="Ultimate Healing", words="exura vita", level="30", needlearn="1" },
    {group="healing", price=0, spellid="123", name="Wound Cleansing", words="exura ico", level="8", premium="0", needlearn="0" },
    {group="support", price=8000, spellid="133", name="Blood Rage", words="utito tempo", level="60", premium="1", needlearn="1" },
    {group="support", price=1600, spellid="90", name="Cancel Invisibility", words="exana ina", level="26", premium="1", needlearn="1" },
    {group="support", price=2000, spellid="93", name="Challenge", words="exeta res", level="20", premium="1", needlearn="1" },
    {group="support", price=1300, spellid="131", name="Charge", words="utani tempo hur", level="25", premium="1", needlearn="1" },
    {group="support", price=1000, spellid="38", name="Creature Illusion", words="utevo res ina", level="23", needlearn="1" },
    {group="support", price=1000, spellid="20", name="Find Person", words="exiva", level="8", needlearn="1" },
    {group="support", price=300, spellid="42", name="Food", words="exevo pan", level="14", needlearn="1" },
    {group="support", price=500, spellid="11", name="Great Light", words="utevo gran lux", level="13", needlearn="1" },
    {group="support", price=600, spellid="6", name="Haste", words="utani hur", level="14", premium="1", needlearn="1" },
    {group="support", price=2000, spellid="45", name="Invisibility", words="utana vid", level="35", needlearn="1" },
    {group="support", price=500, spellid="81", name="Levitate", words="exani hur", level="12", premium="1", needlearn="1" },
    {group="support", price=0, spellid="10", name="Light", words="utevo lux", level="8", needlearn="1" },
    {group="support", price=200, spellid="76", name="Magic Rope", words="exani tera", level="9", premium="1", needlearn="1" },
    {group="support", price=450, spellid="44", name="Magic Shield", words="utamo vita", level="14", needlearn="1" },
    {group="support", price=6000, spellid="132", name="Protector", words="utamo tempo", level="55", premium="1", needlearn="1" },
    {group="support", price=8000, spellid="135", name="Sharpshooter", words="utito tempo san", level="60", premium="1", needlearn="1" },
    {group="support", price=1300, spellid="39", name="Strong Haste", words="utani gran hur", level="20", premium="1", needlearn="1" },
    {group="support", price=2000, spellid="9", name="Summon Creature", words="utevo res", level="25", needlearn="1" },
    {group="support", price=6000, spellid="134", name="Swift Foot", words="utamo tempo san", level="55", premium="1", needlearn="1" },
    {group="support", price=1600, spellid="75", name="Ultimate Light", words="utevo vis lux", level="26", premium="1", needlearn="1" },
    {group="support", price=4000, spellid="129", name="Enchant Party", words="utori mas sio", level="32", premium="1", needlearn="1" },
    {group="support", price=4000, spellid="128", name="Heal Party", words="utura mas sio", level="32", premium="1", needlearn="1" },
    {group="support", price=4000, spellid="127", name="Protect Party", words="utamo mas sio", level="32", premium="1", needlearn="1" },
    {group="support", price=4000, spellid="126", name="Train Party", words="utito mas sio", level="32", premium="1", needlearn="1" },
    {group="support", price=0, spellid="176", name="Arrow Call", words="exevo infir con", level="1", premium="0", needlearn="1" },
    {group="support", price=1200, name="Animate Dead Rune", words="adana mort", level="27", premium="1", needlearn="1" },
    {group="support", price=1200, name="Avalanche Rune", words="adori mas frigo", level="30", needlearn="1" },
    {group="support", price=0, name="Blank Rune", words="adori blank", level="5", magiclevel="1", needlearn="1" },
    {group="support", price=1300, name="Chameleon Rune", words="adevo ina", level="27", needlearn="1" },
    {group="support", price=450, spellid="51", name="Conjure Arrow", words="exevo con", level="13", premium="0", needlearn="1" },
    {group="support", price=450, spellid="79", name="Conjure Bolt", words="exevo con mort", level="17", premium="1", needlearn="1" },
    {group="support", price=1000, spellid="49", name="Conjure Explosive Arrow", words="exevo con flam", level="25", premium="0", needlearn="1" },
    {group="support", price=1000, spellid="109", name="Conjure Piercing Bolt", words="exevo con grav", level="33", premium="1", needlearn="1" },
    {group="support", price=1000, spellid="48", name="Conjure Poisoned Arrow", words="exevo con pox", level="16", premium="0", needlearn="1" },
    {group="support", price=1000, spellid="95", name="Conjure Power Bolt", words="exevo con vis", level="59", premium="1", needlearn="1" },
    {group="support", price=1000, spellid="108", name="Conjure Sniper Arrow", words="exevo con hur", level="24", premium="1", needlearn="1" },
    {group="support", price=800, name="Convince Creature Rune", words="adeta sio", level="16", needlearn="1" },
    {group="support", price=600, name="Cure Poison Rune", words="adana pox", level="15", needlearn="1" },
    {group="support", price=700, name="Destroy Field Rune", words="adito grav", level="17", needlearn="1" },
    {group="support", price=900, name="Disintegrate Rune", words="adito tera", level="21", premium="1", needlearn="1" },
    {group="support", price=2000, spellid="110", name="Enchant Spear", words="exeta con", level="45", premium="1", needlearn="1" },
    {group="support", price=2000, spellid="92", name="Enchant Staff", words="exeta vis", level="41", premium="1", needlearn="1" },
    {group="support", price=2300, name="Energy Bomb Rune", words="adevo mas vis", level="37", premium="1", needlearn="1" },
    {group="support", price=700, name="Energy Field Rune", words="adevo grav vis", level="18", needlearn="1" },
    {group="support", price=2500, name="Energy Wall Rune", words="adevo mas grav vis", level="41", needlearn="1" },
    {group="support", price=1800, name="Explosion Rune", words="adevo mas hur", level="31", needlearn="1" },
    {group="support", price=1500, name="Fire Bomb Rune", words="adevo mas flam", level="27", needlearn="1" },
    {group="support", price=500, name="Fire Field Rune", words="adevo grav flam", level="15", needlearn="1" },
    {group="support", price=2000, name="Fire Wall Rune", words="adevo mas grav flam", level="33", needlearn="1" },
    {group="support", price=1600, name="Fireball Rune", words="adori flam", level="27", premium="1", needlearn="1" },
    {group="support", price=1200, name="Great Fireball Rune", words="adori mas flam", level="30", needlearn="1" },
    {group="support", price=1500, name="Heavy Magic Missile Rune", words="adori vis", level="25", needlearn="1" },
    {group="support", price=1600, name="Holy Missile Rune", words="adori san", level="27", premium="1", needlearn="1" },
    {group="support", price=1700, name="Icicle Rune", words="adori frigo", level="28", premium="1", needlearn="1" },
    {group="support", price=600, name="Intense Healing Rune", words="adura gran", level="15", needlearn="1" },
    {group="support", price=500, name="Light Magic Missile Rune", words="adori min vis", level="15", needlearn="1" },
    {group="support", price=500, name="Light Stone Shower Rune", words="adori infir mas tera", level="1", premium="1", needlearn="1" },
    {group="support", price=450, name="Lightest Missile Rune", words="adori infir vis", level="1", needlearn="1" },
    {group="support", price=2100, name="Magic Wall Rune", words="adevo grav tera", level="32", premium="1", needlearn="1" },
    {group="support", price=1900, name="Paralyze Rune", words="adana ani", level="54", premium="1", needlearn="1" },
    {group="support", price=1000, name="Poison Bomb Rune", words="adevo mas pox", level="25", premium="1", needlearn="1" },
    {group="support", price=300, name="Poison Field Rune", words="adevo grav pox", level="14", needlearn="1" },
    {group="support", price=1600, name="Poison Wall Rune", words="adevo mas grav pox", level="29", needlearn="1" },
    {group="support", price=0, name="Practice Magic Missile Rune", words="adori dis min vis", level="1", needlearn="0" },
    {group="support", price=1800, name="Soulfire Rune", words="adevo res flam", level="27", premium="1", needlearn="1" },
    {group="support", price=1400, name="Stalagmite Rune", words="adori tera", level="24", premium="0", needlearn="1" },
    {group="support", price=1100, name="Stone Shower Rune", words="adori mas tera", level="28", premium="1", needlearn="1" },
    {group="support", price=3000, name="Sudden Death Rune", words="adori gran mort", level="45", needlearn="1" },
    {group="support", price=1100, name="Thunderstorm Rune", words="adori mas vis", level="28", premium="1", needlearn="1" },
    {group="support", price=1500, name="Ultimate Healing Rune", words="adura vita", level="24", needlearn="1" },
    {group="support", price=2000, name="Wild Growth Rune", words="adevo grav vita", level="27", premium="1", needlearn="1" }
  }
}