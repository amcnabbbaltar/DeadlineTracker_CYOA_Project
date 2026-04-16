// DEADline Tracker v4.0.0
// Converted from SugarCube passages to Ink (no JavaScript).
// Notes:
// - All SugarCube macros (<<set>>, <<if>>, <<timelink>>, etc.) are translated into Ink variables, conditionals, and choices.
// - HTML/CSS/JS passages are omitted or converted to plain text.
// - “timelink” cost is implemented by adding minutes to VAR time when a choice is selected.
// - Time is tracked in minutes since 12:00 AM. Story anchors to 12:15 AM via time = 15. Deadline defaults to 300 (5:00 AM).

// -----------------------------
// GLOBALS (StoryInit equivalents)
// -----------------------------
VAR deadline = 300
VAR time = 15

VAR goalMode = ""
VAR hasTimebox = false
VAR markedPath = false
VAR routePlan = ""
VAR routeChoice = ""
VAR tRoute = ""
VAR planHasBuffer = false

VAR pageDamaged = false
VAR cemPreserved = false
VAR agendaDamaged = false
VAR agendaBackup = ""           // "cloud" | "desktop" | "none" | ""
VAR goalStatement = ""
VAR goalsQuality = ""
VAR planStyle = ""              // "cloud" | "paper" | "desktop" | "memory" | ""
VAR malikPlanDecided = false
VAR malikHuddleIntent = ""
VAR malikPlanChoice = ""        // "steady" | "rush" | "co_plan" | ""

VAR honestyCount = 0
VAR projectTruth = ""
VAR groupPlan = ""
VAR feedbackTruth = ""
VAR feedbackPlan = ""
VAR feedbackApplied = false
VAR essayHonest = false

VAR mondayPlan = ""

VAR careKit = false
VAR scanBackups = false
VAR photoPrep = false

VAR loreCemetery = false
VAR loreTunnels = 0
VAR loreAgnes = 0
VAR clueChalk = false

VAR organization = 0
VAR relationshipMalik = 0
VAR tidiness = 0
VAR bravery = 0
VAR respect = 0
VAR phoneIntegrity = 2

VAR hudEnabled = true
VAR hudPrinciples = true

VAR hubVisits = 0

VAR overheadTunnelApplied = false
VAR overheadCemeteryApplied = false
VAR overheadArchivesApplied = false

VAR taskTunnelsDone = false
VAR taskCemeteryDone = false
VAR tasksCompleted = 0

VAR archiveDocsRough = false
VAR archiveTimeThin = false
VAR archiveRushed = false
VAR cemeteryRushed = false

VAR tunnelStartTime = 0
VAR cemStartTime = 0
VAR archStartTime = 0

VAR cemStartChoice = ""
VAR cemStartPickTime = 0
VAR cemRouteStart = 0

VAR tPressStart = 0
VAR agendaSecureStart = 0

VAR introBelief = ""
VAR introLowChoice = ""
VAR stress = 0
// one-off flags
VAR _introAnchored = false
-> Intro_Library_01
// -----------------------------
// HELPERS (Ink functions only)
// -----------------------------

=== function Clamp0(x) ===
~ temp s=0 
{x > 0:
      ~ s = x
}
~ return s
=== function Pad2(n) ===
~ temp s = "" + n
{ n < 10:
  ~ s = "0" + n
}
~ return s

=== function FormatClock(mins) ===
~ temp m = mins
~ temp h24 = (m / 60) % 24
~ temp mm = m % 60
~ temp ap = ""
{ h24 < 12:
    ~ ap = "AM"
- else:
    ~ ap = "PM"
}
~ temp h12 = h24 % 12
{ h12 == 0:
  ~ h12 = 12
}
~ return "" + h12 + ":" + Pad2(mm) + " " + ap

=== function FormatHMM(mins) ===
~ temp x = Clamp0(mins)
~ temp h = x / 60
~ temp m = x % 60
~ return "" + h + "h " + Pad2(m) + "m"

=== function HUDLine() ===
~ temp s = ""
{ hudEnabled:
    ~ s = "⏳ Time " + FormatClock(time) + " • Remaining " + FormatHMM(deadline - time)
}
~ return s

// -----------------------------
// START
// -----------------------------
-> Intro_Library_01

// -----------------------------
// INTRO
// -----------------------------

=== Intro_Library_01 ===
# background:backgrounds/library-1
# character:character/mc
It's just past midnight in mid-December, and Montreal feels suspended between seasons. Snow falls too softly to look real, the kind that deadens sound. 
Inside Vanier Library, lights hum the way they do when most people have gone home.
 + [Continue] -> Intro_Library_02
=== Intro_Library_02 ===
 It stays open all night for exams.
 # character:character/malik
 You and your friend, Malik, have been here for hours, trying to finish a project that still feels too big. Study lamps pool light over scattered tables, and a couple students doze with earbuds in.
+ [Continue] -> Intro_Library_03
=== Intro_Library_03 === 
# character:character/mc
Your first college semester was rough. You and Malik missed too many deadlines, and your class averages are dangerously low. 
You tried to get organized, but things kept sliding.
+ [Continue] -> Intro_Library_04
=== Intro_Library_04 === 
It looked like you could hold it together, but this last week has been a disaster. 
The group oral on behavior change went badly.
+ [Continue] -> Intro_Library_05
=== Intro_Library_05 === 
# character:character/mc
You took the extra section, the whole thing fell apart, and the rest of the team is upset.
+ [Continue] -> Intro_Library_06
=== Intro_Library_06 ===
Tonight's mission is supposed to be simple. Finish your self-improvement essay for psychology.
 The teacher gave you a chance. The individual reflections now carry more weight, and the group penalty only lifts if everyone passes.
 + [Continue] -> Intro_Library_08
=== Intro_Library_08 ===
  Malik already submitted his reflection, but yours is the one that can save the group. 
  You've been writing the version you wished were true, but you know it's not nearly good enough. 
  If this paper collapses, your psych class collapses, and academic probation isn't a threat. It's next semester.
+ [Continue] -> Intro_Library_07
=== Intro_Library_07 ===
 # character:character/malik
"One all-nighter," Malik says, tired. "If we sound organized, they’ll buy it, right? Maybe?"
+ [Continue] -> Intro_Library_08
=== Intro_Library_08 ===
 # character:character/mc
He keeps it light, but you hear the guilt. He was the one who asked you to take the extra section of the presentation.

You check the time without wanting to. The minutes keep moving while you feel stuck.

{HUDLine}

+ [Continue] -> Intro_Cold_Flicker_07

=== Intro_Cold_Flicker_07 ===
# background:backgrounds/library-5
Suddenly the library shifts. The vents hush. The heat seeps away from the room. Fluorescents flicker once, then settle into a sickly yellow.

A draft moves through the stacks, colder than it should be. It smells like candle smoke and old wax. Somewhere in the dark, a book falls, loud enough to make you and Malik flinch. A few students glance up from their screens, then pack up and slip out without a word.
 # character:character/malik
"People swear this place gets weird after midnight," Malik says low. "Maybe we outline fast and bounce."

You slide your planner into your backpack. It feels heavier than before.

The aisle stretches in both directions. One way is the exit, the other leads to the circulation desk by the heating vents.

What do you do?

{HUDLine}

+ [Grab Malik and hurry for the exit] 
  ~ introLowChoice = "exit"
  -> Intro_Rush_Stairs
+ [Hold your ground and tell Malik to breathe]
  ~ introLowChoice = "steady"
  -> Intro_Settle_Stacks

=== Intro_Rush_Stairs ===
# background:backgrounds/library-9
 # character:character/malik
You hook a hand in Malik’s sleeve and hustle toward the stairwell. Your boots squeak against the marble. The air grows colder the closer you get, as if the building is inhaling. Halfway there, the lights snap off, one row at a time, until only the aisle behind you glows.

"Okay…maybe the rumors weren’t a joke," Malik whispers.

The darkness pulses once more, then holds still. Something waits between the stacks just ahead.

{HUDLine}

+ [Continue] -> Intro_Agnes_Appears

=== Intro_Settle_Stacks ===
You plant your feet and face Malik. “Deep breath. It’s probably a power glitch,” you insist, even though the hair on your arms prickles. He copies your inhale and lets it out slow. The cold deepens anyway, like the library is listening for the lie.
 # character:character/malik
"If this is somebody’s prank, they really went all out," Malik says dryly.

A shadow lengthens across the carpet. Someone, or something, steps into the light at the end of the aisle.

{HUDLine}

+ [Continue] -> Intro_Agnes_Appears

=== Intro_Agnes_Appears ===
 # character:character/nun
You look up to find a figure standing at the end of the aisle, half in shadow. She glides forward, the hem of her tattered habit dragging across the carpet, a faint scent of wax and old hymnals trailing behind.

{ introLowChoice == "exit":
  For a moment you think you reached the stairwell, but the shelves seem to have shifted. She blocks the only clear way out.
- else:
  You stand your ground because there’s nowhere else to stand. The shadowed nun takes up the entire aisle without making a sound.
}
+ [Continue] -> Intro_Agnes_Appears_2
=== Intro_Agnes_Appears_2 ===
"When this campus was a convent, I taught here. I have watched your generation stumble in the dark, without guidance. My afterlife task is to guide a hundred more students than I reached in life. You and Malik are the hundredth."
+ [Continue] -> Intro_Agnes_Appears_3
=== Intro_Agnes_Appears_3 ===
"Here is the bargain. Staying up and writing harder won’t save you. You do not have the plan, the notes, or the truth to pass this essay as it stands, and the missed group work has already put you on the edge. I am giving you a chance. You have until the DEADline at 5:00 AM, before the library wakes. Complete three tasks and finish your essay with the truth. Do that and I will rewind one week. You wake rested, keep tonight's lessons, and salvage your semester. Finish on time but dodge the truth and you walk out at 5:00 AM with no reset, probation still watching. Miss the DEADline and this night repeats until you learn why your plans collapse."
+ [Continue] -> Intro_Agnes_Appears_4
=== Intro_Agnes_Appears_4 ===
"The DEADline tracker will mark your progress. In the tunnels, recover a student agenda and write brief, honest fragments under each prompt. In the cemetery, restore the goal tracker and write your SMART promise. Bring both pages to the archives, finish the essay, and release us all."
+ [Continue] -> Intro_Agnes_Appears_5
=== Intro_Agnes_Appears_5 ===
"I will not accept an essay without your own ink on both pages. Those pages were my students' tools. When the convent closed, records were moved in a rush and the pages slipped into the tunnels and the cemetery rows. The paper is thin now. Protect it."

{ introLowChoice == "exit":
  Her gaze tracks the way you still angle toward the exit. “You chose speed. May it serve you instead of scatter you.”
- else:
  She notes the steadiness of your breath. “Discipline holds when fear would scatter.”
}

Frostlight gathers in the air between you, then collapses into a cold pulse against your ribs.

~ hudEnabled = true

"Please tell me you see the same ghost I do," Malik says, barely.

Do you believe what you just saw?

{HUDLine}

+ [Believe Malik. This is real (+1m)]
  ~ time += 1
  ~ introBelief = "believe"
  -> D1_Setup_01
+ [Stay skeptical. Maybe you're seeing things (+1m)]
  ~ time += 1
  ~ introBelief = "doubt"
  -> D1_Setup_01

// -----------------------------
// DAY 1 SETUP
// -----------------------------

=== D1_Setup_01 ===
Sister Agnes thins like smoke and parts on a draft. The scent of old paper clings to your hoodie.

You jump as your phone buzzes in your pocket. An app you did not download blinks on your screen, red and steady. You show Malik. You both peer at the icon.

{ introBelief == "believe":
  Malik exhales the breath he’d been holding. “Okay. Ghost nun. App. Cool, got it.” You nod, because pretending this isn’t happening would just cost more time.
- else:
  You open your mouth to crack a joke about mass hallucinations, but the icon pulses and the fluorescents stutter to warn you off. Malik elbows you. “Whether or not she’s real, the timer is.”
}

{ introLowChoice == "exit":
  Your legs still feel like running, but the phone’s countdown makes it clear you’re not outrunning the DEADline.
- else:
  You ground your feet the way you did moments ago in the aisle. Whatever this is, you need a plan more than an escape route.
}

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> D1_Setup_02

=== D1_Setup_02 ===
The DEADline tracker blooms across your phone, red pulses syncing with the clock at the top of the screen.

Welcome to DEADline. Complete three tasks before the DEADline and finish the essay honestly to reclaim a lost week. Finish on time but dodge the truth and you keep the week you already lived, probation included. Fail to finish before the DEADline and repeat this night until you succeed.

Tunnels task: recover a forgotten student agenda and write brief fragments under each prompt. Your handwriting is proof.
Cemetery task: locate the goal tracker and write a SMART promise you can say aloud.
Archives task: use both pages to finish the psychology self-improvement essay before the DEADline. Time management is survival.

It’s currently {FormatClock(time)}. Remaining: {FormatHMM(deadline - time)}.
The app won’t let you proceed without choosing how you’ll stay organized tonight.

Pick one system you will commit to:

{HUDLine}

+ [Create a shared cloud folder with a running to-do doc (+10m)]
  ~ time += 10
  ~ planStyle = "cloud"
  ~ organization += 1
  -> Plan_Cloud
+ [Grab your notebook and build a physical checklist you can mark up (+5m)]
  ~ time += 5
  ~ planStyle = "paper"
  ~ organization += 1
  -> Plan_Paper
+ [Spin up a messy desktop folder + quick Notes list (+5m)]
  ~ time += 5
  ~ planStyle = "desktop"
  -> Plan_Desktop
+ [Skip the setup and trust your memory (+1m)]
  ~ time += 1
  ~ planStyle = "memory"
  -> Plan_Skip

=== Plan_Cloud ===
You and Malik pull out your laptop and create a shared folder titled "Deadline SOS," and drop in a blank doc labeled MASTER LIST. You add headings for tunnels, cemetery, archives, and finals week, then add screengrabs of the task list to sync across devices. It takes ten focused minutes, but now every asset you touch tonight will auto-save in two locations.

{HUDLine}

+ [Pack up and move out (+1m)]
  ~ time += 1
  -> D1_Setup_04

=== Plan_Paper ===
You flip open your notebook, draw columns for TASK / WHEN / STATUS, and hand Malik a pen to keep watch over the list. Each time you add a task, you note the time cost in the margin so the schedule stays honest. The page looks crowded, but tangible ink keeps your brain calm.

{HUDLine}

+ [Pack up and move out (+1m)]
  ~ time += 1
  -> D1_Setup_04

=== Plan_Desktop ===
You drag everything from your cluttered desktop into a folder called "Later," then create a fresh directory titled DEADLINE_NIGHT. Screenshots and voice memos will go there, a pinned Notes entry will hold your running list. It’s fast now, messy later, but it buys momentum.

{HUDLine}

+ [Pack up and move out (+1m)]
  ~ time += 1
  -> D1_Setup_04

=== Plan_Skip ===
You close the app prompts without setting up anything new. Malik lifts an eyebrow but doesn’t argue. “Okay, then we do this the hard way,” he mutters. The phone’s timer shrugs and keeps counting down.

{HUDLine}

+ [Pack up and move out (+1m)]
  ~ time += 1
  -> D1_Setup_04

=== D1_Setup_04 ===
The DEADline tracker pings again: "Handle fragile documents with care." A note taped to the circulation desk points to the special collections care kit drawer: microfiber cloths, clear sleeves, and a small phone tripod for steady photos. Grabbing them will cost minutes, but ruining a page could cost the whole night.

How much prep do you invest?

{HUDLine}

+ [Borrow supplies to assemble a document care kit (+5m)]
  ~ time += 5
  ~ careKit = true
  ~ organization += 1
  -> Prep_CareKit
+ [Rig a quick photo stand + shared album for backups (+5m)]
  ~ time += 5
  ~ scanBackups = true
  ~ photoPrep = true
  -> Prep_Photo
+ [Take ten minutes to do both carefully (+10m)]
  ~ time += 10
  ~ careKit = true
  ~ scanBackups = true
  ~ photoPrep = true
  ~ organization += 1
  -> Prep_Both
+ [Skip prep to save every minute (+1m)]
  ~ time += 1
  ~ careKit = false
  ~ scanBackups = false
  -> Prep_Skip

=== Prep_CareKit ===
You borrow a microfiber cloth and two sleeves from the supply drawer, packing them into a repurposed pencil case. Malik jokes that you look like a museum tech, but when you explain you’ll have to touch decades-old paper later, he nods and helps label each sleeve.

{HUDLine}

+ [Head for the exit (+1m)]
  ~ time += 1
  -> D1_Prep_Transit

=== Prep_Photo ===
You set a small phone tripod on the checkout counter, test the angle with a random history book, and create a shared album titled "Ghost Receipts." Malik turns on auto-upload so every shot lands in the shared album. If anything disintegrates later, the text will live on.

{HUDLine}

+ [Head for the exit (+1m)]
  ~ time += 1
  -> D1_Prep_Transit

=== Prep_Both ===
Ten concentrated minutes later the care kit is zippered, the phone tripod is set and steady, and a checklist in your notebook reminds you to use both before touching any fragile page. It’s slower up front, but the odds of ruining irreplaceable documents and your grade with them drop fast.

{HUDLine}

+ [Head for the exit (+1m)]
  ~ time += 1
  -> D1_Prep_Transit

=== Prep_Skip ===
You shut the drawer gently and decide the best strategy is speed. “We’ll just be careful,” you insist. Malik doesn’t argue, but he pockets an extra sleeve anyway, just in case.

{HUDLine}

+ [Head for the exit (+1m)]
  ~ time += 1
  -> D1_Prep_Transit

=== D1_Prep_Transit ===
You and Malik tap off the desk lamps you were using, shoulder your bags, and move toward the circulation desk. The library’s hum fades until all you hear is the groan of the building settling. A cool draft leaks from the glass doors to the hallway, carrying the emptiness of the campus after midnight.

Your pulse hammers like you’re about to sprint a 100 meter dash. The hallway beyond is quiet and dim. The DEADline app pulses red and steady.

{HUDLine}

{ malikPlanDecided == false:
  + [Check in with Malik before we choose our first task (+1m)]
    ~ time += 1
    -> Malik_Plan_Setup
- else:
  + [Check the next steps on the DEADline app (+1m)]
    ~ time += 1
    -> D1_Choice
}

=== Malik_Plan_Setup ===
You pause beneath the exit sign while Malik rolls his shoulders.

"Before we pick a task," Malik says, "should we stop to breathe, take some time to make a plan, or just get started? What feels best?"

{HUDLine}

+ [Take two minutes to calm down, breathe, and reset (+2m)]
  ~ time += 2
  ~ malikHuddleIntent = "steady"
  -> Malik_Plan_Huddle
+ [Quit talking, we've got to keep moving (+1m)]
  ~ time += 1
  ~ malikHuddleIntent = "rush"
  -> Malik_Plan_Huddle
+ [Map out a strategy for the rest of the night together (+3m)]
  ~ time += 3
  ~ malikHuddleIntent = "co_plan"
  -> Malik_Plan_Huddle

=== Malik_Plan_Huddle ===
~ temp _didHuddle = false

{ malikHuddleIntent == "steady":
    You and Malik half-sit on the plush red stools by the Library entrance. He hands you his water bottle, counts out a four slow, deep, even breaths, and watches until your shoulders drop.
    ~ relationshipMalik += 1
    ~ malikPlanChoice = "steady"
    ~ _didHuddle = true
    Two minutes slip away, but your pulse no longer tries to sprint out of your chest.
    "Cool heads finish projects," Malik says. "Let’s stay steady."
- else:
    { malikHuddleIntent == "rush":
        You fist-bump and hit the hall at a jog. Malik sets his phone to vibrate every five minutes, a relentless metronome you promise to match.
        ~ respect -= 1
        ~ malikPlanChoice = "rush"
        ~ _didHuddle = true
        "I’ll push the pace, you keep the choices clean. We can chill after the archives."
    - else:
        { malikHuddleIntent == "co_plan":
            You both crouch over the notebook and sketch a two-part map for the night...
            ~ organization += 1
            ~ malikPlanChoice = "co_plan"
            ~ _didHuddle = true
            ...
        - else:
            You and Malik pause, but the plan is still a blur. He tilts his head. "We need to choose our pace before we move."
        }
    }
}


{ _didHuddle:
  ~ malikPlanDecided = true
  ~ malikHuddleIntent = ""
}

{HUDLine}

{ malikPlanDecided:
  + [Back to the DEADline tracker (+1m)]
    ~ time += 1
    -> D1_Choice
- else:
  + [Answer Malik and pick a pace (+1m)]
    ~ time += 1
    -> Malik_Plan_Setup
}

=== D1_Choice ===
You check the next steps in the DEADline app. It highlights three objectives: tunnels find the agenda, cemetery find the goal tracker, archives complete your essay. It pulses a reminder: "Every decision changes the clock."

Two options blink on your screen:

- Start now. Go straight to the DEADline tracker and pick your first location. You’ll have more time on-site but fewer clues.
- Spend about ten minutes on research.

{HUDLine}

+ [Get moving right away (+1m)]
  ~ time += 1
  -> Task_Hub
+ [Pull clues at a library terminal (+10m)]
  ~ time += 10
  -> D1_Research_01

=== D1_Research_01 ===
You grab an open library terminal. The room feels colder than it should be. The monitor hums, its glow the only light not flickering. The cursor blinks, patient and expectant. You type "Convent Vanier."

Malik stands watch while you race through results, hoping one clue now will save twice as much time later.

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> D1_Research_02

=== D1_Research_02 ===
~ loreCemetery = true
You turn up two slim campus histories. The library was once a convent chapel. Two cemetery sections rest on the grounds, one for the parish and one for the Sisters. In the late 1960s, records were moved hurriedly when the site changed hands, some say incompletely. None of it explains the chill, but it confirms the campus remembers missed deadlines.

Among the digitized maintenance memos you find photos showing chalk marks at tunnel junctions and a scan of a faded map covered in pencil corrections. Capture it properly and you can use it to steer later. Or keep the gist in your head and get moving.

How do you capture what you found?

{HUDLine}

+ [Photograph every map and file them where you can both find them (+15m)]
  ~ time += 15
  -> D1_Research_Save
+ [Skim the memos, trust your instincts, and keep moving (+5m)]
  ~ time += 5
  -> D1_Research_Skim

=== D1_Research_Save ===
~ organization += 1
~ loreTunnels += 1
~ clueChalk = true
You and Malik settle into the terminal, crop each scan, and file them where you can both reach them. The extra minutes sting, but now you can mark up the images later and compare the faded chalk traces underground.

{HUDLine}

+ [Return to the tracker (+1m)]
  ~ time += 1
  -> Task_Hub

=== D1_Research_Skim ===
~ loreTunnels += 1
You skim the memos, mutter a few key turns under your breath, and trust that instinct plus Malik’s flashlight will be enough. The files stay on the screen as you back away, uncaptured and already fading, but at least you saved precious minutes.

{HUDLine}

+ [Return to the tracker (+1m)]
  ~ time += 1
  -> Task_Hub

// -----------------------------
// HUB
// -----------------------------

=== Task_Hub ===
~ hubVisits += 1
{ hubVisits == 1:
  ~ time += 2
- else:
  ~ time += 3
}

Remaining time: {FormatHMM(deadline - time)}.
Your phone thrums softly. The "DEADline Tracker" shows tonight’s tasks. Complete Tunnels and Cemeteries, Archives unlocks after both.

• Tunnels: { taskTunnelsDone ? "completed" : "not done" }
• Cemeteries: { taskCemeteryDone ? "completed" : "not done" }
• Archives: { (taskTunnelsDone && taskCemeteryDone) ? "unlocked" : "locked" }

{ (!taskTunnelsDone || !taskCemeteryDone):
  "We can split our focus or go deep first," Malik says carefully. "What feels better?"
}
{ (taskTunnelsDone && taskCemeteryDone):
  "Two down," Malik says steady. "Let’s finish this."
}

{HUDLine}

+ { not taskTunnelsDone } [Tunnels: Start or continue (+1m)]
  ~ time += 1
  -> Tunnel_Entry_01
+ { not taskCemeteryDone } [Cemeteries: Start or continue (+1m)]
  ~ time += 1
  -> C_Entry_01
+ { taskTunnelsDone && taskCemeteryDone } [Archives: Unlock and enter (+1m)]
  ~ time += 1
  -> A_Entry_01

// -----------------------------
// TUNNELS
// -----------------------------

=== Tunnel_Entry_01 ===
It’s time to go now. You cross campus to the N Building, a brick block with a service entry and a faint hiss of steam in the cold. Snow falls gently, making everything quiet and eerie. Once inside, you find a concrete stairwell and a metal sign that reads "Tunnels." The walk and getting the door unstuck cost a few minutes.
{ overheadTunnelApplied == false:
  ~ time += 6
  ~ overheadTunnelApplied = true
}

All the building lights are turned off. The stairwell is bare concrete and the handrail is slick with cold. The air from below smells like damp brick and old heating. Your phone light makes a small circle that looks smaller the longer you stare at it.

"Come on," Malik says, hushed. "Before I remember I hate basements."

You and Malik creep down the stairs and shove open a set of heavy metal doors with a push bar. The corridor beyond is low and narrow, the concrete sweating. Water drips in a steady plink. The air tastes like mold, and Malik coughs. Machines thrum somewhere beyond a line of plastic sheeting and stacked cinder blocks.

The DEADline app sits open on your phone, pulsing red in the dark.

{HUDLine}

+ [Enter (+1m)]
  ~ time += 1
  -> T_Setup_01

=== T_Setup_01 ===
~ tunnelStartTime = time

Inside the tunnels, the ceiling drops low and the brick walls sweat. Thick insulated pipes run along the ceiling with faded tags, a main service line you can follow. A faded yellow stripe runs along the floor, slick with condensation, and disappears at each junction. Your phone’s light breaks the dark in thin slices.

The clock keeps counting.

The DEADline app opens a small card on your screen:
"DEADline: Student Agenda (Planning)"
• Objective: Recover the agenda page used to plan a night of work.
• Clue: Follow service lines toward maintenance rooms, match faded chalk shadows at junctions.
• Why it matters: Gives you language you can cite and a plan you can use tonight.

{ loreTunnels > 0:
  You gladly realize your preliminary research is about to pay off.
- else:
  At least you have a clear clue to start from.
}

{ planStyle == "cloud":
    The shared "Deadline SOS" folder glows on your screen. Every turn you document here drops straight into the file you’ll cite in the archives.
- else:
    { planStyle == "paper":
        You keep one hand on your notebook. Each turn you log in ink will become evidence you stayed on task without supervision.
    - else:
        { planStyle == "desktop":
            Your freshly cleaned desktop folder waits for the photos Malik keeps snapping. It’s messy later, but it buys you momentum now.
        - else:
            Without a system, you’re relying on sheer focus. The app flashes a polite warning: "No log, no proof."
        }
    }
}


{ -malikPlanChoice == "rush":
    Malik’s phone vibrates every five minutes. It is the promise you made to keep the sprint pace he set.
- else:
    { malikPlanChoice == "steady":
        The breathing drill you ran with Malik still anchors your shoulders, every step is deliberate instead of frantic.
    - else:
        { malikPlanChoice == "co_plan":
            The quick map you sketched together in the stairwell rustles in your pocket, tunnel turns on one side and cemetery rows on the other.
        }
    }
}

How do you start?

{HUDLine}

+ { loreTunnels > 0 } [Use your earlier research: follow the chalk clues (+10m)]
  ~ time += 10
  ~ routePlan = "clues"
  -> T_Setup_04
+ [Move by instinct. Adjust as you go (+30m)]
  ~ time += 30
  ~ routePlan = "instinct"
  -> T_Setup_04
+ [Set a quick route plan: mark each turn, map as you go (+20m)]
  ~ time += 20
  ~ routePlan = "planned"
  ~ organization += 1
  -> T_Setup_04

=== T_Setup_04 ===
The tunnels breathe in slow drafts. Your steps echo into places you cannot see. Junctions break the corridor every few turns, each tagged with stenciled room codes and faded chalk smudges, scuffs where a mark used to be. Malik calls them chalk ghosts.

~ temp elapsedT = time - tunnelStartTime

{ routePlan == "planned":
    You and Malik hug the main service line, stopping every few minutes to mark turns and compare the faded marks to your notes. You log each valve in the margin map and leave small arrows so the path stays clear even when the echoes try to twist it. Your timer reads {FormatHMM(elapsedT)}. The margin map finally has its last valve. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
- else:
    { routePlan == "instinct":
        You move with the draft and the sound of dripping water, trusting your gut to call the next turn. You take long straights quickly and slow at corners just long enough to be sure the floor still slopes the way you think it does. Your timer reads {FormatHMM(elapsedT)}. The tunnel rhythm settles into your feet. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
    - else:
        { clueChalk:
            You keep the chalk photos on your screen and hold them up to the wall, matching pipe runs and floor drains until a likely path emerges. When the marks disagree, you choose the one that looks fresher and record why so you can retrace later. Your timer reads {FormatHMM(elapsedT)}. You settle on the freshest chalk shadow. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
        - else:
            You keep the chalk turns in your head and compare the marks by memory, matching pipe runs and floor drains until a likely path emerges. When the marks disagree, you choose the one that looks fresher and record why so you can retrace later. Your timer reads {FormatHMM(elapsedT)}. You settle on the freshest chalk shadow. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
        }
    }
}

~ temp targetT = 90
{ planStyle == "cloud":  targetT -= 8 }
{ planStyle == "paper": targetT -= 6 }
{ planStyle == "desktop": targetT -= 4 }
{ planStyle == "memory":  targetT += 6 }
{ loreTunnels <= 0:  targetT += 6 }
{ (loreTunnels <= 0) && (planStyle != "memory"):  targetT += 4 }

~ temp chalkAdj = 0
{ routePlan == "clues":
  { clueChalk: 
    ~ chalkAdj = -18
  - else: 
    ~ chalkAdj = -6
  }
}

~ temp need_rows = Clamp0((targetT + 0 + chalkAdj) - elapsedT)
~ temp need_diag = Clamp0((targetT + 2 + chalkAdj) - elapsedT)
~ temp need_verify = Clamp0((targetT + 8 + chalkAdj) - elapsedT)

{ malikPlanChoice == "rush":
  ~ need_rows = Clamp0(need_rows - 3)
  ~ need_diag = Clamp0(need_diag - 6)
  ~ need_verify = Clamp0(need_verify - 2)
}

How do you press on?

{HUDLine}

+ [Hug the service line, work each branch in order (+{12 + need_rows}m)]
  ~ time += (12 + need_rows)
  ~ tRoute = "rows"
  -> T_Find
+ [Push ahead on the main run, stop at each junction (+{6 + need_diag}m)]
  ~ time += (6 + need_diag)
  ~ tRoute = "diagonal"
  -> T_Find
+ [Leave a sign and verify chalk vs photo at each turn (+{14 + need_verify}m)]
  ~ time += (14 + need_verify)
  ~ tRoute = "verify"
  ~ organization += 1
  -> T_Find

=== T_Find ===
The corridor kinks left, then right, and opens into a low space that smells like oil and mop water. A dead bulb in a wire cage hangs from the ceiling. The main pipe widens and the floor slopes slickly to a drain. Dust dulls every surface.

Malik says, "Hey," and shines his light on a green door. The metal sign reads "Maintenance Room." Inside, shelves sag under old rags and corroded tools, and a broken clock hangs crooked on the wall. On a metal desk near the back lies a student agenda, forgotten and gray with age, like a message left for whoever dared to find it.

Malik holds his light steady while you open it. Five printed prompts stare back:
1. Map the looming deadlines: list every assignment still due this semester.
2. Confront the past: list overdue or incomplete work.
3. Look in the mirror: how often are assignments done early? What causes delays?
4. Heed the voices. What do you do with feedback, use it or ignore it?
5. Name the fear. What is your biggest blocker right now, perfection, avoidance, or burnout?

Each line lands like a verdict. The semester flashes behind your eyes: empty calendars, missed deadlines, the group chat you avoided, the feedback you never opened. Your chest tightens and the tunnels feel smaller. You read the prompts as a mirror for tonight too. The choices you just made in the tunnels flicker into place.

You have no time for full answers, only blunt fragments under each line. Your handwriting is the proof Agnes will look for in the archives.

{ planStyle == "memory":
  Some of the habits from this semester show up anyway. You went in without a system, trusting your memory, and the details of what you did and what to do next are already a bit foggy.
- else:
  For a moment you cannot name a new mistake from tonight, only the old ones you already know.
}

Then you force yourself to name what you did right tonight.

{ planStyle == "cloud" || planStyle == "paper" || planStyle == "desktop":
  You built a system instead of trusting luck.
}
{ malikPlanChoice == "steady":
  You took a deep breath and thought things through before diving in.
}
{ malikPlanChoice == "co_plan":
  You drew a map with Malik instead of running blind.
}
{ (routePlan == "planned") || (tRoute == "verify"):
  You left signs so you would not lose your place.
}
{ careKit:
  You came ready to protect the agenda's fragile paper instead of gambling with it.
}
{ photoPrep:
  You set up backups in case the night went bad.
}

You close the agenda and take a breath. The pipes hiss above you.

{HUDLine}

+ [Secure the agenda before you leave (+1m)]
  ~ time += 1
  -> T_Agenda_Secure

=== T_Agenda_Secure ===
You snap the agenda shut and tuck it close. Steam curls along the ceiling, warning of trouble.

{ careKit:
  You pull the microfiber cloth and sleeve from your kit before the damp air can curl the edges. Malik keeps the beam steady while you blot each page and slide it under plastic.
- else:
  With no document care kit, you balance the brittle agenda on your forearm. Every drip from the ceiling feels like a threat.
}

How do you secure the agenda before you leave?

~ agendaSecureStart = time
~ temp hasCloud = (planStyle == "cloud") || photoPrep
~ temp hasDesktop = (planStyle == "desktop")

{HUDLine}

+ [Grab it and go, backpack it fast (+2m)]
  ~ time += 2
  ~ agendaBackup = "none"
  -> T_Agenda_Exit

+ { hasCloud } [Photograph every page, upload them to a shared backup (+{photoPrep ? 2 : 7}m)]
    { photoPrep:
        ~ time += 2
    - else:
        ~ time += 7
    }
  ~ agendaBackup = "cloud"
  ~ scanBackups = true
  ~ organization += 1
  -> T_Agenda_Exit

+ { hasDesktop } [Photograph the pages and save them to your laptop's desktop folder (+{photoPrep ? 2 : 7}m)]
{ photoPrep:
    ~ time += 2
- else:
    ~ time += 7
}
  ~ agendaBackup = "desktop"
  ~ scanBackups = true
  -> T_Agenda_Exit

=== T_Agenda_Exit ===
The air groans, then erupts. A pipe in the ceiling bursts, drenching you and Malik in a curtain of hot water. Your backpack soaks through in seconds.

~ agendaDamaged = !careKit

{ careKit:
  Water rivers off the plastic sleeve you packed earlier. The agenda stays flat even while your hoodie steams.
- else:
  Ink blooms across the pages before you can yank the book free. You’ll have to rely on whatever you copied into your notes. You spend a few extra minutes blotting what you can.
  ~ time += 6
}

{ agendaBackup == "cloud":
    Because you uploaded the pages, the DEADline files stay safe. Malik’s laptop can pull them down even while yours hisses and dies.
- else:
    { agendaBackup == "desktop":
        The quick save to your laptop seemed smart until the water hits. The machine sputters and refuses to reboot, taking those captures with it.
    - else:
        With no backup, every droplet feels like lost evidence. You do your best to squeeze water out before the ink turns to fog.
    }
}

You wipe water from your phone. The DEADline App buzzes and a new card appears: "Task complete. Agenda recovered."

~ taskTunnelsDone = true
~ tasksCompleted += 1

{HUDLine}

+ [Check your phone (+2m)]
  ~ time += 2
  -> T_Page_Principles

=== T_Page_Principles ===
The DEADline App shows a status card:
"Agenda recovered. Keep it intact. Use it to anchor the essay in the archives."
{ agendaBackup == "cloud":
    "Backup uploaded."
- else:
    { agendaBackup == "desktop":
        "Backup saved to laptop."
    - else:
        { agendaBackup == "none":
            "No backup. Protect the original."
        }
    }
}
{ agendaDamaged:
  "Pages damaged. Use what you can."
}

Sister Agnes, distant: "Plans kept in your head drift. Ink them, follow them, and you will have proof when the night is done."

For a heartbeat the page seems warmer than the air, then cool again.

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> Task_Hub

// -----------------------------
// CEMETERY
// -----------------------------

=== C_Entry_01 ===
{ cemStartTime == 0:
  ~ cemStartTime = time
}
{ cemStartChoice == "":
  You take the pathway to the cemetery as a chilling fog rolls in. Streetlight and tree shadows stripe the gravestones, and Malik grips your arm so tightly it hurts. The walk and the gate cost a few minutes.
  { overheadCemeteryApplied == false:
    ~ time += 6
    ~ overheadCemeteryApplied = true
  }

  He realizes and lets go, murmuring an apology you can barely hear.

  The graves are neglected, covered in fallen leaves and debris. The cemetery is small but split in two. A central gravel path runs from the iron gate to a low stone wall at the back, with older stones on one side and smaller markers on the other. Row posts stick up every few meters. A narrow service path traces the fence. A rusted gate box sits by the entrance, grit crunching under your boots. Agnes said the goal tracker is hidden somewhere in these rows. Finding it will not be easy. Near the gate box, a pale crescent of grit has shifted where frost heaved the footing, like a shallow bowl pressed into the gravel.

  { careKit:
    The supply sleeve you borrowed rides against your ribs, ready for whatever paper you’re about to disturb.
  }
{ malikPlanChoice == "rush":
    Malik’s timer buzzes once against your arm, a reminder that you both chose speed over comfort.
- else:
    { malikPlanChoice == "steady":
        The breathing rhythm you practiced in the stairwell keeps your hands from shaking despite the cold.
    - else:
        { malikPlanChoice == "co_plan":
            You and Malik review the map you sketched by the exit, tracing which rows you agreed to clear first.
        }
    }
}

  Sister Agnes whispers from everywhere and nowhere:
  “Ambition without a plan is fog. Name what you will finish, and when you will finish it. The dead are patient. The clock is not.”

  The DEADline Tracker buzzes and a card appears: "Find the goal tracker. Keep it intact."

  The central path gives under a skin of snow. Cold settles in your sleeves.

  You brush snow off a flat stone and steady your notebook. Rows press close on both sides of the central path, and the gate box sits at the entrance. Row posts give you a rhythm to count by.

  You decide where to start the search.

  ~ cemStartPickTime = time

  {HUDLine}

  + [Start along the fence line and work inward (+4m)]
    ~ time += 4
    ~ cemStartChoice = "fence"
    -> C_Entry_01
  + [Start at the gate box by the entrance (+1m)]
    ~ time += 1
    ~ cemStartChoice = "gate"
    -> C_Entry_01
  + [Start deep by the back wall and work toward the entrance (+3m)]
    ~ time += 3
    ~ cemStartChoice = "back"
    -> C_Entry_01

- else:
  You move toward the start point you chose and let the rows settle into focus.

  ~ temp startCost = time - cemStartPickTime
{ cemStartChoice == "fence":
    It takes about {startCost} minutes to reach the fence line.
- else:
    { cemStartChoice == "gate":
        It takes about {startCost} minutes to reach the gate box.
    - else:
        It takes about {startCost} minutes to reach the back wall.
    }
}
  The DEADline Tracker flashes: "Set a goal for the cemetery search."
  The phone’s note lingers at the edge of your thoughts: "Leave with the page intact." Not just found. Intact.

  "We can keep it simple if that helps you breathe," Malik says. "If we move fast now, we can slow down later."

  You picture the options. A clear goal keeps you honest. A softer one keeps you calm. A fast one keeps you from thinking. A shared one keeps you from spinning out alone.

  Sister Agnes, near: "Write what you will finish tonight, and hold to it."

  Pick a goal you can commit to:

  ~ temp goalClearTarget = 160
{ time >= goalClearTarget:
    ~ goalClearTarget = deadline
    { time + 40 < deadline:
        ~ goalClearTarget = time + 40
    }
}

  ~ temp goalClearLabel = "Find the tracker in the cemetery rows by " + FormatClock(goalClearTarget) + " and keep it flat and dry"

  {HUDLine}

  + [Find it and keep it safe. Don’t overthink the rest (+2m)]
    ~ time += 2
    ~ goalMode = "comfort"
    -> C_Search
  + [Stay together and feel it out. We’ll decide as we go (+3m)]
    ~ time += 3
    ~ goalMode = "coauth"
    ~ relationshipMalik += 1
    -> C_Search
  + [{goalClearLabel} (+5m)]
    ~ time += 5
    ~ goalMode = "clear"
    ~ hasTimebox = true
    // store timebox in goalStatement flow; we’ll reuse a temp later
    -> C_Search
  + [Get it fast. We’ll protect it after (+1m)]
    ~ time += 1
    ~ goalMode = "quick"
    -> C_Search
}

=== C_Search ===
Your goal pulls the night into shape, or at least gives you something to hold.

{ goalMode == "comfort":
    You keep it simple and safe, no clock to chase. You scan for scuffed grit or a break in the snow without forcing a route.
- else:
    { goalMode == "clear":
        You and Malik work row by row, using the row posts as dividers. You brush away thin snow and look for disturbed grit, checking the clock so the deadline stays in view.
    - else:
        { goalMode == "quick":
            You cut diagonals across the central path, hopping between older stones and smaller markers. The fog makes corners slippery, and you promise yourself you'll organize the evidence once the page is in hand.
        - else:
            Malik taps your shoulder at each turn and touches the fence so you don't loop. He calls out row posts. When you point at a likely spot, he nods and draws a tiny X on the page.
        }
    }
}

{ cemStartChoice == "gate":
    You start at the gate box and follow the scuffed grit you noticed on the way in.
- else:
    { cemStartChoice == "back":
        You start deep by the back wall and work toward the entrance, letting the rows guide you.
    - else:
        You start along the fence line and work inward, watching for the scuffed grit to cross your path.
    }
}
{ goalMode == "comfort":
    Ten minutes in, you've looped the central path twice because you never set a boundary. At twenty, you slow down and pick one likely patch to trust.
- else:
    { goalMode == "clear":
        Ten minutes in, you've marked three rows to recheck. At twenty-five, a rust shadow lines up with the clue. At forty, the pale crescent near the gate box footing finally stands out.
    - else:
        { goalMode == "quick":
            You save time now and spend some of it circling back when signs blur. Ten minutes in, you've cut three lines but can't remember if you counted the first one. At twenty, you slow down and pick one sign to chase.
        - else:
            Minutes pass, but Malik's marks keep you from wandering. At fifteen minutes he calls the time and points back to the last turn you logged. At thirty, a pale crescent of grit catches both of your lights at once.
        }
    }
}

One pale crescent of grit stands out, but you still need a pattern to confirm it without losing time.

~ cemRouteStart = time

~ temp targetS = 40
{ goalMode == "quick":  targetS -= 10 }
{ goalMode == "coauth":  targetS -= 5 }
{ goalMode == "clear":  targetS -= 5 }
{ goalMode == "comfort":  targetS -= 2 }
{ loreCemetery:  targetS -= 6 }
{ !loreCemetery:  targetS += 6 }

~ temp elapsedS = time - cemStartTime
~ temp needS = Clamp0(targetS - elapsedS)

{HUDLine}

+ [Work the fence line row by row (+{12 + needS}m)]
  ~ time += (12 + needS)
  ~ routeChoice = "rows"
  -> C_Find
+ [Cut a fast grid across the central path (+{6 + needS}m)]
  ~ time += (6 + needS)
  ~ routeChoice = "grid"
  -> C_Find
+ [Mark your path and time, then verify each row (+{14 + needS}m)]
  ~ time += (14 + needS)
  ~ routeChoice = "mark"
  ~ markedPath = true
  -> C_Find

=== C_Find ===
~ temp routeCost = time - cemRouteStart
{ routeChoice == "rows":
    The fence line finally yields after about {routeCost} minutes.
- else:
    { routeChoice == "grid":
        The grid turns up a fresh sign after about {routeCost} minutes.
    - else:
        Verifying each row takes about {routeCost} minutes before you notice something interesting.
    }
}

Behind a cracked stone near the fence line, just beyond the gate box footing, you sweep aside the pale crescent of grit and find a shallow hollow with a rusted lip. A metal tube hides there. You ease it out, fingertips numb, and unroll the single page inside. The ink is still dark, the paper thin as breath.

A header is written across the top in tight, careful script, with a blank line beneath it:

"Time steals loose plans. Set a SMART goal and keep faith with it."

The tracker flashes the goal you set at the start of the search.

{ goalMode == "clear":
    "Search goal: Find the tracker in the cemetery rows by your timebox and keep it flat and dry."
- else:
    { goalMode == "comfort":
        "Search goal: Find it and keep it safe. Don’t overthink the rest."
    - else:
        { goalMode == "coauth":
            "Search goal: Stay together and feel it out. We’ll decide as we go."
        - else:
            "Search goal: Get it fast. We’ll protect it after."
        }
    }
}

It follows with a quick check.

{ goalMode == "clear":
    "Goal check: specific, measurable, tied to a deadline. You knew where you were going."
- else:
    { goalMode == "comfort":
        "Goal check: safe, but vague. You never named where or when."
    - else:
        { goalMode == "coauth":
            "Goal check: shared focus helped, but the goal never named a deadline."
        - else:
            "Goal check: speed first, care second."
        }
    }
}

You pull the page close so the wind does not snatch it. The lesson stings, but it is clear.

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> C_Goal_Setup

=== C_Goal_Setup ===
The DEADline app vibrates, overlaying the SMART acronym on the tracker. Malik digs out a pen and waits.

This is the moment to set the academic goal that carries you through the archives and the rest of the night.

How do you get the guidance you need?

{HUDLine}

+ [Work from memory and define SMART in your own words (+2m)]
  ~ time += 2
  ~ goalsQuality = "improv"
  -> C_Goal_Write
+ [Trade ideas with Malik and list what you both know (+4m)]
  ~ time += 4
  ~ goalsQuality = "team"
  ~ relationshipMalik += 1
  -> C_Goal_Write
+ [Open your syllabus and pull up the SMART goal checklist (+6m)]
  ~ time += 6
  ~ goalsQuality = "researched"
  ~ organization += 1
  -> C_Goal_Write

=== C_Goal_Write ===
You brace the goal tracker against a dry stone while Malik keeps the flashlight steady. You use what you just learned to set the academic goal for the rest of the night. The SMART acronym hums at the bottom like a metronome.

Your breath fogs the paper and snow grit clings to the edges. The sheet is thin and cold, and any moisture will blur the ink.

{ goalsQuality == "researched":
    You pull up the syllabus on your phone and read each SMART step aloud.
    { time >= 270:
        It is already past 4:30 AM, so you reset the target.
        { time >= 295:
            "Before 5:00 AM we will finish the strongest possible psychology essay and upload it with both documents attached."
            ~ goalStatement = "Before 5:00 AM we will finish the strongest possible psychology essay and upload it with both documents attached."
        - else:
            "By 4:55 AM we will finish the full 1,000-word psychology essay and upload it with both documents attached after one careful proofread."
            ~ goalStatement = "By 4:55 AM we will finish the 1,000-word psychology essay and upload it with both documents attached after one careful proofread."
        }
    - else:
        Together you draft: "By 4:30 AM we will finish the full 1,000-word psychology essay, by 4:45 AM we will proofread it twice, and by 4:55 AM we will upload it with both documents attached."
        ~ goalStatement = "By 4:30 AM we will finish the 1,000-word psychology essay, by 4:45 AM we will proofread twice, and by 4:55 AM we will upload it with both documents attached."
    }
- else:
    { goalsQuality == "team":
        You and Malik trade reminders from class until the plan feels balanced.
        { time >= 270:
            It is already past 4:30 AM, so you shift the promise.
            { time >= 295:
                "Before 5:00 AM we will finish the strongest possible draft and upload it with the agenda and tracker."
                ~ goalStatement = "Before 5:00 AM we will finish the strongest possible draft and upload it with the agenda and tracker."
            - else:
                "By 4:55 AM we will finish the draft and read it aloud once together before uploading it with the agenda and tracker."
                ~ goalStatement = "By 4:55 AM we will finish the draft and read it aloud once together before uploading it with the agenda and tracker."
            }
        - else:
            "By the DEADline we will draft the essay and read it aloud once together before uploading it with the agenda and tracker."
            ~ goalStatement = "By the DEADline we will draft the essay and read it aloud once together before uploading it with the agenda and tracker."
        }
    - else:
        With no references handy, you rely on instinct.
        { time >= 270:
            It is already past 4:30 AM, so you name a tighter finish.
            { time >= 295:
                "Before 5:00 AM we will write a clear draft about managing deadlines and upload it with both documents attached."
                ~ goalStatement = "Before 5:00 AM we will write a clear draft about managing deadlines and upload it with both documents attached."
            - else:
                "By 4:55 AM we will write a clear draft about managing deadlines and upload it with both documents attached."
                ~ goalStatement = "By 4:55 AM we will write a clear draft about managing deadlines and upload it with both documents attached."
            }
        - else:
            "We’ll write at least 100 words about managing deadlines before the DEADline and squeeze in a quick proofread if there’s time."
            ~ goalStatement = "We will write at least 100 words about managing deadlines before the DEADline and try for a quick proofread if time allows."
        }
    }
}


Agnes will read this line back in the archives, so you write it carefully.

The DEADline countdown ticks louder and the wind keeps worrying the edges. How do you protect the fragile page before you move?

{HUDLine}

+ { careKit } [Slide it into your document sleeve, clip it shut, keep it inside your coat (+2m)]
  ~ time += 2
  ~ pageDamaged = false
  -> C_Result
+ [Press it flat between Malik's notebook pages under your jacket (+4m)]
  ~ time += 4
  ~ pageDamaged = false
  -> C_Result
+ [Roll it back into the tube and run before it soaks (+1m)]
  ~ time += 1
  ~ pageDamaged = true
  -> C_Result

=== C_Result ===
You steady the fragile goal tracker as you work.

{ not pageDamaged:
    Kept flat and dry, the page stays legible. When you check the time, you’re still on schedule, proof that careful work doesn’t always cost you the night.
- else:
    Rolling the tracker too fast crumples a corner. It will take extra care later to keep it legible.
}
{ scanBackups:
  Before you leave, Malik snaps photos and saves them to your backup setup so the SMART goals live somewhere digital too. You slide the page back into its sleeve and keep it close to your coat.
}

~ taskCemeteryDone = true
~ cemPreserved =  not pageDamaged
~ tasksCompleted += 1

// Approximate the long delta logic as written; keep the time burn behavior.
~ temp baseC = 62
{ goalMode == "quick":  baseC += 6 }
{ goalMode == "coauth":  baseC -= 2 }
{ goalMode == "clear":  baseC -= 2 }
{ goalMode == "comfort":  baseC += 2 }

{ planStyle == "cloud":  baseC -= 4 }
{ planStyle == "paper":  baseC -= 3 }
{ planStyle == "desktop":  baseC -= 2 }
{ planStyle == "memory":  baseC += 4 }

{ loreCemetery:  baseC -= 6 }
{ !loreCemetery:  baseC += 6 }
{ (!loreCemetery) && (planStyle != "memory"):  baseC += 10 }

{ careKit:  baseC -= 2 }
{ photoPrep:  baseC -= 2 }

{ malikPlanChoice == "steady":  baseC -= 2 }
{ malikPlanChoice == "co_plan":  baseC -= 2 }
{ malikPlanChoice == "rush":  baseC += 3 }

~ temp elapsedC = time - cemStartTime
~ temp deltaC = Clamp0(baseC - elapsedC)

{ malikPlanChoice == "rush":
  ~ deltaC = Clamp0(deltaC - 6)
  ~ cemeteryRushed = true
}

{ deltaC > 6:
    { cemeteryRushed:
        You spend the next {deltaC} minutes wiping grit from the tracker, knocking ice from the metal tube, and wrapping the page so the damp does not creep into the ink. The extra care burns time you did not plan for.
    - else:
        You spend the next {deltaC} minutes sealing the tracker, brushing off frost and grit, and double-checking the folded edge so the page stays legible. The extra care burns time you did not plan for.
    }
- else:
    { deltaC > 0:
        { cemeteryRushed:
            You spend the next {deltaC} minutes wiping grit from the tracker, double-checking the row posts you skipped, and sprinting the long way back to the gate.
        - else:
            You spend the next {deltaC} minutes sealing the goal tracker, logging the row posts you cleared, and walking the rows back the way you came without cutting corners.
        }
    }
}


~ time += deltaC

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> C_Page_Principles

=== C_Page_Principles ===
At the gate, your phone buzzes with a new achievement.

SMART tracker updated:
{ goalStatement != "":
  - Logged goal: "{goalStatement}"
}
- Specific & Relevant: name the deliverable and why it matters tonight.
- Measurable & Time-bound: attach numbers and a clock so progress is obvious.
- Achievable & Planned: include the guardrails (feedback, proofread, upload) that make success realistic.

Sister Agnes, near: "A goal spoken aloud gives shape to the hours. Break faith with it, and the hours break you."

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> Task_Hub

// -----------------------------
// ARCHIVES
// -----------------------------

=== A_Entry_01 ===
~ archStartTime = time

You climb to the library's fourth floor, the stairwell is deathly quiet, everyone else went home long ago. The door to the archives stands open as if waiting. It's always been locked to students before tonight. The room is narrow and dry, the lamp carving a small circle of light. Beyond it, shelves lean like ribs, cabinets stacked with gray boxes and paper tags. A line of rare book cases sits along the far wall, and objects from Agnes’ time rest on a side table as if she never left. Sister Agnes’ spectral form hovers beside the long table, two chairs pulled close. You take the chair under the lamp. Malik stays at your shoulder. You try to open your laptop to the half-finished self-improvement essay, but the screen stays dark. Malik slides his laptop over, and you log in fast, knowing not every file made the trip. He puts the agenda page and goal tracker on the table beside it.

Agnes tilts her head toward the pages.
"Sister Agnes: Your ink is your proof. Use those pages to write."

Getting the reading room open costs a few minutes.
{ overheadArchivesApplied == false:
  ~ time += 4
  ~ overheadArchivesApplied = true
}

~ temp agendaBackupOk = (agendaBackup == "cloud")

{ planStyle == "memory":
  ~ time += 4
  You lose a few minutes reconstructing your notes from memory.
}

~ archiveDocsRough = ( (agendaDamaged && !agendaBackupOk) || (pageDamaged && !scanBackups) )
~ archiveRushed = (malikPlanChoice == "rush")

{ archiveRushed:
  ~ time += 6
  You lose a few minutes untangling the out-of-order notes from the sprint.
}

~ temp archSetup = 6
{ planStyle == "cloud":
  ~ archSetup -= 3
  The shared folder keeps the citations and photos lined up, so you do not have to hunt for anything.
}
{ planStyle == "paper":
  ~ archSetup -= 2
  Your checklist keeps the order tight, saving a couple minutes of page shuffling.
}
{ planStyle == "desktop":
  ~ archSetup -= 1
  The desktop folder is messy but fast to scan, saving a minute now.
}
{ photoPrep:
  ~ archSetup -= 1
  The shared album opens to the right shots on the first try.
}
{ careKit:
  ~ archSetup -= 1
  The sleeves open cleanly, so you can lay everything out fast.
}
{ malikPlanChoice == "steady":
  ~ archSetup -= 1
  The steady pace earlier keeps your notes in order, saving a minute now.
}
{ malikPlanChoice == "co_plan":
  ~ archSetup -= 2
  The shared map keeps the citations lined up, so the setup moves faster.
}

~ archSetup = Clamp0(archSetup)

{ archSetup > 0:
  ~ time += archSetup
  You take {archSetup} minutes to lay out the documents and pull up your draft.
- else:
  You are ready to write without extra sorting.
}

{ not agendaDamaged:
    The student agenda page from the tunnels lies flat, your short fragments under each prompt still legible.
- else:
    { agendaBackup == "cloud":
        The physical agenda page warps at the edges, but your cloud copies glow on Malik’s screen and the fragments stay readable.
    - else:
        { agendaBackup == "desktop":
            The agenda page is mottled and the laptop you used as a backup sits silent, water pooled around the keys. Your fragments are hard to read.
        - else:
            The agenda page is crumpled and waterlogged. You can still make out a few of the fragments if you smooth it carefully.
        }
    }
}


{ not pageDamaged:
  The goal tracker from the cemetery rests in a clean sleeve, your SMART line sharp and legible.
- else:
  The goal tracker bears a torn corner where you rushed, the SMART line feathered along the rip.
}

{ archiveDocsRough:
  You can only use the broad strokes from the damaged pages.
}
{ archiveRushed:
  Your notes are out of order from the sprint, and you have to choose what to keep and what to drop.
}
{ goalStatement != "":
  Across the top, your SMART pledge waits: "{goalStatement}". Agnes’ gaze flicks to it as if grading the promise before the essay.
}

"Sister Agnes: You found what this essay needs: your plan and your promises. Finish honestly if you want the week back. Dodge the truth and you walk out at 5:00 AM with no reset."
"Sister Agnes: If your words dodge the truth, you may take one honest rewrite if time allows."

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> A_Setup_01

=== A_Setup_01 ===
You set the agenda notes and goal tracker beside your laptop. The pages smell faintly of dust and cold air, proof this night is real.

{ malikPlanChoice == "steady":
    Malik mirrors the breathing pattern you practiced earlier, grounding his elbows on the desk before he speaks.
- else:
    { malikPlanChoice == "rush":
        Malik’s heel bounces, still keyed to the sprint cadence you demanded between tasks.
    - else:
        { malikPlanChoice == "co_plan":
            The plan you both drafted keeps the last step clear, so there is no hesitation now.
        }
    }
}


Agnes taps a line near the top of the draft.
"Sister Agnes: Your draft says, I always start my projects days in advance. That’s what you told your teacher."
She twists her rosary and the air fills with light. Last Sunday evening flickers above the table: you sprawled across your parents’ couch, controller in hand, Malik’s “Need anything for the outline? I’m around.” text buzzing unanswered.

Malik clears his throat.
"You’d just staggered in from that double shift. You were wrecked."

Agnes’ gaze does not blink.
"Fatigue is a mortal ailment, avoidance is a choice. Which specter sat with you on that couch?"

It isn't about proving you were right. It's about naming what you'll change next.

~ archiveTimeThin = false
~ temp timeLeft = deadline - time

{ timeLeft <= 15:
  The clock is loud, and you can feel the minutes tightening. There is no room for a full examination.
  You have to forgo the careful answers and push the essay through.

  {HUDLine}

  + [Give short answers and push the essay through (+6m)]
    ~ time += 6
    ~ archiveTimeThin = true
    ~ archiveRushed = true
    -> A_Rush_Summary
- else:
  How do you answer?

  {HUDLine}

  + ["I was wrecked after that shift. I skimmed the prompt and told myself it counted." (+6m)]
    ~ time += 6
    ~ mondayPlan = mondayPlan
    // half-truth: cost penalty
    ~ time += 4
    // record truth state via startEarly analog
    ~ startEarly = "half_truth"
    -> A_Start_Result
  + ["Yeah, I took that break. Next time I block the outline on Sunday." (+6m)]
    ~ time += 6
    ~ startEarly = "honest"
    ~ honestyCount += 1
    ~ mondayPlan = "Block Sunday afternoon for the outline and text proof when it’s done."
    -> A_Start_Result
  + ["Come on, that assignment was busywork. I needed to save energy." (+6m)]
    ~ time += 6
    ~ startEarly = "deflect"
    ~ time += 10
    -> A_Start_Result
}

=== A_Rush_Summary ===
You answer in clipped lines, half defensive and half exhausted. Agnes listens, but the clock keeps your words short. Malik watches the minutes and does not interrupt.

VAR startEarly = "deflect"
~ projectTruth = "deflect"
~ feedbackTruth = "deflect"
~ honestyCount = 0
~ feedbackApplied = false

{HUDLine}

+ [Pull everything together (+1m)]
  ~ time += 1
  -> A_Finalize

=== A_Start_Result ===
// Ink note: startEarly is declared in A_Setup_01 / A_Rush_Summary as a VAR (global in Ink needs to be declared up top).
// For simplicity, we re-use a global:
-> A_Start_Result_Internal

~ startEarly = ""

=== A_Start_Result_Internal ===
{ startEarly == "":
    Agnes waits, the lamp hissing softly. You still need to answer the question before the draft can move forward.

    {HUDLine}

    + [Answer Agnes (+1m)]
        ~ time += 1
        -> A_Setup_01
- else:
    { startEarly == "honest":
        Sister Agnes lets out a breath you didn’t realize she was holding.
        "Say it clearly: “I chose rest, here is how I make room for the work.” A plan only matters when you speak it and follow it."
        { mondayPlan != "":
            She steadies your wrist as you type the words {mondayPlan} into the draft.
        }
    - else:
        { startEarly == "half_truth":
            Sister Agnes’ expression barely shifts. The lamps dip anyway.
            "Exhaustion is real. So is the promise you wrote. Say you chose sleep, then name how you build it into the plan."
            You notice the minute hand tick forward.
        - else:
            Sister Agnes’ eyes flare.
            "Calling the work “busy” doesn’t move the pen. Say why the chair was empty, even if it’s because you feared burning out."
            You feel the air tighten, the clock lurches ahead.
        }
    }

    {HUDLine}

    + [Read the next passage (+1m)]
        ~ time += 1
        -> A_Project
}


=== A_Project ===
Agnes turns to the next glowing line.
"Sister Agnes: Your draft says, I keep my group projects on schedule."
Another twist of the rosary, and Tuesday night replays across the wall: Malik and two classmates in the cafeteria, laptops open, one chair empty. A message flashes in the chat: "We can’t divide the sources until you show us your draft." It stays unread. The next clip is Wednesday morning, your slide space blank while everyone else presents. The agenda page you rescued in the tunnels glows on the table, a reminder of the promise you made to use it.

Malik exhales.
"You texted me at 9:30 saying you were ‘almost done.’ We ended up rebuilding your section at midnight."

His voice drops.
"I already turned in my reflection. Yours is the one that can lift the penalty for all of us."

Agnes folds her hands.
"You chose a system under Vanier for nights like that. You wrote SMART goals in the cemetery to protect that work. Why was the chair empty? Say it so I can believe the outline you promised."

How do you answer?

{HUDLine}

+ ["They overreacted. I was juggling work and figured someone else would cover me." (+6m)]
  ~ time += 6
  ~ projectTruth = "deflect"
  ~ time += 10
  -> A_Project_Result
+ ["I was behind and ducked the chat because I didn’t want to show half-done work." (+6m)]
  ~ time += 6
  ~ projectTruth = "honest"
  ~ honestyCount += 1
  ~ groupPlan = "Tell the group when I’m behind, drop sources by 6 PM, and name a backup presenter."
  -> A_Project_Result
+ ["I was writing, just slower. I panicked about showing them something rough." (+6m)]
  ~ time += 6
  ~ projectTruth = "half_truth"
  ~ time += 4
  -> A_Project_Result

=== A_Project_Result ===
{ projectTruth == "":
    Agnes watches you over the glow of the screen. You need to answer before the essay can move on.

    {HUDLine}

    + [Answer Agnes (+1m)]
        ~ time += 1
        -> A_Project
- else:
    { projectTruth == "honest":
        You stare at the blank slide looping above the table. “I wasn’t ready. I kept telling myself I needed one more pass, so I just… didn’t show up.”

        Agnes nods, not unkindly.
        "Shame is still a choice. Show how you'll handle this next time, before it's too late to recover."

        { groupPlan != "":
            You type: {groupPlan} The SMART guardrails from the cemetery now read like a message your group will actually answer.
        - else:
            You add the SMART guardrails you promised in the cemetery: warn the team before you vanish, drop the files before you clock out, name a partner who can cover you.
        }
    - else:
        { projectTruth == "half_truth":
            You exhale. “I was writing, I swear. I just panicked about dumping half-baked paragraphs on them.”

            Agnes taps the countdown.
            "Share the messy draft and fix it together. Hiding it made them redo the work without you."
            You feel a minute peel away.
        - else:
            “They overreacted,” you mutter, trying to make it sound reasonable. “My shift ran late. Somebody else could’ve filled in.”

            Agnes’ eyes sharpen.
            "If you need help, you ask for it before midnight. Blaming them won’t return the hours."
            The second hand jumps.
        }
    }

    {HUDLine}

    + [Continue (+1m)]
        ~ time += 1
        -> A_Feedback
}


=== A_Feedback ===
You steady your breathing and read the next claim out loud. “I always ask for feedback early.”

Agnes doesn’t speak. She flicks her rosary instead. The air fills with snapshots: your teacher’s comments sitting unopened in your course inbox, Malik’s annotated doc ignored, you walking past office hours with your head down.

"Sister Agnes: If that sentence was true, show me how. If it wasn’t, fix it."

This is less a confession than a contract.

How do you answer?

{HUDLine}

+ ["My teachers comments are harsh. Sometimes they feel personal." (+6m)]
  ~ time += 6
  ~ feedbackTruth = "deflect"
  ~ time += 10
  -> A_Feedback_Result
+ ["I was embarrassed after the midterm, so I hid the comments." (+6m)]
  ~ time += 6
  ~ feedbackTruth = "honest"
  ~ honestyCount += 1
  ~ feedbackPlan = "Schedule a ten-minute check-in after each submission and reply the day feedback is posted."
  -> A_Feedback_Result
+ ["I skimmed them. I was overwhelmed and told myself I’d reply later." (+6m)]
  ~ time += 6
  ~ feedbackTruth = "half_truth"
  ~ time += 4
  -> A_Feedback_Result

=== A_Feedback_Result ===
{ feedbackTruth == "honest":
    “I bombed that draft,” you admit. “Every time I thought about it felt like proof I wasn’t cut out for this, so I just… didn’t.”

    Agnes tilts her head.
    "Then write what you’ll do with the next set of comments the moment they appear."
    { feedbackPlan != "":
        You type: {feedbackPlan}.
    }
    Malik squeezes your shoulder.
    "I’m with you on that."
- else:
    { feedbackTruth == "half_truth":
        You exhale. “I skimmed them. I just… didn’t have the energy to answer that night.”

        Agnes taps the screen until the unread icon blinks red.
        "Name your feeling. If you are overwhelmed, say it, then set a reminder for later. Skimming is not reading."
        The Tracker’s minute hand jumps.
    - else:
        You fold your arms. “Her notes are brutal. It’s hard not to take them personally.”

        Agnes’ voice stays calm, which somehow feels worse.
        "Feedback isn’t a compliment service, but it should still be used. If the tone stings, write how you’ll cope next time instead of ignoring it."
        The clock coughs up two precious minutes.
    }
}


Malik scrolls your draft and taps a paragraph where he left comments earlier tonight.
"Want me to read what I wrote? We can fix it now while Agnes is still here."

The clock ticks. You can take the help now or keep the clock moving.

{HUDLine}

+ ["Read it. I’ll revise while you talk." (+6m)]
  ~ time += 6
  ~ feedbackApplied = true
  -> A_Feedback_Edit
+ ["Later. We need to keep moving." (+2m)]
  ~ time += 2
  ~ feedbackApplied = false
  -> A_Feedback_Edit

=== A_Feedback_Edit ===
{ feedbackApplied:
  Malik reads the teacher’s note aloud. You slice the bloated sentence in half, add the missing deadline from the agenda page, and type a reminder to ask about the part you still don’t understand when you rewind the week. Malik’s grin is quick but genuine.
  "See? That already sounds like you."
- else:
  Malik lowers his pencil.
  "Okay, but that paragraph is still going to sting tomorrow."
  The unread notification keeps pulsing at the edge of your vision.
}

{HUDLine}

+ [Pull everything together (+1m)]
  ~ time += 1
  -> A_Finalize

=== A_Finalize ===
You pull the tunnels agenda and the cemetery goal tracker closer and let their ink guide the last paragraph. You copy the fragments you wrote under each prompt and the SMART line you set at the gate. Malik leans in, ready to call out anything that slips back into performance.

~ temp honestOK = essayHonest
{ honestyCount >= 3:
    ~ honestOK = true
}

{HUDLine}

{ not essayHonest:
  Agnes nudges the laptop back toward you.
  "Sister Agnes: One more pass if the clock allows. Rewrite with the truth, or hand it in and live with it."

  ~ temp rewriteCost = 10

  { (time + rewriteCost) <= deadline:
    + [Rewrite honestly (+10m)]
      ~ time += 10
      -> A_Rewrite_Do
    + [Hand it in anyway (+1m)]
      ~ time += 1
      -> A_Result
  - else:
    "Sister Agnes: There isn’t enough night left to rewrite. Whatever you hand in now is what the DEADline will remember."
    + [Face the consequence (+1m)]
      ~ time += 1
      -> A_Result
  }
- else:
  + [Continue (+1m)]
    ~ time += 1
    -> A_Result
}

=== A_Rewrite_Do ===
You take the extra minutes and rewrite the weak lines while Malik keeps you honest. The revision costs about ten minutes, and you feel every one.
You replace the vague claims with the fragments you wrote under the agenda prompts and the SMART line you set at the gate.

Malik taps the draft and smiles.
"You can be real without being hard on yourself. Just say why, and what you'll do next."

~ temp hasRewriteLines = false

// Rebuild lines based on deflect/half_truth states:
{ startEarly == "deflect":
  ~ hasRewriteLines = true
  "For the outline, wanna say you were tired and ducked it, then what you'll do next time?"
  You write: I called it busywork because I was tired and didn't want to start. Next time I block Sunday for the outline and write a rough first paragraph.
}
{ startEarly == "half_truth":
  ~ hasRewriteLines = true
  "For the outline, what if you say the shift wiped you out and you put it off, then what’s the next step?"
  You write: I was wrecked after the shift and avoided the outline. Next time I block Sunday for the outline and start before I crash.
}
{ projectTruth == "deflect":
  ~ hasRewriteLines = true
  "For the group work, maybe say you ducked the chat because you were behind, then how you'll show up next time?"
  You write: I told myself they overreacted, but I was behind and avoided the chat. Next time I tell them early, drop sources by 6, and name a backup.
}
{ projectTruth == "half_truth":
  ~ hasRewriteLines = true
  "For the group work, what if you say you were nervous to share rough work, then promise to share early?"
  You write: I was afraid to show rough work. Next time I share a messy draft early and label what I still owe.
}
{ feedbackTruth == "deflect":
  ~ hasRewriteLines = true
  "For feedback, maybe say the notes stung and you put them off, then say you’ll read them that day and write one question?"
  You write: I said the notes were harsh because I felt exposed, so I avoided them. Next time I read them the same day and write one question I can ask.
}
{ feedbackTruth == "half_truth":
  ~ hasRewriteLines = true
  "For feedback, what if you say you were overwhelmed and delayed, then say you'll respond that day?"
  You write: I was overwhelmed and put the comments off. Next time I set a ten minute timer and respond the same day.
}

{ not hasRewriteLines:
  "Keep it small and true, then we keep moving," Malik says.
}

~ temp rewriteNote = ""
{ archiveDocsRough:
  { agendaDamaged && pageDamaged:
    ~ rewriteNote = "You have to slow down to read what is left, and you rebuild the missing words as carefully as you can."
  - else:
    ~ rewriteNote = "The damaged pages force you to paraphrase, but the meaning stays clear."
  }
- else:
  ~ rewriteNote = "The pages stay readable, so the rewrite moves clean and fast."
}

{ rewriteNote == "":
  ~ rewriteNote = "You steady the pages and keep going."
}

{rewriteNote}

~ essayHonest = true

{ mondayPlan == "":
  ~ mondayPlan = "Block Sunday afternoon for the outline and text proof when it’s done."
}
{ groupPlan == "":
  ~ groupPlan = "Tell the group when I’m behind, drop sources by 6 PM, and name a backup presenter."
}
{ feedbackPlan == "":
  ~ feedbackPlan = "Schedule a ten-minute check-in after each submission and reply the day feedback is posted."
}

{HUDLine}

+ [Submit the revised draft (+1m)]
  ~ time += 1
  -> A_Result

=== A_Result ===
~ temp onTime = (time <= deadline)
~ temp allTasks = (taskTunnelsDone && taskCemeteryDone)
~ temp success = (allTasks && onTime)

{ success:
    { essayHonest:
        Sister Agnes reads the final paragraph on the laptop, nodding once. The agenda notes, the cemetery goals, and the honest reflection sit inside the draft like ribs, holding it up.

        "Sister Agnes: This is the self-improvement essay I was promised. You faced the work, and you proved how you’ll keep facing it."

        { feedbackApplied:
            She taps the revised line Malik helped you fix, a quiet nod for taking the help when it mattered.
        }

        She sets a tarnished pocket watch in your palm. The hands spin once and settle on last Monday’s sunrise.

        "Sister Agnes: Take the week back. Remember what you wrote here. Live it."

        Malik lets out a laugh that sounds equal parts exhausted and relieved.
        "We get a redo. Let’s make it count."

        {HUDLine}

        + [Accept the pocket watch and head for the doors (+1m)]
            ~ time += 1
            -> End_Epilogue_Success
    - else:
        You finish before the DEADline. The agenda and goal tracker prove you did the work tonight, but the essay still dodges the raw edges. Agnes reads the last paragraph on the screen and leans back.

        "Sister Agnes: You met the deadline, but you’re still telling yourself half-truths. Without honesty, a plan is just ink."

        { feedbackApplied:
            Malik's revision cleans the paragraph, but the truth still keeps its distance.
        }

        The pocket watch stays on her side of the desk. She slides the laptop back toward you. You leave with your draft and the plan you typed tonight, knowing it will land with the same dull thud it always has.

        {HUDLine}

        + [Step into the morning without a second chance at the week (+1m)]
            ~ time += 1
            -> End_Epilogue_NoReset
    }
- else:
    ~ temp reasonText = ""

    { not allTasks:
        ~ reasonText = reasonText + "Your steps never touched both the tunnels and the graves, so the archives denied the reset. "
    }
    { not onTime:
        ~ reasonText = reasonText + "Dawn arrived before your essay did. "
    }
    { essayHonest == false:
        ~ reasonText = reasonText + "Even when the pages filled, they sidestepped the truth you swore to speak. "
    }

    { not onTime:
        The DEADline app buzzes hard as the DEADline passes.
    - else:
        The DEADline app ticks forward, a quiet warning in the narrow room.
    }
    Agnes’ expression hardens, and the doors remain shut.

    "Sister Agnes: This place keeps what remains unfinished."

    { allTasks:
        { not onTime:
            You brought both pages, but the DEADline beat you to the last line
            { essayHonest == false:
                , and the words still sidestepped the truth.
            - else:
                .
            }
        }
    - else:
        { taskTunnelsDone:
            { not taskCemeteryDone:
                The agenda page sits on the table. The goal tracker never made it here.
            - else:
                You came without both pages. The reset cannot begin.
            }
        - else:
            { taskCemeteryDone:
                { not taskTunnelsDone:
                    The goal tracker sits on the table. The agenda page never made it here.
                - else:
                    You came without both pages. The reset cannot begin.
                }
            - else:
                You came without both pages. The reset cannot begin.
            }
        }
    }

    { reasonText != "":
        The shelves murmur the tally of what bound you: {reasonText}
    }

    {HUDLine}

    + [The halls do not let you go (+1m)]
        ~ time += 1
        -> End_Epilogue_Failure
}


// -----------------------------
// ENDINGS
// -----------------------------

=== End_Epilogue_Success ===
Cold air bites your cheeks as the doors open. The pocket watch in your hand hums once, then settles on last Monday morning. You look at Malik and say it out loud, fast and excited, like you’re afraid the promise might slip away.

"Okay, Sunday outline.{ mondayPlan != "" ? " I’ll do it like this: " + mondayPlan : " I’m actually doing it." }{ groupPlan != "" ? " And for the group, " + groupPlan : "" }{ feedbackPlan != "" ? " And when feedback hits, " + feedbackPlan : "" }"

Malik leans close, grinning like he can finally see it.
"We get to do it over. Let’s do what we promised."

In the foyer glass, Sister Agnes nods once and thins to daylight.

When your eyes open again it’s Monday morning. The watch shows 7:02 AM, your phone buzzes with Malik’s “Outline today? I’m in.” text, and sunlight cuts across your desk exactly the way it did a week ago. Only this time your agenda already waits open beside the keyboard.

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> The_End

=== End_Epilogue_NoReset ===
The doors open just before 5:00 AM. Snow needles your face as you and Malik step outside, clutching the essay you know isn’t the whole truth. No pocket watch waits in your hand.

"We’ll turn this in," Malik says, "but probation’s still watching. Next time we stick to the plan, okay?"

You nod. The only way forward now is to earn a second chance the slow way. The DEADline Tracker still shows the notes you wrote tonight.
{ mondayPlan != "" ? " Sunday outline: " + mondayPlan : "" }{ groupPlan != "" ? " Group fix: " + groupPlan : "" }{ feedbackPlan != "" ? " Feedback routine: " + feedbackPlan : "" }
This time you’ll have to follow them without Agnes’ help.

By the time Monday morning sun hits your blinds, the watch is normal and the alarm feels cruel, but the checklist you wrote in the archives still glows in your Notes app. No rewind. Just a choice to do the work awake.

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> The_End

=== End_Epilogue_Failure ===
The doors do not open. The lamps dim. Footsteps that are not yours pass by and do not pause. Malik grips your hand. You feel him count his breaths like you did in the stairwell.

Sister Agnes stands at the edge of the lamp and does not cross it.

"There is work to do," she says. "We will teach the living how to finish."

The clock on the wall jerks backward to 12:15 AM. Somewhere above you, snow starts falling again. Until you finish honestly, this night is the only one you get.

{HUDLine}

+ [Continue (+1m)]
  ~ time += 1
  -> The_End

// -----------------------------
// RESTART / END HUB
// -----------------------------

=== Restart_Night ===
// Reset key variables (approximate SugarCube Restart_Night)
~ time = 15
~ goalMode = ""
~ cemStartChoice = ""
~ cemStartPickTime = 0
~ hasTimebox = false
~ markedPath = false
~ routePlan = ""
~ routeChoice = ""
~ tRoute = ""
~ tPressStart = 0
~ planHasBuffer = false
~ pageDamaged = false
~ agendaDamaged = false
~ agendaSecureStart = 0
~ goalStatement = ""
~ goalsQuality = ""
~ malikPlanDecided = false
~ malikHuddleIntent = ""
~ malikPlanChoice = ""
~ cemPreserved = false
~ taskTunnelsDone = false
~ taskCemeteryDone = false
~ tasksCompleted = 0
~ honestyCount = 0
~ essayHonest = false
~ mondayPlan = ""
~ groupPlan = ""
~ feedbackPlan = ""
~ projectTruth = ""
~ feedbackTruth = ""
~ feedbackApplied = false
~ photoPrep = false
~ loreCemetery = false
~ overheadTunnelApplied = false
~ overheadCemeteryApplied = false
~ overheadArchivesApplied = false
~ archiveDocsRough = false
~ archiveTimeThin = false
~ archiveRushed = false
~ cemeteryRushed = false
-> D1_Choice

=== The_End ===
// Thanks for playing this arc.
{ (deadline - time) > 0:
  You finished with {FormatHMM(deadline - time)} to spare.
- else:
  You didn't quite hit the DEADline.
}

+ [Restart from the beginning] -> Intro_Library_01
+ [Jump to Decision Point 1] -> Restart_Night
+ [Credits (placeholder)] -> The_End
