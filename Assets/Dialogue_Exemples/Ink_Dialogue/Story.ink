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
# background:backgrounds/library-2
# character:character/mc
It's midnight in mid December in Montreal.
+ [Continue] -> intro_library_01_1

=== intro_library_01_1 ===
Snow flecks the Vanier library windows, and the lights hum the way they do when most people have gone home.
+ [Continue] -> intro_library_01_2

=== intro_library_01_2 ===
The library is open for all-night study sessions during exams.
+ [Continue] -> intro_library_02

=== intro_library_02 ===
# character:character/mc
You and Malik have been here for hours, trying to finish a project that still feels too big.
+ [Continue] -> intro_library_02_a

=== intro_library_02_a ===
Last semester was rough.
+ [Continue] -> intro_library_02_b

=== intro_library_02_b ===
You missed too many deadlines and barely passed.
+ [Continue] -> intro_library_02_1

=== intro_library_02_1 ===
You tried to get organized, but things kept sliding.
+ [Continue] -> intro_library_02_2

=== intro_library_02_2 ===
You don't want academic probation.
+ [Continue] -> intro_library_02_3

=== intro_library_02_3 ===
You promised this semester would be different.
+ [Continue] -> intro_library_03

=== intro_library_03 ===
# character_1:character/mc
# character_2:character/malik
Malik (tired): Let's keep it simple.
+ [Continue] -> intro_library_03_1

=== intro_library_03_1 ===
One all-nighter. We can do that.
+ [Continue] -> intro_library_03_2

=== intro_library_03_2 ===
# character:character/mc
You check the time without wanting to.
+ [Continue] -> intro_library_03_3

=== intro_library_03_3 ===
The minute hand keeps moving either way.
+ [Continue] -> intro_cold_flicker_01


=== intro_cold_flicker_01 ===
# background:backgrounds/library-5
# character_1:character/mc
The library changes in ways that are hard to name.
+ [Continue] -> intro_cold_flicker_01_1

=== intro_cold_flicker_01_1 ===
# background:backgrounds/library-6
# character:character/mc
The vents hush.
+ [Continue] -> intro_cold_flicker_01_1a

=== intro_cold_flicker_01_1a ===
# character_2:character/mc
The heat seeps away from the room.
+ [Continue] -> intro_cold_flicker_01_2

=== intro_cold_flicker_01_2 ===
# background:backgrounds/library-5
# character:character/mc
Fluorescents flicker once, then settle into a sickly yellow.
+ [Continue] -> intro_cold_flicker_02

=== intro_cold_flicker_02 ===
A draft moves through the stacks, colder than it should be.
+ [Continue] -> intro_cold_flicker_02_1

=== intro_cold_flicker_02_1 ===
It smells like candle smoke and old wax.
+ [Continue] -> intro_cold_flicker_02_2

=== intro_cold_flicker_02_2 ===
# background:backgrounds/library-5
Somewhere in the dark, a book falls—loud enough to make both of you flinch.
+ [Continue] -> intro_cold_flicker_03

=== intro_cold_flicker_03 ===
# character_1:character/mc
# character_2:character/malik
Malik (low): People say this place gets weird after midnight.
+ [Continue] -> intro_cold_flicker_03_1

=== intro_cold_flicker_03_1 ===
We should go.
+ [Continue] -> intro_cold_flicker_04

=== intro_cold_flicker_04 ===
# character:character/mc
You slide your agenda into your bag.
+ [Continue] -> intro_cold_flicker_04_1

=== intro_cold_flicker_04_1 ===
It feels heavier than before.
+ [Continue] -> intro_agnes_appears1


=== intro_agnes_appears1 ===
# background:backgrounds/library-4
# character:character/nun
A figure stands at the end of the aisle, half in shadow.
+ [Continue] -> intro_agnes_appears1_1

=== intro_agnes_appears1_1 ===
The fabric of her habit hangs in thin folds.
+ [Continue] -> intro_agnes_appears1_2

=== intro_agnes_appears1_2 ===
Where her face should be warm, there is only cool darkness.
+ [Continue] -> intro_agnes_appears2

=== intro_agnes_appears2 ===
# character:character/nun
Sister Agnes: When Vanier was a convent I taught here.
+ [Continue] -> intro_agnes_appears2_1

=== intro_agnes_appears2_1 ===
You remind me of two of my own pupils.
+ [Continue] -> intro_agnes_appears2_2

=== intro_agnes_appears2_2 ===
I let them down.
+ [Continue] -> intro_agnes_appears2_3

=== intro_agnes_appears2_3 ===
They never finished their thesis because I missed too much.
+ [Continue] -> intro_agnes_appears2_4

=== intro_agnes_appears2_4 ===
This building does not forgive.
+ [Continue] -> intro_agnes_appears2_5

=== intro_agnes_appears2_5 ===
The thesis was lost, and Vanier has kept me and my students here for all these years.
+ [Continue] -> intro_agnes_appears3

=== intro_agnes_appears3 ===
# character:character/nun
Sister Agnes: Now Vanier has its eyes on you.
+ [Continue] -> intro_agnes_appears3_1

=== intro_agnes_appears3_1 ===
You must complete the lost thesis before dawn.
+ [Continue] -> intro_agnes_appears3_2

=== intro_agnes_appears3_2 ===
Find the missing sources and finish it.
+ [Continue] -> intro_agnes_appears3_3

=== intro_agnes_appears3_3 ===
If you fail, you'll never leave.
+ [Continue] -> intro_agnes_appears3_4

=== intro_agnes_appears3_4 ===
Sister Agnes: One page lies in the tunnels under the N building.
+ [Continue] -> intro_agnes_appears3_5

=== intro_agnes_appears3_5 ===
Another, in the cemetery.
+ [Continue] -> intro_agnes_appears3_6

=== intro_agnes_appears3_6 ===
Bring them to the archives and complete the thesis.
+ [Continue] -> intro_agnes_appears3_7

=== intro_agnes_appears3_7 ===
~ hudEnabled = true
# character_1:character/mc
# character_2:character/malik
Malik (barely): This is insane.
+ [Continue] -> intro_agnes_appears3_8

=== intro_agnes_appears3_8 ===
We need to get out of here!
+ [Continue] -> intro_agnes_appears3_choice

=== intro_agnes_appears3_choice ===
# character:character/mc
Do you believe what you just saw?

+ [Believe Malik. This is real] -> d1_setup_01
+ [Stay skeptical. Maybe you're seeing things] -> d1_setup_01


=== d1_setup_01 ===
# character:character/nun
Sister Agnes thins like smoke and parts on a draft.
+ [Continue] -> d1_setup_01_1

=== d1_setup_01_1 ===
# character:character/mc
The scent of old paper clings to your sleeves.
+ [Continue] -> d1_setup_01_2

=== d1_setup_01_2 ===
Your phone buzzes.
+ [Continue] -> d1_setup_01_3

=== d1_setup_01_3 ===
# character_1:character/mc
A new icon wakes on the screen, red and steady.
+ [Continue] -> d1_setup_01_4

=== d1_setup_01_4 ===
# character_2:character/mc
Malik's hands shake and the phone slips, but you catch it before it hits the floor.
+ [Continue] -> d1_setup_02


=== d1_setup_02 ===
# character:character/mc
The DEADline App has installed itself on your phone.
+ [Continue] -> d1_setup_02_a

=== d1_setup_02_a ===
Your missions appear on the screen:
+[Continue] --> d1_setup_02_1

=== d1_setup_02_1 ===
# background:backgrounds/library-6
# character:character/phone
Before dawn, find two missing working pages and finish your part.
In the tunnels: Find the evening study schedule.
At the cemetery: Find the intentions log.
In the archives: Finish the thesis.

+[Continue] --> d1_setup_02_2

=== d1_setup_02_2 ===
# character:character/phone
It's currently {time} minutes past midnight.
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
# character:character/mc
You check the next steps in the DEADline App.
+ [Continue] -> d1_choice_1

=== d1_choice_1 ===
# character:character/phone
Before dawn, find the missing pages and finish the thesis.

What do you do first?
+ [Get started on the tasks now] -> task_hub
+ [Search at a library terminal (+10m)]
    ~ time += 10
    -> d1_research_01


=== d1_research_01 ===
# character:character/mc
# background:backgrounds/library-7
You grab an open library terminal.
+ [Continue] -> d1_research_01_1

=== d1_research_01_1 ===
The room is colder than it should be.
+ [Continue] -> d1_research_01_2

=== d1_research_01_2 ===
The cursor blinks, waiting.
+ [Continue] -> d1_research_01_choices

=== d1_research_01_choices ===
+ [Search for "Sister Agnes Vanier" (+12m)]
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
# character:character/mc
# background:backgrounds/library-8
You find short campus histories:
+ [Continue] -> d1_research_02_1

=== d1_research_02_1 ===
The library was once a convent chapel.
+ [Continue] -> d1_research_02_2

=== d1_research_02_2 ===
# background:backgrounds/library-9
Two cemeteries sit beside the grounds, one for the parish, one for the Sisters.
+ [Continue] -> d1_research_02_3

=== d1_research_02_3 ===
In the 1960s, records were moved in a rush when the site changed hands.
+ [Continue] -> d1_research_02_4

=== d1_research_02_4 ===
You find conflicting notes about chalk marks in the tunnels.
+ [Continue] -> d1_research_02_5

=== d1_research_02_5 ===
Some say they mark safe routes; others say they fade.
+ [Continue] -> d1_research_02_choices

=== d1_research_02_choices ===
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
# character:character/mc
# background:backgrounds/library-9
+[Continue] --> t_setup_01_1

=== t_setup_01_1 ===
# character_1:character/mc
The stairwell sign reads *Tunnels*.
+[Continue] --> t_setup_01_1a

=== t_setup_01_1a ===
# character_2:character/mc
The air from below smells like damp brick and old heating.
+[Continue] --> t_setup_01_2

=== t_setup_01_2 ===
# background:backgrounds/tunnel1_dark
+[Continue] --> t_setup_01_3

=== t_setup_01_3 ===
# character:character/mc
# background:backgrounds/tunnel1_flashlight
Your phone light makes a small circle that looks smaller the longer you stare at it.
+[Continue] --> t_setup_01_4

=== t_setup_01_4 ===
# character_1:character/mc
# character_2:character/malik
Malik (hushed): We go.
+[Continue] --> t_setup_01_5

=== t_setup_01_5 ===
# character:character/mc
Your phone shows a small note: *Find the study schedule page.*
+[Continue] --> t_setup_01_5a

=== t_setup_01_5a ===
The clock keeps counting.
+[Continue] --> t_setup_01_6

=== t_setup_01_6 ===
# character:character/phone
A small card opens on the screen:
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

// Route phase
=== t_setup_04 ===
# character:character/mc
# background:backgrounds/tunnel2_dark
The tunnels breathe in slow drafts.
+[Continue] --> t_setup_04_a

=== t_setup_04_a ===
Your steps echo into places you can't see.
+[Continue] --> t_setup_04_1

=== t_setup_04_1 ===
# background:backgrounds/tunnel2_flashligth
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
# character:character/mc
# background:backgrounds/tunnel3_dark
The corridor kinks left, then right, and opens into a low space that smells like oil and mop water.
+[Continue] --> t_find_1

=== t_find_1 ===
# character_1:character/mc
The pipe widens and the floor slopes to a drain.
+[Continue] --> t_find_1a

=== t_find_1a ===
# character_2:character/mc
It is a maintenance room, like you expected.
+[Continue] --> t_find_2

=== t_find_2 ===
# character:character/mc
# background:backgrounds/tunnel3_flashlight
On the back of a service door, under a film of dust, something waits where no one thinks to tidy up.
+[Continue] --> t_find_3

=== t_find_3 ===
# character_1:character/mc
# background:backgrounds/tunnel4_dark
A study schedule page.
+[Continue] --> t_find_3a

=== t_find_3a ===
# character_2:character/mc
The handwriting is steady even where the paper buckles.
+[Continue] --> t_find_calc

=== t_find_calc ===
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
{extra > 0:
    ~ time += extra
}
{ extra > 0:
    Your detour costs a few minutes, but you made it.
}
+[Continue] --> t_find_buzz

=== t_find_buzz ===
# character:character/mc
Your DEADline App buzzes in your pocket.

+ [Check your phone (+2m)]
    ~ time += 2
    ~ taskTunnelsDone = true
    ~ tasksCompleted += 1
    -> t_page_principles


=== t_page_principles ===
# background:backgrounds/tunnel4_flashlight
# character:character/phone
The DEADline App shows a new achievement called *Principle Scroll*:

1) Plan and track: keep one trusted list of tasks and due dates. Break work into steps. Finish on time.
2) Timeline and buffer: give each step a slice of time and a little slack so delays don't break the plan.
3) Mark and verify: leave yourself signs and check them so you don't lose your place.
+ [Continue] -> t_page_principles_1

=== t_page_principles_1 ===
# character:character/mc
The app marks the tunnels task complete.
+ [Continue] -> task_hub

// ==========================
// PART 3 — CEMETERY ARC
// ==========================

VAR cemStartTime = 0

VAR markedPath = false

=== c_entry_01 ===
~ cemStartTime = time
# character:character/mc
# background:backgrounds/cemetery1
Fog rims the iron gate.
+ [Continue] -> c_entry_01_1

=== c_entry_01_1 ===
The dates on the nearest stones sit like held breaths.
+ [Continue] -> c_entry_01_2

=== c_entry_01_2 ===
Your phone hums, then shows a small note before going still.
+ [Continue] -> c_entry_01_3

=== c_entry_01_3 ===
# character:character/phone
The note reads: *"Leave with the page intact."*
+ [Continue] -> c_entry_01_4

=== c_entry_01_4 ===
# character_1:character/mc
# character_2:character/malik
Malik (hushed): Okay. What are we trying to leave with?
+ [Continue] -> c_entry_01_5

=== c_entry_01_5 ===
# character:character/phone
A small card opens on the screen:
*DEADline: Intentions Log (Goals)*
• Objective: Recover the intentions page intact.
• Clue: Look near a gate box: drier edge, faint rust shadow, disturbed gravel.
• Why it matters: Goals that hold — clear promises with times you can check.

+ [Enter] -> c_setup_01


=== c_setup_01 ===
# character:character/mc
# background:backgrounds/cemetery2
The path is soft underfoot.
+ [Continue] -> c_setup_01_1

=== c_setup_01_1 ===
Cold settles in your sleeves.
+ [Continue] -> c_setup_01_2

=== c_setup_01_2 ===
You steady your notebook on a dry stone.
+ [Continue] -> c_setup_01_3

=== c_setup_01_3 ===
The phone's note lingers at the edge of your thoughts.
+ [Continue] -> c_setup_01_4

=== c_setup_01_4 ===
You keep thinking: *"Leave with the page intact."* Not just *found.* Intact.
+ [Continue] -> c_setup_01_5

=== c_setup_01_5 ===
# character:character/nun
Sister Agnes (near): Write exactly what you will finish, and by when.
+ [Continue] -> c_setup_01_choices

=== c_setup_01_choices ===
# character:character/mc
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
# character:character/mc
# background:backgrounds/cemetery4
Your words pull the night into shape.
+ [Continue] -> c_search_1

=== c_search_1 ===
{goalMode == "clear":
    You move along the higher ground where the grass is paler and the stones stay clean longer.
- else:
    {goalMode == "quick":
        You cut diagonals through the tombstones, counting under your breath.
    - else:
        Malik taps your shoulder at quiet intervals and touches the fence at each turn so you don't loop.
    }
}
+ [Continue] -> c_search_2

=== c_search_2 ===
{goalMode == "clear":
    Ten minutes in, you've covered two rows and marked three to check again.
- else:
    {goalMode == "quick":
        The fog makes corners slippery.
    - else:
        When you point at a likely spot, he nods and draws a tiny X on the page.
    }
}
+ [Continue] -> c_search_3

=== c_search_3 ===
{goalMode == "clear":
    At forty, you circle back to a disturbance you missed the first time.
}
{goalMode == "quick":
    You tell yourself you'll sort the rest out later.
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
# character_1:character/mc
# background:backgrounds/cemetery3
Behind a cracked stone, half a handspan above the wet line, you spot it:
a shallow hollow with a rust lip where something's been and gone and come back.
+ [Continue] -> c_find_1

=== c_find_1 ===
# character_2:character/mc
The tin is there, cold and ordinary.
+ [Continue] -> c_find_2

=== c_find_2 ===
# character:character/mc
Inside, a single page; the paper thin as breath, the ink still dark.
+ [Continue] -> c_find_3

=== c_find_3 ===
You said you'd leave with it intact. What do you do?

+ [Protect first, then lift (+6m)]
    ~ time += 6
    ~ pageDamaged = false
    -> c_result

+ [Lift now; sort the rest later (+1m)]
    ~ time += 1
    ~ pageDamaged = true
    -> c_result


=== c_result ===
# character:character/mc
# background:backgrounds/cemetery5
You lift the page free.
+ [Continue] -> c_result_1

=== c_result_1 ===
The ink shivers but holds.
+ [Continue] -> c_result_2

=== c_result_2 ===
{pageDamaged == false:
    The text lies flat. Your shoulders come down when you check the time and see you're still on schedule.
- else:
    The fragile page rips. You can still read it, but you'll have to handle it carefully now.
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
# character:character/mc
# background:backgrounds/cemetery1
At the gate, your phone buzzes and a new achievement appears on the DEADline App.
+ [Continue] -> c_page_principles_1

=== c_page_principles_1 ===
# character:character/phone
SMART Goals:
– Specific & Relevant: say exactly what "done" is and why.
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
# character:character/mc
# background:backgrounds/library-8
The archive door drags shut and seals the air.
+ [Continue] -> a_entry_01_1

=== a_entry_01_1 ===
A desk lamp breathes a small circle of light.
+ [Continue] -> a_entry_01_2

=== a_entry_01_2 ===
Beyond it, the shelves lean like ribs.
+ [Continue] -> a_entry_01_3

=== a_entry_01_3 ===
The typewriter rattles a few keys on its own and stops, as if it choked on a word.
+ [Continue] -> a_entry_01_4

=== a_entry_01_4 ===
Your phone shows one line and a clock that does not blink: *"Finish and hand it in."*
+ [Continue] -> a_entry_01_5

=== a_entry_01_5 ===
# character:character/phone
A small card opens on the screen:
*DEADline: Finish the thesis*
• Objective: Build a clean section from the two pages, then use them to finish the thesis.
• Clue: Make headings from the page lines, read aloud, ask for help, cut once more.
• Why it matters: Finished, readable work is what will let you leave this place.
+ [Continue] -> a_entry_01_6

=== a_entry_01_6 ===
# character:character/mc
Cold slides under your cuffs.
+ [Continue] -> a_entry_01_7

=== a_entry_01_7 ===
The building listens.
+ [Continue] -> a_entry_01_8

=== a_entry_01_8 ===
# character:character/nun
Sister Agnes (near): Finish before dawn, or walk these halls with me.
+ [Continue] -> a_setup_01


=== a_setup_01 ===
# character_1:character/mc
# background:backgrounds/library-3
You place the study schedule page in the light.
+ [Continue] -> a_setup_01_1

=== a_setup_01_1 ===
# character_2:character/mc
The principles you found in the tunnels sit at the top of your notes, waiting to breathe.
+ [Continue] -> a_setup_01_2

=== a_setup_01_2 ===
# character:character/nun
Sister Agnes (near): Stop collecting scraps and build the page you will hand in.
+ [Continue] -> a_setup_01_choices

=== a_setup_01_choices ===
# character:character/mc
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
    You don't have enough time for any proper finishing method.
    The clock chews the minutes.
    + [Do what you can (run out of time)]
        ~ thesisQuality = "none"
        ~ time = deadline + 1
        -> end_result
}


=== a_result ===
# character:character/mc
You sit back and listen to the building breathe.
+ [Continue] -> a_result_1

=== a_result_1 ===
{ thesisQuality == "integrated":
    The draft reads in one breath. Your file names make sense even to future-you.
    The schedule, intentions, and revision lines sit inside your work now, visible in the steps.
    When you flip a page, the typewriter doesn't flinch.

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
+ [Continue] -> a_result_2

=== a_result_2 ===
# character:character/nun
Sister Agnes (near): A finished section carries you farther than a pile of notes.
+ [Continue] -> a_page_principles


=== a_page_principles ===
# character:character/mc
Your phone buzzes and the final achievement appears on the DEADline App.
+ [Continue] -> a_page_principles_1

=== a_page_principles_1 ===
# character:character/phone
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
    # character:character/nun
    Sister Agnes gathers from the corners of the room as dawn bleaches the windows.
    Sister Agnes: This is the Temporal Organizer. It belongs to those who finish what they start and care for their work as if it were living.
    # character:character/mc
    Your phone changes in your hand. It keeps clean versions, remembers next steps, and does the small things that used to trip you.
    # character_1:character/mc
    # character_2:character/malik
    Malik exhales.
    Malik: It feels like the opposite of panic. With this, we're going to be able to finish our own project and get through the rest of the semester.

    + [Walk out into the snow with Malik] -> end_epilogue_success

- else:
    {allTasks and onTime and (work or barely):
        # character:character/nun
        Light pushes at the windows and then hesitates. Sister Agnes stands near the typewriter, not quite smiling.
        Sister Agnes: You escaped the worst of it. Keep one list you trust. Leave room to adjust. Ask for help when you can't see what's missing.
        # character_1:character/mc
        # character_2:character/malik
        Malik: That was close... and weird. We'll have to do better next time.

        + [Step into the morning. Keep improving] -> end_epilogue_mixed

    - else:
        # character:character/mc
        The library swallows the light as the clock nears {deadline}.
        The carriage slides home with a sound like a lid.
        # character:character/nun
        Sister Agnes: This place keeps what's unfinished. Stay. Help me keep the shelves in order.

        + [The halls do not let you go] -> end_epilogue_failure
    }
}


=== end_epilogue_success ===
# character_1:character/mc
Cold air bites your cheeks as the doors open.
+ [Continue] -> end_epilogue_success_1

=== end_epilogue_success_1 ===
# character_2:character/mc
Snow drifts down in small, forgiving flakes.
+ [Continue] -> end_epilogue_success_2

=== end_epilogue_success_2 ===
# character:character/mc
Your phone shows *Today, Next Up,* and a tidy list that matches what you actually do.
+ [Continue] -> end_epilogue_success_3

=== end_epilogue_success_3 ===
# character_1:character/mc
# character_2:character/malik
Malik: No one will believe us.
+ [Continue] -> end_epilogue_success_4

=== end_epilogue_success_4 ===
But I know what to do next. And after that.
+ [Continue] -> end_epilogue_success_5

=== end_epilogue_success_5 ===
# character:character/mc
In the glass of the foyer, for a heartbeat, Sister Agnes nods once and thins to daylight.
+ [Continue] -> the_end


=== end_epilogue_mixed ===
# character:character/mc
Later that day, your reflection looks steadier.
+ [Continue] -> end_epilogue_mixed_1

=== end_epilogue_mixed_1 ===
# character_1:character/mc
You missed some polish, but your plan kept you on time.
+ [Continue] -> end_epilogue_mixed_2

=== end_epilogue_mixed_2 ===
# character_2:character/mc
You write a short check-in for yourself and add one change you will try next week.
+ [Continue] -> the_end


=== end_epilogue_failure ===
# character:character/mc
The doors do not open.
+ [Continue] -> end_epilogue_failure_1

=== end_epilogue_failure_1 ===
# character_1:character/mc
The lamps dim.
+ [Continue] -> end_epilogue_failure_2

=== end_epilogue_failure_2 ===
# character_2:character/mc
Footsteps that are not yours pass by and do not pause.
+ [Continue] -> end_epilogue_failure_3

=== end_epilogue_failure_3 ===
# character_1:character/mc
# character_2:character/malik
# background:backgrounds/library-9
Malik grips your hand.
+ [Continue] -> end_epilogue_failure_4

=== end_epilogue_failure_4 ===
# character:character/mc
You feel him count his breaths like you did in the stairwell.
+ [Continue] -> end_epilogue_failure_5

=== end_epilogue_failure_5 ===
# character:character/nun
Sister Agnes: There is work to do.
+ [Continue] -> end_epilogue_failure_6

=== end_epilogue_failure_6 ===
We will teach the living how to finish.
+ [Continue] -> the_end


=== the_end ===
# character:character/phone
Thanks for playing *DEADline Tracker*.

{deadline - time > 0:
    You finished with {deadline - time} minutes to spare.
- else:
    You didn't quite hit the DEADline.
}

+ [Restart from the beginning] -> intro_library_01
+ [Jump to Decision Point 1] -> d1_choice

=== task_hub ===
# character:character/phone
You check the DEADline App.
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
