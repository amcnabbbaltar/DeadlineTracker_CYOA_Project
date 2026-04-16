// DEADline — converted from Twine/SugarCube to Ink
// Original: Untitled_document.docx
// Note: Ink does not natively support real-time countdowns or computed
// arithmetic expressions the way SugarCube does. Time costs are preserved
// as narrative commentary. Variable-driven conditional branches are
// converted to Ink VAR / knot / divert syntax.

// ─── GLOBAL VARIABLES ───────────────────────────────────────────────────────
VAR introLowChoice = ""
VAR stress = 0
VAR introBelief = ""
VAR planStyle = ""
VAR organization = 0
VAR careKit = false
VAR scanBackups = false
VAR photoPrep = false
VAR loreTunnels = 0
VAR loreCemetery = false
VAR clueChalk = false
VAR malikPlanDecided = false
VAR malikHuddleIntent = ""
VAR malikPlanChoice = ""
VAR relationshipMalik = 0
VAR respect = 0
VAR focusMode = false
VAR routePlan = ""
VAR tRoute = ""
VAR agendaBackup = ""
VAR agendaDamaged = false
VAR pageDamaged = false
VAR goalMode = ""
VAR cemStartChoice = ""
VAR hasTimebox = false
VAR markedPath = false
VAR routeChoice = ""
VAR goalsQuality = ""
VAR goalStatement = ""
VAR taskTunnelsDone = false
VAR taskCemeteryDone = false
VAR tasksCompleted = 0
VAR honestyCount = 0
VAR essayHonest = false
VAR startEarly = ""
VAR projectTruth = ""
VAR feedbackTruth = ""
VAR feedbackApplied = false
VAR mondayPlan = ""
VAR groupPlan = ""
VAR feedbackPlan = ""
VAR archiveTimeThin = false
VAR archiveDocsRough = false
VAR archiveRushed = false
VAR hubVisits = 0
VAR intraBelief =0

// ─── START ───────────────────────────────────────────────────────────────────
-> Intro_Library_01

// ════════════════════════════════════════════════════════════════════════════
=== Intro_Library_01 ===
It's just past midnight in mid-December, and Montreal feels suspended between seasons. Snow falls too softly to look real, the kind that deadens sound. Inside Vanier Library, lights hum the way they do when most people have gone home. It stays open all night for exams. You and your friend, Malik, have been here for hours, trying to finish a project that still feels too big. Study lamps pool light over scattered tables, and a couple students doze with earbuds in.

Your first college semester was rough. You and Malik missed too many deadlines, and your class averages are dangerously low. You tried to get organized, but things kept sliding. It looked like you could hold it together, but this last week has been a disaster. The group oral on behavior change went badly. You took the extra section, the whole thing fell apart, and the rest of the team is upset. Tonight's mission is supposed to be simple. Finish your self-improvement essay for psychology. The teacher gave you a chance. The individual reflections now carry more weight, and the group penalty only lifts if everyone passes. Malik already submitted his reflection, but yours is the one that can save the group. You've been writing the version you wished were true, but you know it's not nearly good enough. If this paper collapses, your psych class collapses, and academic probation isn't a threat. It's next semester.

MALIK (tired): "One all-nighter. If we sound organized, they'll buy it, right? Maybe?"

He keeps it light, but you hear the guilt. He was the one who asked you to take the extra section of the presentation.

You check the time without wanting to. The minutes keep moving while you feel stuck.

-> Intro_Cold_Flicker_07

// ════════════════════════════════════════════════════════════════════════════
=== Intro_Cold_Flicker_07 ===
Suddenly the library shifts. The vents hush. The heat seeps away from the room. Fluorescents flicker once, then settle into a sickly yellow.

A draft moves through the stacks, colder than it should be. It smells like candle smoke and old wax. Somewhere in the dark, a book falls, loud enough to make you and Malik flinch. A few students glance up from their screens, then pack up and slip out without a word.

MALIK (low): "People swear this place gets weird after midnight. Maybe we outline fast and bounce."

You slide your planner into your backpack. It feels heavier than before.

The aisle stretches in both directions. One way is the exit, the other leads to the circulation desk by the heating vents.

What do you do?

+ [Grab Malik and hurry for the exit]
    -> Intro_Rush_Stairs
+ [Hold your ground and tell Malik to breathe]
    -> Intro_Settle_Stacks

// ════════════════════════════════════════════════════════════════════════════
=== Intro_Rush_Stairs ===
~ introLowChoice = "exit"

You hook a hand in Malik's sleeve and hustle toward the stairwell. Your boots squeak against the marble. The air grows colder the closer you get, as if the building is inhaling. Halfway there, the lights snap off, one row at a time, until only the aisle behind you glows.

MALIK (whispering): "Okay… maybe the rumors weren't a joke."

The darkness pulses once more, then holds still. Something waits between the stacks just ahead.

-> Intro_Agnes_Appears

// ════════════════════════════════════════════════════════════════════════════
=== Intro_Settle_Stacks ===
~ introLowChoice = "steady"

You plant your feet and face Malik. "Deep breath. It's probably a power glitch," you insist, even though the hair on your arms prickles. He copies your inhale and lets it out slow. The cold deepens anyway, like the library is listening for the lie.

MALIK (dry): "If this is somebody's prank, they really went all out."

A shadow lengthens across the carpet. Someone, or something, steps into the light at the end of the aisle.

-> Intro_Agnes_Appears

// ════════════════════════════════════════════════════════════════════════════
=== Intro_Agnes_Appears ===
You look up to find a figure standing at the end of the aisle, half in shadow. She glides forward, the hem of her tattered habit dragging across the carpet, a faint scent of wax and old hymnals trailing behind.

{ introLowChoice == "exit":
    For a moment you think you reached the stairwell, but the shelves seem to have shifted. She blocks the only clear way out.
- else : { introLowChoice == "steady":
        You stand your ground because there's nowhere else to stand. The shadowed nun takes up the entire aisle without making a sound.
    }
}

SISTER AGNES: "When this campus was a convent, I taught here. I have watched your generation stumble in the dark, without guidance. My afterlife task is to guide a hundred more students than I reached in life. You and Malik are the hundredth."

SISTER AGNES: "Here is the bargain. Staying up and writing harder won't save you. You do not have the plan, the notes, or the truth to pass this essay as it stands, and the missed group work has already put you on the edge. I am giving you a chance. You have until the DEADline at 5:00 AM, before the library wakes. Complete three tasks and finish your essay with the truth. Do that and I will rewind one week. You wake rested, keep tonight's lessons, and salvage your semester. Finish on time but dodge the truth and you walk out at 5:00 AM with no reset, probation still watching. Miss the DEADline and this night repeats until you learn why your plans collapse."

SISTER AGNES: "The DEADline tracker will mark your progress. In the tunnels, recover a student agenda and write brief, honest fragments under each prompt. In the cemetery, restore the goal tracker and write your SMART promise. Bring both pages to the archives, finish the essay, and release us all."

SISTER AGNES: "I will not accept an essay without your own ink on both pages. Those pages were my students' tools. When the convent closed, records were moved in a rush and the pages slipped into the tunnels and the cemetery rows. The paper is thin now. Protect it."

{ introLowChoice == "exit":
    Her gaze tracks the way you still angle toward the exit. "You chose speed. May it serve you instead of scatter you."
    - else : {- introLowChoice == "steady":
    She notes the steadiness of your breath. "Discipline holds when fear would scatter."
    }
}

Frostlight gathers in the air between you, then collapses into a cold pulse against your ribs.

MALIK (barely): "Please tell me you see the same ghost I do."

Do you believe what you just saw?

+ [Believe Malik. This is real]
    ~ intraBelief = "believe"
    -> D1_Setup_01
+ [Stay skeptical. Maybe you're seeing things]
    ~ intraBelief = "doubt"
    -> D1_Setup_01

// ════════════════════════════════════════════════════════════════════════════
=== D1_Setup_01 ===
Sister Agnes thins like smoke and parts on a draft. The scent of old paper clings to your hoodie.

You jump as your phone buzzes in your pocket. An app you did not download blinks on your screen, red and steady. You show Malik. You both peer at the icon.

{ intraBelief == "believe":
    Malik exhales the breath he'd been holding. "Okay. Ghost nun. App. Cool, got it." You nod, because pretending this isn't happening would just cost more time.
- else:
    You open your mouth to crack a joke about mass hallucinations, but the icon pulses and the fluorescents stutter to warn you off. Malik elbows you. "Whether or not she's real, the timer is."
}

{ introLowChoice == "exit":
    Your legs still feel like running, but the phone's countdown makes it clear you're not outrunning the DEADline.
- else :{ introLowChoice == "steady":
        You ground your feet the way you did moments ago in the aisle. Whatever this is, you need a plan more than an escape route.
    }
}

-> D1_Setup_02

// ════════════════════════════════════════════════════════════════════════════
=== D1_Setup_02 ===
The DEADline tracker blooms across your phone, red pulses syncing with the clock at the top of the screen.

DEADLINE APP: "Welcome to DEADline. Complete three tasks before the DEADline and finish the essay honestly to reclaim a lost week. Finish on time but dodge the truth and you keep the week you already lived, probation included. Fail to finish before the DEADline and repeat this night until you succeed."

DEADLINE APP: "Tunnels task: recover a forgotten student agenda and write brief fragments under each prompt. Your handwriting is proof."

DEADLINE APP: "Cemetery task: locate the goal tracker and write a SMART promise you can say aloud."

DEADLINE APP: "Archives task: use both pages to finish the psychology self-improvement essay before the DEADline. Time management is survival."

It's just past midnight. The app won't let you proceed without choosing how you'll stay organized tonight.

Pick one system you will commit to:

+ [Create a shared cloud folder with a running to-do doc (about 10 min — saves files in two places)]
    -> Plan_Cloud
+ [Grab your notebook and build a physical checklist you can mark up (about 5 min — steady start, no tech issues)]
    -> Plan_Paper
+ [Spin up a messy desktop folder + quick Notes list (about 5 min — fastest digital setup)]
    -> Plan_Desktop
+ [Skip the setup and trust your memory (about 1 min — fastest start, no safety net later)]
    -> Plan_Skip

// ════════════════════════════════════════════════════════════════════════════
=== Plan_Cloud ===
~ planStyle = "cloud"
~ organization = organization + 1

You and Malik pull out your laptop and create a shared folder titled "Deadline SOS," and drop in a blank doc labeled MASTER LIST. You add headings for tunnels, cemetery, archives, and finals week, then add screengrabs of the task list to sync across devices. It takes ten focused minutes, but now every asset you touch tonight will auto-save in two locations.

-> D1_Setup_04

// ════════════════════════════════════════════════════════════════════════════
=== Plan_Paper ===
~ planStyle = "paper"
~ organization = organization + 1

You flip open your notebook, draw columns for TASK / WHEN / STATUS, and hand Malik a pen to keep watch over the list. Each time you add a task, you note the time cost in the margin so the schedule stays honest. The page looks crowded, but tangible ink keeps your brain calm.

-> D1_Setup_04

// ════════════════════════════════════════════════════════════════════════════
=== Plan_Desktop ===
~ planStyle = "desktop"

You drag everything from your cluttered desktop into a folder called "Later," then create a fresh directory titled DEADLINE_NIGHT. Screenshots and voice memos will go there, a pinned Notes entry will hold your running list. It's fast now, messy later, but it buys momentum.

-> D1_Setup_04

// ════════════════════════════════════════════════════════════════════════════
=== Plan_Skip ===
~ planStyle = "memory"

You close the app prompts without setting up anything new. Malik lifts an eyebrow but doesn't argue. "Okay, then we do this the hard way," he mutters. The phone's timer shrugs and keeps counting down.

-> D1_Setup_04

// ════════════════════════════════════════════════════════════════════════════
=== D1_Setup_04 ===
The DEADline tracker pings again: "Handle fragile documents with care." A note taped to the circulation desk points to the special collections care kit drawer: microfiber cloths, clear sleeves, and a small phone tripod for steady photos. Grabbing them will cost minutes, but ruining a page could cost the whole night.

How much prep do you invest?

+ [Borrow supplies to assemble a document care kit (about 5 min — protects delicate pages)]
    -> Prep_CareKit
+ [Rig a quick photo stand + shared album for backups (about 5 min — protects against loss)]
    -> Prep_Photo
+ [Take ten minutes to do both carefully (about 10 min — safe but slow)]
    -> Prep_Both
+ [Skip prep to save every minute (no prep time now, more risk later)]
    -> Prep_Skip

// ════════════════════════════════════════════════════════════════════════════
=== Prep_CareKit ===
~ careKit = true
~ organization = organization + 1

You borrow a microfiber cloth and two sleeves from the supply drawer, packing them into a repurposed pencil case. Malik jokes that you look like a museum tech, but when you explain you'll have to touch decades-old paper later, he nods and helps label each sleeve.

-> D1_Prep_Transit

// ════════════════════════════════════════════════════════════════════════════
=== Prep_Photo ===
~ scanBackups = true
~ photoPrep = true

You set a small phone tripod on the checkout counter, test the angle with a random history book, and create a shared album titled "Ghost Receipts." Malik turns on auto-upload so every shot lands in the shared album. If anything disintegrates later, the text will live on.

-> D1_Prep_Transit

// ════════════════════════════════════════════════════════════════════════════
=== Prep_Both ===
~ careKit = true
~ scanBackups = true
~ photoPrep = true
~ organization = organization + 1

Ten concentrated minutes later the care kit is zippered, the phone tripod is set and steady, and a checklist in your notebook reminds you to use both before touching any fragile page. It's slower up front, but the odds of ruining irreplaceable documents — and your grade with them — drop fast.

-> D1_Prep_Transit

// ════════════════════════════════════════════════════════════════════════════
=== Prep_Skip ===
~ careKit = false
~ scanBackups = false

You shut the drawer gently and decide the best strategy is speed. "We'll just be careful," you insist. Malik doesn't argue, but he pockets an extra sleeve anyway, just in case.

-> D1_Prep_Transit

// ════════════════════════════════════════════════════════════════════════════
=== D1_Prep_Transit ===
You and Malik tap off the desk lamps you were using, shoulder your bags, and move toward the circulation desk. The library's hum fades until all you hear is the groan of the building settling. A cool draft leaks from the glass doors to the hallway, carrying the emptiness of the campus after midnight.

Your pulse hammers like you're about to sprint a 100 meter dash. The hallway beyond is quiet and dim. The DEADline app pulses red and steady.

{ malikPlanDecided:
    -> D1_Choice
- else:
    -> Malik_Plan_Setup
}

// ════════════════════════════════════════════════════════════════════════════
=== Malik_Plan_Setup ===
You pause beneath the exit sign while Malik rolls his shoulders.

MALIK: "Before we pick a task, should we stop to breathe, take some time to make a plan, or just get started? What feels best?"

+ [Take two minutes to calm down, breathe, and reset (about 2 min)]
    ~ malikHuddleIntent = "steady"
    -> Malik_Plan_Huddle
+ [Quit talking, we've got to keep moving (about 1 min)]
    ~ malikHuddleIntent = "rush"
    -> Malik_Plan_Huddle
+ [Map out a strategy for the rest of the night together (about 3 min)]
    ~ malikHuddleIntent = "co_plan"
    -> Malik_Plan_Huddle

// ════════════════════════════════════════════════════════════════════════════
=== Malik_Plan_Huddle ===
{ malikHuddleIntent == "steady":
    You and Malik half-sit on the plush red stools by the Library entrance. He hands you his water bottle, counts out four slow, deep, even breaths, and watches until your shoulders drop.
    ~ relationshipMalik = relationshipMalik + 1
    ~ focusMode = true
    ~ malikPlanChoice = "steady"
    ~ malikPlanDecided = true
    Two minutes slip away, but your pulse no longer tries to sprint out of your chest.
    MALIK: "Cool heads finish projects. Let's stay steady."

- else :{ - malikHuddleIntent == "rush":
        You fist-bump and hit the hall at a jog. Malik sets his phone to vibrate every five minutes, a relentless metronome you promise to match.
        ~ respect = respect - 1
        ~ malikPlanChoice = "rush"
        ~ malikPlanDecided = true
        MALIK: "I'll push the pace, you keep the choices clean. We can chill after the archives."
    
    - else :{ - malikHuddleIntent == "co_plan":
        You both crouch over the notebook and sketch a two-part map for the night. You number tunnel turns, mark cemetery rows and the gate box, and star the archives reminder. You decide the order you will tackle them.
        ~ organization = organization + 1
        ~ malikPlanChoice = "co_plan"
        ~ malikPlanDecided = true
        A few minutes disappear into penciled arrows, but now the route exists outside your head.
        Agnes' voice rides the draft, low and sure. "A shared plan is a covenant. Keep faith with it."
        MALIK: "Okay, now we both know the order and the cemetery rows. If we get lost later, we blame the map, not each other."
        } 
    }
}

-> D1_Choice

// ════════════════════════════════════════════════════════════════════════════
=== D1_Choice ===
You check the next steps in the DEADline app. It highlights three objectives: tunnels — find the agenda; cemetery — find the goal tracker; archives — complete your essay. It pulses a reminder: "Every decision changes the clock."

Two options blink on your screen:
- Start now. Go straight to the DEADline tracker and pick your first location. You'll have more time on-site but fewer clues.
- Spend about ten minutes on research.

+ [Get moving right away]
    -> Task_Hub
+ [Pull clues at a library terminal (about 10 min)]
    -> D1_Research_01

// ════════════════════════════════════════════════════════════════════════════
=== D1_Research_01 ===
You grab an open library terminal. The room feels colder than it should be. The monitor hums, its glow the only light not flickering. The cursor blinks, patient and expectant. You type "Convent Vanier".

Malik stands watch while you race through results, hoping one clue now will save twice as much time later.

-> D1_Research_02

// ════════════════════════════════════════════════════════════════════════════
=== D1_Research_02 ===
~ loreCemetery = true

You turn up two slim campus histories. The library was once a convent chapel. Two cemetery sections rest on the grounds, one for the parish and one for the Sisters. In the late 1960s, records were moved hurriedly when the site changed hands, some say incompletely. None of it explains the chill, but it confirms the campus remembers missed deadlines.

Among the digitized maintenance memos you find photos showing chalk marks at tunnel junctions and a scan of a faded map covered in pencil corrections. Capture it properly and you can use it to steer later. Or keep the gist in your head and get moving.

How do you capture what you found?

+ [Photograph every map and file them where you can both find them (about 15 min — reliable later)]
    -> D1_Research_Save
+ [Skim the memos, trust your instincts, and keep moving (about 5 min — fastest start)]
    -> D1_Research_Skim

// ════════════════════════════════════════════════════════════════════════════
=== D1_Research_Save ===
~ organization = organization + 1
~ loreTunnels = loreTunnels + 1
~ clueChalk = true

You and Malik settle into the terminal, crop each scan, and file them where you can both reach them. The extra minutes sting, but now you can mark up the images later and compare the faded chalk traces underground.

-> Task_Hub

// ════════════════════════════════════════════════════════════════════════════
=== D1_Research_Skim ===
You note the key details mentally and step away from the terminal. Faster now, less certain later.

-> Task_Hub

// ════════════════════════════════════════════════════════════════════════════
=== Task_Hub ===
~ hubVisits = hubVisits + 1

DEADline Tracker — current tasks:

{ taskTunnelsDone:
    • Tunnels: COMPLETED
- else:
    • Tunnels: [available]
}
{ taskCemeteryDone:
    • Cemetery: COMPLETED
- else:
    • Cemetery: [available]
}
{ taskTunnelsDone && taskCemeteryDone:
    • Archives: [UNLOCKED — ready to enter]
- else:
    • Archives: locked (complete both other tasks first)
}

{ not taskTunnelsDone || not taskCemeteryDone:
    MALIK (careful): "We can split our focus or go deep first. What feels better?"
}
{ taskTunnelsDone && taskCemeteryDone:
    MALIK (steady): "Two down. Let's finish this."
}

+ { not taskTunnelsDone } [Go to the Tunnels]
    -> Tunnel_Entry_01
+ { not taskCemeteryDone } [Go to the Cemetery]
    -> C_Entry_01
+ { taskTunnelsDone && taskCemeteryDone } [Enter the Archives]
    -> A_Entry_01

// ════════════════════════════════════════════════════════════════════════════
=== Tunnel_Entry_01 ===
It's time to go now. You cross campus to the N Building, a brick block with a service entry and a faint hiss of steam in the cold. Snow falls gently, making everything quiet and eerie. Once inside, you find a concrete stairwell and a metal sign that reads "Tunnels." The walk and getting the door unstuck cost a few minutes.

All the building lights are turned off. The stairwell is bare concrete and the handrail is slick with cold. The air from below smells like damp brick and old heating. Your phone light makes a small circle that looks smaller the longer you stare at it.

MALIK (hushed): "Come on, before I remember I hate basements."

You and Malik creep down the stairs and shove open a set of heavy metal doors with a push bar. The corridor beyond is low and narrow, the concrete sweating. Water drips in a steady plink. The air tastes like mold, and Malik coughs. Machines thrum somewhere beyond a line of plastic sheeting and stacked cinder blocks.

The DEADline app sits open on your phone, pulsing red in the dark.

-> T_Setup_01

// ════════════════════════════════════════════════════════════════════════════
=== T_Setup_01 ===
Inside the tunnels, the ceiling drops low and the brick walls sweat. Thick insulated pipes run along the ceiling with faded tags — a main service line you can follow. A faded yellow stripe runs along the floor, slick with condensation, and disappears at each junction. Your phone's light breaks the dark in thin slices.

The clock keeps counting.

DEADline App — Student Agenda (Planning):
• Objective: Recover the agenda page used to plan a night of work.
• Clue: Follow service lines toward maintenance rooms, match faded chalk shadows at junctions.
• Why it matters: Gives you language you can cite and a plan you can use tonight.

{ loreTunnels > 0:
    You gladly realize your preliminary research is about to pay off.
- else:
    At least you have a clear clue to start from.
}

{ planStyle == "cloud":
    The shared "Deadline SOS" folder glows on your screen. Every turn you document here drops straight into the file you'll cite in the archives.
    - else :{ planStyle == "paper":
        You keep one hand on your notebook. Each turn you log in ink will become evidence you stayed on task without supervision.
     - else :{- planStyle == "desktop":
        Your freshly cleaned desktop folder waits for the photos Malik keeps snapping. It's messy later, but it buys you momentum now.
        - else :{
            - planStyle == "memory":
            Without a system, you're relying on sheer focus. The app flashes a polite warning: "No log, no proof."
        }
        }
    } 
}

{ malikPlanChoice == "rush":
    Malik's phone vibrates every five minutes. It is the promise you made to keep the sprint pace he set.
}

{ malikPlanChoice == "steady":
    The breathing drill you ran with Malik still anchors your shoulders — every step is deliberate instead of frantic.
}

{ malikPlanChoice == "co_plan":
    The quick map you sketched together in the stairwell rustles in your pocket, tunnel turns on one side and cemetery rows on the other.
}

How do you start?

+ { loreTunnels > 0 } [Use your earlier research: follow the chalk clues (about 10 min — obvious if you know how to look)]
    ~ routePlan = "clues"
    -> T_Setup_04
+ [Move by instinct — adjust as you go, Malik tags along with his light (takes longer — you wander until the route settles)]
    ~ routePlan = "instinct"
    -> T_Setup_04
+ [Set a quick route plan: mark each turn, map as you go, check in every few minutes (about 20 min — slow, systematic, fewer wrong turns later)]
    ~ routePlan = "planned"
    ~ organization = organization + 1
    -> T_Setup_04

// ════════════════════════════════════════════════════════════════════════════
=== T_Setup_04 ===
The tunnels breathe in slow drafts. Your steps echo into places you cannot see. Junctions break the corridor every few turns, each tagged with stenciled room codes and faded chalk smudges — scuffs where a mark used to be. Malik calls them chalk ghosts.

{ routePlan == "planned":
    You and Malik hug the main service line, stopping every few minutes to mark turns and compare the faded marks to your notes. You log each valve in the margin map and leave small arrows so the path stays clear even when the echoes try to twist it. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
}

{ routePlan == "instinct":
    You move with the draft and the sound of dripping water, trusting your gut to call the next turn. You take long straights quickly and slow at corners just long enough to be sure the floor still slopes the way you think it does. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
}

{ routePlan == "clues":
    { clueChalk:
        You keep the chalk photos on your screen and hold them up to the wall, matching pipe runs and floor drains until a likely path emerges. When the marks disagree, you choose the one that looks fresher and record why so you can retrace later. You settle on the freshest chalk shadow. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
    - else:
        You keep the chalk turns in your head and compare the marks by memory, matching pipe runs and floor drains until a likely path emerges. When the marks disagree, you choose the one that looks fresher. Your fingers have gone numb from the cold iron rails, and Malik has stopped joking to save his breath.
    }
}

How do you press on?

+ [Hug the service line, work each branch in order (about 12 min — methodical)]
    ~ tRoute = "rows"
    -> T_Find
+ [Push ahead on the main run, stop at each junction to check marks (about 6 min — fastest upfront)]
    ~ tRoute = "diagonal"
    -> T_Find
+ [At each turn, leave a sign and verify chalk vs photo before committing (about 14 min — most reliable)]
    ~ tRoute = "verify"
    ~ organization = organization + 1
    -> T_Find

// ════════════════════════════════════════════════════════════════════════════
=== T_Find ===
The corridor kinks left, then right, and opens into a low space that smells like oil and mop water. A dead bulb in a wire cage hangs from the ceiling. The main pipe widens and the floor slopes slickly to a drain. Dust dulls every surface.

{ tRoute == "rows":
    You clear each branch methodically.
}

{ tRoute == "diagonal":
    You push the main run hard.
    { routePlan == "instinct":
        You trusted your gut in the dark and still lost minutes to wrong turns.
    }
}

{ tRoute == "verify":
    You verify each mark before committing.
}

{ malikPlanChoice == "rush":
    You pushed the pace — the turns blur.
}

{ malikPlanChoice == "co_plan":
    The sketched map saves you from two wrong turns.
}

Malik says, "Hey," and shines his light on a green door. The metal sign reads "Maintenance Room." Inside, shelves sag under old rags and corroded tools, and a broken clock hangs crooked on the wall. On a metal desk near the back lies a student agenda, forgotten and gray with age, like a message left for whoever dared to find it.

Malik holds his light steady while you open it. Five printed prompts stare back:

1. Map the looming deadlines: list every assignment still due this semester.
2. Confront the past: list overdue or incomplete work.
3. Look in the mirror: how often are assignments done early? What causes delays?
4. Heed the voices. What do you do with feedback — use it or ignore it?
5. Name the fear. What is your biggest blocker right now — perfection, avoidance, or burnout?

Each line lands like a verdict. The semester flashes behind your eyes: empty calendars, missed deadlines, the group chat you avoided, the feedback you never opened. Your chest tightens and the tunnels feel smaller.

You have no time for full answers, only blunt fragments under each line. Your handwriting is the proof Agnes will look for in the archives.

{ planStyle == "memory":
    You went in without a system, trusting your memory, and the details of what you did are already a bit foggy.
}
{ malikPlanChoice == "rush":
    You pushed the pace and paid for it when the turns blurred.
}

Then you force yourself to name what you did right tonight.
{ planStyle == "cloud":
    You built a system instead of trusting luck.
}
{ planStyle == "paper":
    You built a system instead of trusting luck.
}
{ malikPlanChoice == "steady":
    You took a deep breath and thought things through before diving in.
}
{ malikPlanChoice == "co_plan":
    You drew a map with Malik instead of running blind.
}
{ routePlan == "planned" || tRoute == "verify":
    You left signs so you would not lose your place.
}
{ careKit:
    You came ready to protect the agenda's fragile paper instead of gambling with it.
}
{ photoPrep:
    You set up backups in case the night went bad.
}

You close the agenda and take a breath. The pipes hiss above you.

-> T_Agenda_Secure

// ════════════════════════════════════════════════════════════════════════════
=== T_Agenda_Secure ===
You snap the agenda shut and tuck it close. Steam curls along the ceiling, warning of trouble.

{ careKit:
    You pull the microfiber cloth and sleeve from your kit before the damp air can curl the edges. Malik keeps the beam steady while you blot each page and slide it under plastic.
- else:
    With no document care kit, you balance the brittle agenda on your forearm. Every drip from the ceiling feels like a threat.
}

How do you secure the agenda before you leave?

+ [Grab it and go — backpack it fast before anything else goes wrong (about 2 min — no backups)]
    ~ agendaBackup = "none"
    -> T_Agenda_Exit
+ { photoPrep } [Photograph every page and upload them to a shared backup, then pack it away (about 2 min — prep is already ready)]
    ~ agendaBackup = "cloud"
    ~ scanBackups = true
    ~ organization = organization + 1
    -> T_Agenda_Exit
+ { not photoPrep } [Photograph every page and upload them to a shared backup (about 7 min — build the setup now)]
    ~ agendaBackup = "cloud"
    ~ scanBackups = true
    ~ organization = organization + 1
    -> T_Agenda_Exit
+ { planStyle == "desktop" && photoPrep } [Photograph the pages and save them to your laptop's desktop folder (about 2 min)]
    ~ agendaBackup = "desktop"
    ~ scanBackups = true
    -> T_Agenda_Exit
+ { planStyle == "desktop" && not photoPrep } [Photograph the pages and save them to your laptop's desktop folder (about 7 min)]
    ~ agendaBackup = "desktop"
    ~ scanBackups = true
    -> T_Agenda_Exit

// ════════════════════════════════════════════════════════════════════════════
=== T_Agenda_Exit ===
The air groans, then erupts. A pipe in the ceiling bursts, drenching you and Malik in a curtain of hot water. Your backpack soaks through in seconds.

~ agendaDamaged = not careKit

{ careKit:
    Water rivers off the plastic sleeve you packed earlier. The agenda stays flat even while your hoodie steams.
- else:
    Ink blooms across the pages before you can yank the book free. You'll have to rely on whatever you copied into your notes.
}

{ agendaBackup == "cloud":
    Because you uploaded the pages, the DEADline files stay safe. Malik's laptop can pull them down even while yours hisses and dies.
}

{ agendaBackup == "desktop":
    The quick save to your laptop seemed smart until the water hits. The machine sputters and refuses to reboot, taking those captures with it.
- else:
    With no backup, every droplet feels like lost evidence. You do your best to squeeze water out before the ink turns to fog.
}

You wipe water from your phone. The DEADline App buzzes and a new card appears: "Task complete. Agenda recovered."

~ taskTunnelsDone = true
~ tasksCompleted = tasksCompleted + 1

-> T_Page_Principles

// ════════════════════════════════════════════════════════════════════════════
=== T_Page_Principles ===
DEADline App status: "Agenda recovered. Keep it intact. Use it to anchor the essay in the archives."

{ agendaBackup == "cloud":
    "Backup uploaded."
}

{ agendaBackup == "desktop":
    "Backup saved to laptop."
- else:
    "No backup. Protect the original."
}

{ agendaDamaged:
    "Pages damaged. Use what you can."
}

SISTER AGNES (distant): "Plans kept in your head drift. Ink them, follow them, and you will have proof when the night is done."

For a heartbeat the page seems warmer than the air, then cool again.

-> Task_Hub

// ════════════════════════════════════════════════════════════════════════════
=== C_Entry_01 ===
You take the pathway to the cemetery as a chilling fog rolls in. Streetlight and tree shadows stripe the gravestones, and Malik grips your arm so tightly it hurts. The walk and the gate cost a few minutes. He realizes and lets go, murmuring an apology you can barely hear.

The graves are neglected, covered in fallen leaves and debris. The cemetery is small but split in two. A central gravel path runs from the iron gate to a low stone wall at the back, with older stones on one side and smaller markers on the other. Row posts stick up every few meters. A narrow service path traces the fence. A rusted gate box sits by the entrance, grit crunching under your boots. Agnes said the goal tracker is hidden somewhere in these rows. Near the gate box, a pale crescent of grit has shifted where frost heaved the footing, like a shallow bowl pressed into the gravel.

{ careKit:
    The supply sleeve you borrowed rides against your ribs, ready for whatever paper you're about to disturb.
}

{ malikPlanChoice == "rush":
    Malik's timer buzzes once against your arm — a reminder that you both chose speed over comfort.
}

{ malikPlanChoice == "steady":
    The breathing rhythm you practiced in the stairwell keeps your hands from shaking despite the cold.
}

{ malikPlanChoice == "co_plan":
    You and Malik review the map you sketched by the exit, tracing which rows you agreed to clear first.
}

SISTER AGNES: "Ambition without a plan is fog. Name what you will finish, and when you will finish it. The dead are patient. The clock is not."

DEADline Tracker: "Find the goal tracker. Keep it intact."

You decide where to start the search.

+ [Start along the fence line and work inward (about 4 min — widest sweep)]
    ~ cemStartChoice = "fence"
    -> C_Goal_Begin
+ [Start at the gate box by the entrance (about 1 min — quickest start)]
    ~ cemStartChoice = "gate"
    -> C_Goal_Begin
+ [Start deep by the back wall and work toward the entrance (about 3 min — commits you to the long rows)]
    ~ cemStartChoice = "back"
    -> C_Goal_Begin

// ════════════════════════════════════════════════════════════════════════════
=== C_Goal_Begin ===
You move toward the start point you chose and let the rows settle into focus.

The DEADline Tracker flashes: "Set a goal for the cemetery search."

MALIK: "We can keep it simple if that helps you breathe. If we move fast now, we can slow down later."

SISTER AGNES (near): "Write what you will finish tonight, and hold to it."

Pick a goal you can commit to:

+ [Find it and keep it safe. Don't overthink the rest (about 2 min — calm but vague)]
    ~ goalMode = "comfort"
    -> C_Search
+ [Stay together and feel it out. We'll decide as we go (about 3 min — shared focus)]
    ~ goalMode = "coauth"
    ~ relationshipMalik = relationshipMalik + 1
    -> C_Search
+ [Find the tracker in the cemetery rows by a fixed time and keep it flat and dry (about 5 min — strict target)]
    ~ goalMode = "clear"
    ~ hasTimebox = true
    -> C_Search
+ [Get it fast. We'll protect it after (about 1 min — speed first)]
    ~ goalMode = "quick"
    -> C_Search

// ════════════════════════════════════════════════════════════════════════════
=== C_Search ===
Your goal pulls the night into shape, or at least gives you something to hold.

{ goalMode == "comfort":
    You keep it simple and safe — no clock to chase. You scan for scuffed grit or a break in the snow without forcing a route. Ten minutes in, you've looped the central path twice because you never set a boundary.
}
{ goalMode == "clear":
    You and Malik work row by row, using the row posts as dividers. You brush away thin snow and look for disturbed grit, checking the clock so the deadline stays in view. At forty minutes, the pale crescent near the gate box footing finally stands out.
}
{ goalMode == "quick":
    You cut diagonals across the central path, hopping between older stones and smaller markers. You save time now and spend some of it circling back when signs blur.
}
{ goalMode == "coauth":
    Malik taps your shoulder at each turn and touches the fence so you don't loop. He calls out row posts. At fifteen minutes he calls the time and points back to the last turn you logged. At thirty, a pale crescent of grit catches both of your lights at once.
}

{ cemStartChoice == "gate":
    You start at the gate box and follow the scuffed grit you noticed on the way in.
}
{ cemStartChoice == "back":
    You start deep by the back wall and work toward the entrance, letting the rows guide you.
}
{ cemStartChoice == "fence":
    You start along the fence line and work inward, watching for the scuffed grit to cross your path.
}

One pale crescent of grit stands out, but you still need a pattern to confirm it without losing time.

How do you press on?

+ [Work the fence line and take it row by row (about 12 min + search time — thorough, slow but complete)]
    ~ routeChoice = "rows"
    -> C_Find
+ [Cut a fast grid across the central path and chase quick signs (about 6 min + search time — fast upfront, easy to miss edges)]
    ~ routeChoice = "grid"
    -> C_Find
+ [Mark your path and time, then verify each row before you commit (about 14 min + search time — slowest, least backtracking)]
    ~ routeChoice = "mark"
    ~ markedPath = true
    -> C_Find

// ════════════════════════════════════════════════════════════════════════════
=== C_Find ===
{ routeChoice == "rows":
    The fence line finally yields its secret after patient searching.
}
{ routeChoice == "grid":
    The grid turns up a fresh sign after cutting across the central path.
}
{ routeChoice == "mark":
    Verifying each row takes time but leaves no doubt when you find what you're looking for.
}

Behind a cracked stone near the fence line, just beyond the gate box footing, you sweep aside the pale crescent of grit and find a shallow hollow with a rusted lip. A metal tube hides there. You ease it out, fingertips numb, and unroll the single page inside. The ink is still dark, the paper thin as breath.

A header is written across the top in tight, careful script:
"Time steals loose plans. Set a SMART goal and keep faith with it."

The tracker reflects the goal you set at the start of the search.

{ goalMode == "clear":
    Goal check: specific, measurable, tied to a deadline. You knew where you were going.
}
{ goalMode == "comfort":
    Goal check: safe, but vague. You never named where or when.
} 

{goalMode == "coauth":
    Goal check: shared focus helped, but the goal never named a deadline.
}
{ goalMode == "quick":
    Goal check: speed first, care second.
}

You pull the page close so the wind does not snatch it. The lesson stings, but it is clear.

-> C_Goal_Setup

// ════════════════════════════════════════════════════════════════════════════
=== C_Goal_Setup ===
The DEADline app vibrates, overlaying the SMART acronym on the tracker. Malik digs out a pen and waits.

This is the moment to set the academic goal that carries you through the archives and the rest of the night.

How do you get the guidance you need?

+ [Work from memory and define SMART in your own words (about 2 min — fastest but thin)]
    ~ goalsQuality = "improv"
    -> C_Goal_Write
+ [Trade ideas with Malik and list what you both know before writing (about 4 min — balanced plan)]
    ~ goalsQuality = "team"
    ~ relationshipMalik = relationshipMalik + 1
    -> C_Goal_Write
+ [Open your syllabus and pull up the SMART goal checklist (about 6 min — strongest guidance)]
    ~ goalsQuality = "researched"
    ~ organization = organization + 1
    -> C_Goal_Write

// ════════════════════════════════════════════════════════════════════════════
=== C_Goal_Write ===
You brace the goal tracker against a dry stone while Malik keeps the flashlight steady. You use what you just learned to set the academic goal for the rest of the night. The SMART acronym hums at the bottom like a metronome.

Your breath fogs the paper and snow grit clings to the edges. The sheet is thin and cold.

{ goalsQuality == "researched":
    You pull up the syllabus on your phone and read each SMART step aloud. Together you draft: "By 4:30 AM we will finish the full 1,000-word psychology essay, by 4:45 AM we will proofread it twice, and by 4:55 AM we will upload it with both documents attached."
    ~ goalStatement = "By 4:30 AM we will finish the 1,000-word psychology essay, by 4:45 AM we will proofread twice, and by 4:55 AM we will upload it with both documents attached."
}{ goalsQuality == "team":
    You and Malik trade reminders from class until the plan feels balanced. "By the DEADline we will draft the essay and read it aloud once together before uploading it with the agenda and tracker."
    ~ goalStatement = "By the DEADline we will draft the essay and read it aloud once together before uploading it with the agenda and tracker."
}{goalsQuality == "improv":
    With no references handy, you rely on instinct. "We'll write at least 100 words about managing deadlines before the DEADline and squeeze in a quick proofread if there's time."
    ~ goalStatement = "We will write at least 100 words about managing deadlines before the DEADline and try for a quick proofread if time allows."
}

Agnes will read this line back in the archives, so you write it carefully.

The DEADline countdown ticks louder and the wind keeps worrying the edges. How do you protect the fragile page before you move?

+ { careKit } [Slide it into your document sleeve, clip it shut, and keep it inside your coat (about 2 min — safest)]
    ~ pageDamaged = false
    -> C_Result
+ [Press it flat between Malik's notebook pages under your jacket (about 4 min — careful but slower)]
    ~ pageDamaged = false
    -> C_Result
+ [Roll it back into the tube and run before it soaks (about 1 min — fastest but risky)]
    ~ pageDamaged = true
    -> C_Result

// ════════════════════════════════════════════════════════════════════════════
=== C_Result ===
~ taskCemeteryDone = true
~ tasksCompleted = tasksCompleted + 1

-> C_Page_Principles

// ════════════════════════════════════════════════════════════════════════════
=== C_Page_Principles ===
At the gate, your phone buzzes with a new achievement.

SMART tracker updated:
{ goalStatement != "":
    Logged goal: "{goalStatement}"
}
• Specific & Relevant: name the deliverable and why it matters tonight.
• Measurable & Time-bound: attach numbers and a clock so progress is obvious.
• Achievable & Planned: include the guardrails (feedback, proofread, upload) that make success realistic.

SISTER AGNES (near): "A goal spoken aloud gives shape to the hours. Break faith with it, and the hours break you."

-> Task_Hub

// ════════════════════════════════════════════════════════════════════════════
=== A_Entry_01 ===
You climb to the library's fourth floor, the stairwell is deathly quiet — everyone else went home long ago. The door to the archives stands open as if waiting. It's always been locked to students before tonight. The room is narrow and dry, the lamp carving a small circle of light. Beyond it, shelves lean like ribs, cabinets stacked with gray boxes and paper tags. A line of rare book cases sits along the far wall, and objects from Agnes' time rest on a side table as if she never left. Sister Agnes' spectral form hovers beside the long table, two chairs pulled close. You take the chair under the lamp. Malik stays at your shoulder. You try to open your laptop to the half-finished self-improvement essay, but the screen stays dark. Malik slides his laptop over, and you log in fast, knowing not every file made the trip. He puts the agenda page and goal tracker on the table beside it.

Agnes tilts her head toward the pages.

SISTER AGNES: "Your ink is your proof. Use those pages to write."

{ planStyle == "memory":
    You lose a few minutes reconstructing your notes from memory.
}

{ agendaDamaged && agendaBackup != "cloud":
    The physical agenda page warps at the edges. Fragments are hard to read.
}{ agendaBackup == "cloud":
    Your cloud copies glow on Malik's screen and the fragments stay readable despite the water damage.
- else:
    The student agenda page from the tunnels lies flat, your short fragments under each prompt still legible.
}

{ pageDamaged:
    The goal tracker bears a torn corner where you rushed — the SMART line feathered along the rip.
- else:
    The goal tracker from the cemetery rests in a clean sleeve, your SMART line sharp and legible.
}

~ archiveDocsRough = (agendaDamaged && agendaBackup != "cloud") || (pageDamaged && not scanBackups)

{ goalStatement != "":
    Across the top, your SMART pledge waits: "{goalStatement}". Agnes' gaze flicks to it as if grading the promise before the essay.
}

SISTER AGNES: "You found what this essay needs: your plan and your promises. Finish honestly if you want the week back. Dodge the truth and you walk out at 5:00 AM with no reset."

SISTER AGNES: "If your words dodge the truth, you may take one honest rewrite if time allows."

-> A_Setup_01

// ════════════════════════════════════════════════════════════════════════════
=== A_Setup_01 ===
You set the agenda notes and goal tracker beside your laptop. The pages smell faintly of dust and cold air, proof this night is real.

{ malikPlanChoice == "steady":
    Malik mirrors the breathing pattern you practiced earlier, grounding his elbows on the desk before he speaks.
}{ malikPlanChoice == "rush":
    Malik's heel bounces, still keyed to the sprint cadence you demanded between tasks.
}{ malikPlanChoice == "co_plan":
    The plan you both drafted keeps the last step clear, so there is no hesitation now.
}

Agnes taps a line near the top of the draft.

SISTER AGNES: "Your draft says, 'I always start my projects days in advance.' That's what you told your teacher."

She twists her rosary and the air fills with light. Last Sunday evening flickers above the table: you sprawled across your parents' couch, controller in hand, Malik's "Need anything for the outline? I'm around." text buzzing unanswered.

Malik clears his throat.

MALIK: "You'd just staggered in from that double shift. You were wrecked."

Agnes' gaze does not blink.

SISTER AGNES: "Fatigue is a mortal ailment, avoidance is a choice. Which specter sat with you on that couch?"

It isn't about proving you were right. It's about naming what you'll change next.

How do you answer?

+ ["I was wrecked after that shift. I skimmed the prompt and told myself it counted." (about 6 min)]
    ~ startEarly = "half_truth"
    -> A_Start_Result
+ ["Yeah, I took that break. Next time I block the outline on Sunday." (about 6 min)]
    ~ startEarly = "honest"
    ~ honestyCount = honestyCount + 1
    ~ mondayPlan = "Block Sunday afternoon for the outline and text proof when it's done."
    -> A_Start_Result
+ ["Come on, that assignment was busywork. I needed to save energy." (about 6 min)]
    ~ startEarly = "deflect"
    -> A_Start_Result

// ════════════════════════════════════════════════════════════════════════════
=== A_Start_Result ===
{ startEarly == "honest":
    Sister Agnes lets out a breath you didn't realize she was holding.
    SISTER AGNES: "Say it clearly: 'I chose rest, here is how I make room for the work.' A plan only matters when you speak it and follow it."
    { mondayPlan != "":
        She steadies your wrist as you type the words into the draft.
    }
}{ startEarly == "half_truth":
    Sister Agnes' expression barely shifts. The lamps dip anyway.
    SISTER AGNES: "Exhaustion is real. So is the promise you wrote. Say you chose sleep, then name how you build it into the plan."
    You notice the minute hand tick forward.
}{ startEarly == "deflect":
    Sister Agnes' eyes flare.
    SISTER AGNES: "Calling the work 'busy' doesn't move the pen. Say why the chair was empty, even if it's because you feared burning out."
    You feel the air tighten, the clock lurches ahead.
}

-> A_Project

// ════════════════════════════════════════════════════════════════════════════
=== A_Project ===
Agnes turns to the next glowing line.

SISTER AGNES: "Your draft says, 'I keep my group projects on schedule.'"

Another twist of the rosary, and Tuesday night replays across the wall: Malik and two classmates in the cafeteria, laptops open, one chair empty. A message flashes in the chat: "We can't divide the sources until you show us your draft." It stays unread. The next clip is Wednesday morning, your slide space blank while everyone else presents. The agenda page you rescued in the tunnels glows on the table, a reminder of the promise you made to use it.

Malik exhales.

MALIK: "You texted me at 9:30 saying you were 'almost done.' We ended up rebuilding your section at midnight."

His voice drops.

MALIK: "I already turned in my reflection. Yours is the one that can lift the penalty for all of us."

Agnes folds her hands.

SISTER AGNES: "You chose a system under Vanier for nights like that. You wrote SMART goals in the cemetery to protect that work. Why was the chair empty? Say it so I can believe the outline you promised."

How do you answer?

+ ["They overreacted. I was juggling work and figured someone else would cover me." (about 6 min)]
    ~ projectTruth = "deflect"
    -> A_Project_Result
+ ["I was behind and ducked the chat because I didn't want to show half-done work." (about 6 min)]
    ~ projectTruth = "honest"
    ~ honestyCount = honestyCount + 1
    ~ groupPlan = "Tell the group when I'm behind, drop sources by 6 PM, and name a backup presenter."
    -> A_Project_Result
+ ["I was writing, just slower. I panicked about showing them something rough." (about 6 min)]
    ~ projectTruth = "half_truth"
    -> A_Project_Result

// ════════════════════════════════════════════════════════════════════════════
=== A_Project_Result ===
{ projectTruth == "honest":
    You stare at the blank slide looping above the table. "I wasn't ready. I kept telling myself I needed one more pass, so I just… didn't show up."
    Agnes nods, not unkindly.
    SISTER AGNES: "Shame is still a choice. Show how you'll handle this next time, before it's too late to recover."
    { groupPlan != "":
        You type: {groupPlan}. The SMART guardrails from the cemetery now read like a message your group will actually answer.
    }
}{ projectTruth == "half_truth":
    You exhale. "I was writing, I swear. I just panicked about dumping half-baked paragraphs on them."
    Agnes taps the countdown.
    SISTER AGNES: "Share the messy draft and fix it together. Hiding it made them redo the work without you."
    You feel a minute peel away.
}{ projectTruth == "deflect":
    "They overreacted," you mutter, trying to make it sound reasonable. "My shift ran late. Somebody else could've filled in."
    Agnes' eyes sharpen.
    SISTER AGNES: "If you need help, you ask for it before midnight. Blaming them won't return the hours."
    The second hand jumps.
}

-> A_Feedback

// ════════════════════════════════════════════════════════════════════════════
=== A_Feedback ===
You steady your breathing and read the next claim out loud. "I always ask for feedback early."

Agnes doesn't speak. She flicks her rosary instead. The air fills with snapshots: your teacher's comments sitting unopened in your course inbox, Malik's annotated doc ignored, you walking past office hours with your head down.

SISTER AGNES: "If that sentence was true, show me how. If it wasn't, fix it."

How do you answer?

+ ["My teacher's comments are harsh. Sometimes they feel personal." (about 6 min)]
    ~ feedbackTruth = "deflect"
    -> A_Feedback_Result
+ ["I was embarrassed after the midterm, so I hid the comments." (about 6 min)]
    ~ feedbackTruth = "honest"
    ~ honestyCount = honestyCount + 1
    ~ feedbackPlan = "Schedule a ten-minute check-in after each submission and reply the day feedback is posted."
    -> A_Feedback_Result
+ ["I skimmed them. I was overwhelmed and told myself I'd reply later." (about 6 min)]
    ~ feedbackTruth = "half_truth"
    -> A_Feedback_Result

// ════════════════════════════════════════════════════════════════════════════
=== A_Feedback_Result ===
{ feedbackTruth == "honest":
    "I bombed that draft," you admit. "Every time I thought about it felt like proof I wasn't cut out for this, so I just… didn't."
    Agnes tilts her head.
    SISTER AGNES: "Then write what you'll do with the next set of comments the moment they appear."
    { feedbackPlan != "":
        You type: {feedbackPlan}.
    }
    Malik squeezes your shoulder.
    MALIK: "I'm with you on that."
}{feedbackTruth == "half_truth":
    You exhale. "I skimmed them. I just… didn't have the energy to answer that night."
    Agnes taps the screen until the unread icon blinks red.
    SISTER AGNES: "Name your feeling. If you are overwhelmed, say it, then set a reminder for later. Skimming is not reading."
    The Tracker's minute hand jumps.
}{ feedbackTruth == "deflect":
    You fold your arms. "Her notes are brutal. It's hard not to take them personally."
    Agnes' voice stays calm, which somehow feels worse.
    SISTER AGNES: "Feedback isn't a compliment service, but it should still be used. If the tone stings, write how you'll cope next time instead of ignoring it."
    The clock coughs up two precious minutes.
}

Malik scrolls your draft and taps a paragraph where he left comments earlier tonight.

MALIK: "Want me to read what I wrote? We can fix it now while Agnes is still here."

The clock ticks. You can take the help now or keep the clock moving.

+ ["Read it. I'll revise while you talk." (about 6 min)]
    ~ feedbackApplied = true
    -> A_Feedback_Edit
+ ["Later. We need to keep moving." (about 2 min)]
    ~ feedbackApplied = false
    -> A_Feedback_Edit

// ════════════════════════════════════════════════════════════════════════════
=== A_Feedback_Edit ===
{ feedbackApplied:
    Malik reads the teacher's note aloud. You slice the bloated sentence in half, add the missing deadline from the agenda page, and type a reminder to ask about the part you still don't understand when you rewind the week. Malik's grin is quick but genuine.
    MALIK: "See? That already sounds like you."
- else:
    Malik lowers his pencil.
    MALIK: "Okay, but that paragraph is still going to sting tomorrow."
    The unread notification keeps pulsing at the edge of your vision.
}

-> A_Finalize

// ════════════════════════════════════════════════════════════════════════════
=== A_Finalize ===
You pull the tunnels agenda and the cemetery goal tracker closer and let their ink guide the last paragraph. You copy the fragments you wrote under each prompt and the SMART line you set at the gate. Malik leans in, ready to call out anything that slips back into performance.

{ honestyCount >= 3 || essayHonest:
    { honestyCount >= 3:
        You cite the promises you made tonight.
    - else:
        You stop dodging and put the promises in ink.
    }
    { not agendaDamaged:
        You quote the fragments you wrote under each agenda prompt, naming where you stalled and how you moved tonight.
    - else:
        The agenda fragments smear at the edges, so you paraphrase what you can make out.
    }
    { not pageDamaged:
        You restate the SMART promise from the tracker in full.
    - else:
        The SMART line is feathered, so you rebuild it from memory and write it again.
    }
    The agenda paragraph ties your outline promise to a real time slot.
    The group project section owns the missed meeting and names the repair.
    The feedback section names the avoidance and the routine you will use next.
    { feedbackApplied:
        It also includes the line Malik just helped you revise.
    }
    { planStyle == "cloud":
        You drop a citation to the shared folder you built at the start of the night, proving the plan now lives somewhere other than your head.
    }{ planStyle == "paper":
        You reference the ink-stained checklist from earlier, evidence that you're tracking each step.
    }{ planStyle == "desktop":
        You mention the impromptu desktop folder. It is messy but real, so the essay admits the actual system you used.
   }{ planStyle == "memory":
        You confess that relying on memory nearly cost you the tunnels task, promising a new guardrail in writing.
    }
    By the end of the draft, the essay reads like instructions future-you could actually follow.
    ~ essayHonest = true
    -> A_Result
- else:
    You try to weave tonight's lessons into the draft, but the sentences keep sliding back into slogans. You mention the agenda, the goals, the feedback, yet the lines stay vague. Malik's pen hovers over the margin, waiting for specifics that never land.
    { archiveTimeThin:
        The answers are too short to hold the truth together.
    }
    { archiveDocsRough:
        Smudged pages leave gaps you cannot fill tonight.
    }
    ~ essayHonest = false
    Agnes nudges the laptop back toward you.
    SISTER AGNES: "One more pass if the clock allows. Rewrite with the truth, or hand it in and live with it."
    + [Rewrite honestly (about 10 min — fuller revision)]
        -> A_Rewrite_Do
    + [Hand it in anyway]
        -> A_Result
}

// ════════════════════════════════════════════════════════════════════════════
=== A_Rewrite_Do ===
You breathe, clear the vague sentences, and force yourself to write what you actually did and why. The clock ticks loudly in the narrow room. Malik reads each line back to you as you type.

~ essayHonest = true

-> A_Result

// ════════════════════════════════════════════════════════════════════════════
=== A_Result ===
{ taskTunnelsDone && taskCemeteryDone && essayHonest:
    Sister Agnes reads the final paragraph on the laptop, nodding once. The agenda notes, the cemetery goals, and the honest reflection sit inside the draft like ribs, holding it up.
    SISTER AGNES: "This is the self-improvement essay I was promised. You faced the work, and you proved how you'll keep facing it."
    { feedbackApplied:
        She taps the revised line Malik helped you fix — a quiet nod for taking the help when it mattered.
    }
    She sets a tarnished pocket watch in your palm. The hands spin once and settle on last Monday's sunrise.
    SISTER AGNES: "Take the week back. Remember what you wrote here. Live it."
    Malik lets out a laugh that sounds equal parts exhausted and relieved.
    MALIK: "We get a redo. Let's make it count."
    -> End_Epilogue_Success

}{ taskTunnelsDone && taskCemeteryDone && not essayHonest:
    You finish before the DEADline. The agenda and goal tracker prove you did the work tonight, but the essay still dodges the raw edges. Agnes reads the last paragraph on the screen and leans back.
    SISTER AGNES: "You met the deadline, but you're still telling yourself half-truths. Without honesty, a plan is just ink."
    The pocket watch stays on her side of the desk. She slides the laptop back toward you. You leave with your draft and the plan you typed tonight, knowing it will land with the same dull thud it always has.
    -> End_Epilogue_NoReset

- else:
    { not taskTunnelsDone && not taskCemeteryDone:
        You came without both pages. The reset cannot begin.
    }{ taskTunnelsDone && not taskCemeteryDone:
        The agenda page sits on the table. The goal tracker never made it here.
    }{ taskCemeteryDone && not taskTunnelsDone:
        The goal tracker sits on the table. The agenda page never made it here.
    }
    Agnes' expression hardens, and the doors remain shut.
    SISTER AGNES: "This place keeps what remains unfinished."
    -> End_Epilogue_Failure
}

// ════════════════════════════════════════════════════════════════════════════
=== End_Epilogue_Success ===
Cold air bites your cheeks as the doors open. The pocket watch in your hand hums once, then settles on last Monday morning. You look at Malik and say it out loud, fast and excited, like you're afraid the promise might slip away.

"Okay, Sunday outline.
{ mondayPlan != "":
    I'll do it like this: {mondayPlan}
- else:
    I'm actually doing it.
}
{ groupPlan != "":
    And for the group, {groupPlan}
}
{ feedbackPlan != "":
    And when feedback hits, {feedbackPlan}
}"

Malik leans close, grinning like he can finally see it.

MALIK: "We get to do it over. Let's do what we promised."

In the foyer glass, Sister Agnes nods once and thins to daylight.

When your eyes open again it's Monday morning. The watch shows 7:02 AM, your phone buzzes with Malik's "Outline today? I'm in." text, and sunlight cuts across your desk exactly the way it did a week ago. Only this time your agenda already waits open beside the keyboard.

-> The_End

// ════════════════════════════════════════════════════════════════════════════
=== End_Epilogue_NoReset ===
The doors open just before 5:00 AM. Snow needles your face as you and Malik step outside, clutching the essay you know isn't the whole truth. No pocket watch waits in your hand.

MALIK: "We'll turn this in, but probation's still watching. Next time we stick to the plan, okay?"

You nod. The only way forward now is to earn a second chance the slow way. The DEADline Tracker still shows the notes you wrote tonight.
{ mondayPlan != "":
    Sunday outline: {mondayPlan}
}
{ groupPlan != "":
    Group fix: {groupPlan}
}
{ feedbackPlan != "":
    Feedback routine: {feedbackPlan}
}
This time you'll have to follow them without Agnes' help.

By the time Monday morning sun hits your blinds, the alarm feels cruel, but the checklist you wrote in the archives still glows in your Notes app. No rewind. Just a choice to do the work awake.

-> The_End

// ════════════════════════════════════════════════════════════════════════════
=== End_Epilogue_Failure ===
The DEADline passes. The shelves murmur the tally of what bound you. The doors remain shut. Agnes watches in silence as the library settles back into its cold hum.

SISTER AGNES: "This place keeps what remains unfinished. The night begins again."

The clock resets. You'll carry what you learned — if you learned anything. The stairs wait.

-> The_End

// ════════════════════════════════════════════════════════════════════════════
=== The_End ===
// Thanks for playing this arc.

+ [Restart from the beginning]
    -> Intro_Library_01
+ [Jump to Decision Point 1 (after intro, choices intact)]
    -> D1_Choice

-> END
