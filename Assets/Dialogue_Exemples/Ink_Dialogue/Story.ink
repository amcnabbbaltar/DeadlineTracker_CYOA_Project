// ==========================
// DEADline Tracker v2.1.0
// ==========================

VAR time = 15
VAR deadline = 300
VAR hudEnabled = false
VAR organization = 0
VAR respect = 0
VAR relationshipMalik = 0
VAR planStyle = ""
VAR careKit = false
VAR scanBackups = false
VAR taskTunnelsDone = false
VAR taskCemeteryDone = false
VAR tasksCompleted = 0
VAR thesisQuality = ""
VAR pageDamaged = false
VAR cemPreserved = false
VAR routePlan = ""
VAR routeChoice = ""
VAR tRoute = ""
VAR goalMode = ""
VAR planHasBuffer = false
VAR focusMode = false
VAR loreTunnels = 0
VAR clueChalk = false
VAR hasFlashlight = false
VAR mc_intro02 = ""
VAR hudPrinciples = true
VAR loreAgnes = 0
VAR stress = 0
->intro_library_01
// ========== INTRO SEQUENCE ==========

=== intro_library_01 ===
# background:backgrounds/library-1
# character:character/mc
It's midnight in mid December in Montreal.  
Snow flecks the Vanier library windows, and the lights hum the way they do when most people have gone home.  
The library is open for all-night study sessions during exams. 

+ [Continue] -> intro_library_02

=== intro_library_02 ===
# background:backgrounds/library-2
# character:character/mc
You and Malik have been here for hours, trying to finish a project that still feels too big.

Last semester was rough. You missed too many deadlines and barely passed.  
You tried to get organized, but things kept sliding.  
You don’t want academic probation. You promised this semester would be different.

+ [Continue] -> intro_library_03

=== intro_library_03 ===
# character:character/malik
Malik (tired): Let's keep it simple. One all-nighter. We can do that.

You check the time without wanting to. The minute hand keeps moving either way.

+ [Continue] -> intro_cold_flicker_01


=== intro_cold_flicker_01 ===
# background:backgrounds/library-5
# character:character/mc
The library changes in ways that are hard to name.  
The vents hush. The heat seeps away from the room.  
Fluorescents flicker once, then settle into a sickly yellow.
+ [Continue] -> intro_cold_flicker_02
=== intro_cold_flicker_02 ===
A draft moves through the stacks, colder than it should be.  
It smells like candle smoke and old wax. Somewhere in the dark, a book falls—loud enough to make both of you flinch.
+ [Continue] -> intro_cold_flicker_03
=== intro_cold_flicker_03 ===
# character:character/malik
Malik (low): People say this place gets weird after midnight. We should go.
+ [Continue] -> intro_cold_flicker_04
=== intro_cold_flicker_04 ===
You slide your agenda into your bag. It feels heavier than before.

+ [Continue] -> intro_agnes_appears1


=== intro_agnes_appears1 ===
# background:backgrounds/library-4
# character:character/nun
A figure stands at the end of the aisle, half in shadow.  
The fabric of her habit hangs in thin folds. Where her face should be warm, there is only cool darkness.
+ [Continue] -> intro_agnes_appears2
=== intro_agnes_appears2 ===
# character:characters/nun
Sister Agnes: When Vanier was a convent I taught here. You remind me of two of my own pupils.  
I let them down. They never finished their thesis because I missed too much.  
This building does not forgive. The thesis was lost, and Vanier has kept me and my students here for all these years.  
+ [Continue] -> intro_agnes_appears3
=== intro_agnes_appears3 ===
Sister Agnes: Now Vanier has its eyes on you.  
You must complete the lost thesis before dawn.  
Find the missing sources and finish it. If you fail, you’ll never leave.  

Sister Agnes: One page lies in the tunnels under the N building.  
Another, in the cemetery. Bring them to the archives and complete the thesis.

~ hudEnabled = true
# character:character/malik
Malik (barely): This is insane. We need to get out of here!

Do you believe what you just saw?

+ [Believe Malik. This is real] -> d1_setup_01
+ [Stay skeptical. Maybe you're seeing things] -> d1_setup_01


=== d1_setup_01 ===
# character:character/nun
Sister Agnes thins like smoke and parts on a draft.  
# character:character/mc
The scent of old paper clings to your sleeves.  

Your phone buzzes. # character:character/phone
A new icon wakes on the screen, red and steady. Malik's hands shake and the phone slips, but you catch it before it hits the floor. # character:character/phone

+ [Continue] -> d1_setup_02


=== d1_setup_02 ===
# background:backgrounds/library-5
The DEADline App has installed itself on your phone. # character:character/phone
Your missions appear on the screen: # character:character/phone

+[Continue] --> d1_setup_02_1
=== d1_setup_02_1 ===
# background:backgrounds/library-6
# character:character/mc
Before dawn, find two missing working pages and finish your part.  
In the tunnels: Find the evening study schedule.  
At the cemetery: Find the intentions log.  
In the archives: Finish the thesis.

+[Continue] --> d1_setup_02_2
=== d1_setup_02_2 ===

It’s currently {time} minutes past midnight.  
Remaining: {deadline - time} minutes.  
How do you want to keep track of everything?

+ [Set up a single folder in your cloud drive (+3m)]
    ~ time += 3
    ~ organization += 1
    ~ planStyle = "cloud"
    -> d1_setup_04
+ [Make a paper list in your notebook (+2m)]
    ~ time += 2
    ~ planStyle = "paper"
    -> d1_setup_04
+ [Quick desktop folder (+1m)]
    ~ time += 1
    ~ planStyle = "desktop"
    -> d1_setup_04


=== d1_setup_04 ===
# character:character/phone
The DEADline app suggests some things you might want to have tonight.  
Gathering them will take time.

Do you want to build a small document care kit (microfiber cloth, clear sleeves, binder clips)?

{careKit == false:
    + [Assemble care kit (+8m)]
        ~ time += 8
        ~ careKit = true
        ~ organization += 1
        -> after_kit
    + [Skip the kit for now]
        -> after_kit
- else:
    'Care kit ready.'
    -> after_kit
}

=== after_kit ===
# character:character/mc
Do you want to set up a quick way to take clear photos of any page you find?

{scanBackups == false:
    + [Set up photo capture (+4m)]
        ~ time += 4
        ~ scanBackups = true
        -> d1_choice
    + [Skip setup]
        -> d1_choice
- else:
    'Photo setup ready.'
    -> d1_choice
}


=== d1_choice ===
You check the next steps in the DEADline App. # character:character/phone
Before dawn, find the missing pages and finish the thesis.

What do you do first?

+ [Get started on the tasks now] -> task_hub
+ [Search at a library terminal (+10m)]
    ~ time += 10
    -> d1_research_01


=== d1_research_01 ===
# character:character/mc
# background:backgrounds/libary-6
You grab an open library terminal.  
The room is colder than it should be. The cursor blinks, waiting.

+ [Search for “Sister Agnes Vanier” (+12m)]
    ~ time += 12
    ~ organization += 1
    ~ loreAgnes += 1
    -> d1_research_02
+ [Skim maintenance maps for tunnel notes (+12m)]
    ~ time += 12
    ~ loreTunnels += 1
    -> d1_research_02
+ [Skim fast. Trust your instincts (+4m)]
    ~ time += 4
    -> d1_research_02


=== d1_research_02 ===
You find short campus histories:  
The library was once a convent chapel.  
Two cemeteries sit beside the grounds, one for the parish, one for the Sisters.  
In the 1960s, records were moved in a rush when the site changed hands.  

You find conflicting notes about chalk marks in the tunnels.  
Some say they mark safe routes; others say they fade.

+ [Photograph tunnel maps (+18m)]
        ~ time = time + 18
        ~loreTunnels = loreTunnels + 1 
        ~clueChalk = true
        ~organization = organization + 1
    -> task_hub
+ [Copy tunnel diagram by hand (+12m)]
    ~ time = time + 12
    ~ loreTunnels = loreTunnels + 1
    -> task_hub
+ [Skim and trust memory (+4m)]
    ~ time = time + 4 
    -> task_hub
    // ==========================
// PART 2 — TUNNELS ARC
// ==========================

VAR tunnelStartTime = 0

// Entry + setup
=== t_setup_01 ===
~ tunnelStartTime = time
// Optional: raise requirements like Twine did (purely narrative here)
# background:backgrounds/tunnel1
The stairwell sign reads *Tunnels*. The air from below smells like damp brick and old heating.  
Your phone light makes a small circle that looks smaller the longer you stare at it. # character:character/phone

# character:character/malik
Malik (hushed): We go.

Your phone shows a small note: *Find the study schedule page.* The clock keeps counting. # character:character/phone

A small card opens on the screen: # character:character/phone
*DEADline: Evening Study Schedule (Planning)*  
• Objective: Find the study schedule page used to plan a night of work.  
• Clue: Follow service lines toward maintenance rooms; match chalk ghosts at junctions.  
• Why it matters: Gives you language you can cite and a plan you can use tonight.

How do you start?

+ [Set a quick route plan: mark turns, map as you go, check in with Malik every 5 minutes (+3m)]
    ~ time = time + 3
    ~ routePlan = "planned"
    ~ organization  = organization + 1
    -> t_setup_04

+ [Move by instinct. Adjust as you go (+2m)]
    ~ time = time + 2
    ~ routePlan = "instinct"
    -> t_setup_04

{loreTunnels > 0:
    + [Use your earlier research: match chalk photos to wall marks (+2m)]
        ~ time += 2
        ~ routePlan = "clues"
        -> t_setup_04
}

// Route phase (cost gates derived from Twine logic)
=== t_setup_04 ===
# background:backgrounds/tunnel2

The tunnels breathe in slow drafts. Your steps echo into places you can’t see.

{routePlan == "planned":
    You set a workable rhythm. Walk five minutes, then stop, mark, check...
}

{routePlan == "instinct":
    You move with the draft and the sound of water...
- else: // "clues"
    You hold the chalk marks in your head or in your photos...
}

~ temp targetT = 90
VAR chalkAdj = 0

 {routePlan == "clues" and clueChalk :
    ~ chalkAdj = -5
 }

~ temp elapsedT = time - tunnelStartTime
~ temp needT_rows = MAX(0, (targetT + 0  + chalkAdj) - elapsedT)
~ temp needT_diag = MAX(0, (targetT + 8  + chalkAdj) - elapsedT)
~ temp needT_verify = MAX(0, (targetT + 3  + chalkAdj) - elapsedT)

How do you press on?

+ [Hug the service line; work each branch in order (adds {10 + needT_rows}m)]
    ~ time += (10 + needT_rows)
    ~ tRoute = "rows"
    -> t_find

+ [Cut a faster diagonal; stop at each junction to check marks (adds {6 + needT_diag}m)]
    ~ time += (6 + needT_diag)
    ~ tRoute = "diagonal"
    -> t_find

+ [At each turn, leave a sign and verify chalk vs photo before committing (adds {8 + needT_verify}m)]
    ~ time += (8 + needT_verify)
    ~ tRoute = "verify"
    ~ organization += 1
    -> t_find


=== t_find ===
# background:backgrounds/tunnel3
The corridor kinks left, then right, and opens into a low space that smells like oil and mop water.  
The pipe widens and the floor slopes to a drain. It is a maintenance room, like you expected.  
On the back of a service door, under a film of dust, something waits where no one thinks to tidy up.

A study schedule page. The handwriting is steady even where the paper buckles.

~ temp extra = 0
{routePlan == "instinct" && tRoute == "diagonal":
    ~ extra += 3
}
{routePlan == "clues":
    {clueChalk:
    ~ extra += -2
    }

}
{tRoute == "verify":
    ~ extra += -1
}
~ extra = MAX(0, extra)
{ extra > 0:
    Your detour costs a few minutes, but you made it.
}

{extra > 0:
    ~ time += extra
}

Your DEADline App buzzes in your pocket. # character:character/phone

+ [Check your phone (+2m)]
    ~ time += 2
    ~ taskTunnelsDone = true
    ~ tasksCompleted += 1
    -> t_page_principles


=== t_page_principles ===
# background:backgrounds/tunnel4
# character:character/phone
The DEADline App shows a new achievement called *Principle Scroll*: # character:character/phone

1) Plan and track: keep one trusted list of tasks and due dates. Break work into steps. Finish on time.  
2) Timeline and buffer: give each step a slice of time and a little slack so delays don’t break the plan.  
3) Mark and verify: leave yourself signs and check them so you don’t lose your place.

The app marks the tunnels task complete.

+ [Continue] -> task_hub
// ==========================
// PART 3 — CEMETERY ARC
// ==========================

VAR cemStartTime = 0

VAR markedPath = false

=== c_entry_01 ===
~ cemStartTime = time
# background:backgrounds/cimetary1
Fog rims the iron gate. The dates on the nearest stones sit like held breaths.  
Your phone hums, then shows a small note before going still: # character:character/phone

*"Leave with the page intact."*

# character:character/malik
Malik (hushed): Okay. What are we trying to leave with?

A small card opens on the screen: # character:character/phone
*DEADline: Intentions Log (Goals)*  
• Objective: Recover the intentions page intact.  
• Clue: Look near a gate box: drier edge, faint rust shadow, disturbed gravel.  
• Why it matters: Goals that hold — clear promises with times you can check.

+ [Enter] -> c_setup_01


=== c_setup_01 ===
# background:backgrounds/cimetary2
The path is soft underfoot. Cold settles in your sleeves.

You steady your notebook on a dry stone. The phone’s note lingers at the edge of your thoughts: # character:character/phone
*"Leave with the page intact."* Not just *found.* Intact.

Sister Agnes (near): Write exactly what you will finish, and by when.# character:character/nun

How do you set your aim?

+ [Methodical search: slower but safer (+5m)]
    ~ time += 5
    ~ goalMode = "clear"
    -> c_search

+ [Quick aim: find the page fast and protect it later (+1m)]
    ~ time += 1
    ~ goalMode = "quick"
    -> c_search

+ [Co-write the goals with Malik: you scan, he marks turns (+3m)]
    ~ time += 3
    ~ goalMode = "coauth"
    ~ relationshipMalik += 1
    -> c_search


=== c_search ===
# background:backgrounds/cimetary3
Your words pull the night into shape.

{goalMode == "clear":
    You move along the higher ground where the grass is paler and the stones stay clean longer.  
    Ten minutes in, you’ve covered two rows and marked three to check again.  
    At forty, you circle back to a disturbance you missed the first time.
- else:
    {goalMode == "quick":
        You cut diagonals through the tombstones, counting under your breath.  
        The fog makes corners slippery. You tell yourself you’ll sort the rest out later.
    - else:
        
        Malik taps your shoulder at quiet intervals and touches the fence at each turn so you don’t loop.  
        When you point at a likely spot, he nods and draws a tiny X on the page.
    }
}

~ temp targetS = 50
{goalMode == "quick":
    ~ targetS -= 10
}
{goalMode == "coauth":
    ~ targetS -= 5
}
~ temp elapsedS = time - cemStartTime
~ temp needS = MAX(0, targetS - elapsedS)

How do you press on?

+ [Work the edge and take it row by row (adds {8 + needS}m)]
    ~ time += (8 + needS)
    ~ routeChoice = "rows"
    -> c_find

+ [Cut a fast grid and chase fresh signs (adds {6 + needS}m)]
    ~ time += (6 + needS)
    ~ routeChoice = "grid"
    -> c_find

+ [Mark your path and verify before you commit (adds {7 + needS}m)]
    ~ time += (7 + needS)
    ~ routeChoice = "mark"
    ~ markedPath = true
    -> c_find


=== c_find ===
# character:character/mc
Behind a cracked stone, half a handspan above the wet line, you spot it:  
a shallow hollow with a rust lip where something’s been and gone and come back.  
The tin is there, cold and ordinary. Inside, a single page; the paper thin as breath, the ink still dark.

You said you’d leave with it intact. What do you do?

+ [Protect first, then lift (+6m)]
    ~ time += 6
    ~ pageDamaged = false
    -> c_result

+ [Lift now; sort the rest later (+1m)]
    ~ time += 1
    ~ pageDamaged = true
    -> c_result


=== c_result ===
You lift the page free. The ink shivers but holds.

{pageDamaged == false:
    The text lies flat. Your shoulders come down when you check the time and see you’re still on schedule.
- else:
    The fragile page rips. You can still read it, but you’ll have to handle it carefully now.
}

~ taskCemeteryDone = true
~ cemPreserved = not pageDamaged
~ tasksCompleted += 1

~ temp baseC = 70
{goalMode == "quick":
    ~ baseC += 8
}
{careKit == false:
    ~ baseC += 5
}
{goalMode == "coauth":
    ~ baseC -= 3
}
~ temp elapsedC = time - cemStartTime
~ temp deltaC = MAX(0, baseC - elapsedC)

{deltaC > 0:
    You spend the next {deltaC} minutes getting the page home safe.  
    You seal it in the sleeve, note the gate box in your notebook,  
    and walk the rows back the way you came without cutting corners.
    ~ time += deltaC
}

+ [Continue] -> c_page_principles


=== c_page_principles ===
At the gate, your phone buzzes and a new achievement appears on the DEADline App. # character:character/phone

SMART Goals:  
– Specific & Relevant: say exactly what “done” is and why.  
– Measurable & Time-bound: put a time to it so you know.  
– Achievable with a plan: choose a route and guardrails that fit the place.

+ [Continue] -> task_hub
// ==========================
// PART 4 — ARCHIVES ARC & ENDINGS
// ==========================

VAR archStartTime = 0
VAR archCostIntegrate = 0
VAR archCostRush = 0
VAR archCostImprove = 0

=== a_entry_01 ===
~ archStartTime = time

The archive door drags shut and seals the air.  
A desk lamp breathes a small circle of light. Beyond it, the shelves lean like ribs.  
The typewriter rattles a few keys on its own and stops, as if it choked on a word.

Your phone shows one line and a clock that does not blink: *"Finish and hand it in."* # character:character/phone

A small card opens on the screen: # character:character/phone
*DEADline: Finish the thesis*  
• Objective: Build a clean section from the two pages, then use them to finish the thesis.  
• Clue: Make headings from the page lines, read aloud, ask for help, cut once more.  
• Why it matters: Finished, readable work is what will let you leave this place.

Cold slides under your cuffs. The building listens.

Sister Agnes (near): Finish before dawn, or walk these halls with me.

+ [Continue] -> a_setup_01


=== a_setup_01 ===
You place the study schedule page in the light.  
The principles you found in the tunnels sit at the top of your notes, waiting to breathe.
# character:character/nun
Sister Agnes (near): Stop collecting scraps and build the page you will hand in.

~ temp rem = MAX(0, deadline - time)

// Precompute method costs
~ archCostIntegrate = 90
{scanBackups:
    ~ archCostIntegrate -= 5
}
{organization >= 1 or planStyle == "cloud":
    ~ archCostIntegrate -= 5
}
{planHasBuffer:
    ~ archCostIntegrate -= 3
}
{pageDamaged:
    ~ archCostIntegrate += 5
}
~ archCostIntegrate = MAX(70, archCostIntegrate)

~ archCostRush = 40
{pageDamaged:
    ~ archCostRush += 5
}
~ archCostRush = MAX(30, archCostRush)

~ archCostImprove = 105
{relationshipMalik >= 1:
    ~ archCostImprove -= 5
}
{planHasBuffer:
    ~ archCostImprove -= 3
}
{scanBackups:
    ~ archCostImprove -= 2
}
{pageDamaged:
    ~ archCostImprove += 3
}
~ archCostImprove = MAX(85, archCostImprove)

What approach do you take to finish?

{rem >= archCostIntegrate:
    + [Integrate methodically (+{archCostIntegrate}m)]
        ~ time += archCostIntegrate
        ~ thesisQuality = "integrated"
        -> a_result
- else:
    (Need {archCostIntegrate}m; only {rem}m left)
}

{rem >= archCostRush:
    + [Rush a compile (+{archCostRush}m)]
        ~ time += archCostRush
        ~ thesisQuality = "rushed"
        -> a_result
- else:
    (Need {archCostRush}m; only {rem}m left)
}

{rem >= archCostImprove:
    + [Improve with feedback (+{archCostImprove}m)]
        ~ time += archCostImprove
        ~ thesisQuality = "improved"
        -> a_result
- else:
    (Need {archCostImprove}m; only {rem}m left)
}

{rem < archCostRush:
    You don’t have enough time for any proper finishing method.
    The clock chews the minutes.
    + [Do what you can (run out of time)]
        ~ thesisQuality = "none"
        ~ time = deadline + 1
        -> end_result
}


=== a_result ===
You sit back and listen to the building breathe.
{ thesisQuality == "integrated":
    The draft reads in one breath. Your file names make sense even to future-you.
    The schedule, intentions, and revision lines sit inside your work now, visible in the steps.
    When you flip a page, the typewriter doesn’t flinch.

-  else: 
    {thesisQuality == "rushed":
        It exists, whole enough to submit, but the seams show.
        Two headings almost rhyme by accident. A draft paragraph you meant to delete is probably still in there.
        The lamp hums like it has an opinion.
    
    - else:
        It reads like it knew what you would ask before you asked it.
        { relationshipMalik >= 1:
            Malik taps the closing line and grins his quick, thin grin — proud but trying not to show it.
        }
    }
}
# character:character/nun
Sister Agnes (near): A finished section carries you farther than a pile of notes.

+ [Continue] -> a_page_principles


=== a_page_principles ===
# character:character/phone
Your phone buzzes and the final achievement appears on the DEADline App. # character:character/phone

• Integrate and check: gather the pieces, shape one clean version, then verify it reads the way you intend.  
• Use feedback: ask a reader what is unclear or missing and act on what you hear.  
• Revise and improve: small, focused edits lift the work; take initiative to close gaps.

+ [Continue] -> end_result


=== end_result ===
~ temp onTime = (time <= deadline)
~ temp care = (not pageDamaged or cemPreserved)
~ temp work = (thesisQuality == "improved" or thesisQuality == "integrated")
~ temp barely = (thesisQuality == "rushed")
~ temp allTasks = (taskTunnelsDone and taskCemeteryDone)

// Success path
{ allTasks and onTime and work and care:
    Sister Agnes gathers from the corners of the room as dawn bleaches the windows.  
    Sister Agnes: This is the Temporal Organizer. It belongs to those who finish what they start and care for their work as if it were living.

    Your phone changes in your hand. It keeps clean versions, remembers next steps, and does the small things that used to trip you. # character:character/phone
    # character:character/malik
    Malik exhales.  
    Malik: It feels like the opposite of panic. With this, we’re going to be able to finish our own project and get through the rest of the semester.

    + [Walk out into the snow with Malik] -> end_epilogue_success

- else:
    {allTasks and onTime and (work or barely):
        # character:character/nun
        Light pushes at the windows and then hesitates. Sister Agnes stands near the typewriter, not quite smiling.  
        Sister Agnes: You escaped the worst of it. Keep one list you trust. Leave room to adjust. Ask for help when you can’t see what’s missing.
    
        Malik: That was close... and weird. We’ll have to do better next time.
    
        + [Step into the morning. Keep improving] -> end_epilogue_mixed
    
    - else:
        The library swallows the light as the clock nears {deadline}.  
        The carriage slides home with a sound like a lid.  
        Sister Agnes: This place keeps what’s unfinished. Stay. Help me keep the shelves in order.
    
        + [The halls do not let you go] -> end_epilogue_failure
    }
}



=== end_epilogue_success ===
Cold air bites your cheeks as the doors open.  
Snow drifts down in small, forgiving flakes.  
Your phone shows *Today, Next Up,* and a tidy list that matches what you actually do. # character:character/phone
# character:character/malik
Malik: No one will believe us. But I know what to do next. And after that.

In the glass of the foyer, for a heartbeat, Sister Agnes nods once and thins to daylight.

+ [Continue] -> the_end


=== end_epilogue_mixed ===
Later that day, your reflection looks steadier.  
You missed some polish, but your plan kept you on time.  
You write a short check-in for yourself and add one change you will try next week.

+ [Continue] -> the_end


=== end_epilogue_failure ===
The doors do not open. The lamps dim.  
Footsteps that are not yours pass by and do not pause.  
# character:character/Malik
Malik grips your hand. You feel him count his breaths like you did in the stairwell.  
# character:character/nun
Sister Agnes: There is work to do. We will teach the living how to finish.

+ [Continue] -> the_end


=== the_end ===
# character:character/phone
Thanks for playing *DEADline Tracker*.  

{deadline - time > 0:
    You finished with {deadline - time} minutes to spare.
- else:
    You didn’t quite hit the DEADline.
}

+ [Restart from the beginning] -> intro_library_01
+ [Jump to Decision Point 1] -> d1_choice

=== task_hub ===
You check the DEADline App. # character:character/phone
The red icon pulses once, then settles. Your tasks sit in a neat column:

{taskTunnelsDone:
    • Tunnels: Study Schedule Page — ✓ Completed  
- else:
    • Tunnels: Study Schedule Page — Not yet found  
}

{taskCemeteryDone:
    • Cemetery: Intentions Log — ✓ Completed  
- else:
    • Cemetery: Intentions Log — Not yet found  
}

{tasksCompleted == 2:
    A faint outline of the Archives task brightens as if waiting for you.
- else:
    The Archives task remains dim, locked until the others are complete.
}

Remaining time: {deadline - time} minutes.

What do you do now?

{not taskTunnelsDone:
    + [Head for the tunnels] -> t_setup_01
}

{not taskCemeteryDone:
    + [Head for the cemetery] -> c_entry_01
}

{taskTunnelsDone and taskCemeteryDone:
    + [Go to the Archives] -> a_entry_01
}

+ [Check your notes and pause a moment] 
    You breathe in the paper-and-dust air. The building waits.
    + [Back] -> task_hub
    