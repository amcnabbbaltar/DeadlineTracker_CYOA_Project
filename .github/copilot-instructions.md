<!-- UNITY CODE ASSIST INSTRUCTIONS START -->
- Project name: DeadlineTracker_CYOA_Project
- Unity version: Unity 2022.3.32f1
- Active scene:
  - Name: TextAdventure_Exemple
  - Tags:
    - Untagged, Respawn, Finish, EditorOnly, MainCamera, Player, GameController
  - Layers:
    - Default, TransparentFX, Ignore Raycast, Water, UI
- Active game object:
  - Name: TypeWriter
  - Tag: Untagged
  - Layer: Default
<!-- UNITY CODE ASSIST INSTRUCTIONS END -->
<!-- UNITY CODE ASSIST INSTRUCTIONS START -->
 Project name: DeadlineTracker_CYOA_Project
 Unity version: Unity 6000.1.5f1
 Active game object:
  - Name: StressImageIndicator
  - Tag: Untagged
  - Layer: UI
<!-- UNITY CODE ASSIST INSTRUCTIONS END -->

## Copilot / AI agent quick guide (concise, codebase-specific)

Purpose: give an AI coding agent the minimal, actionable context to be productive editing this Unity + Ink interactive narrative.

Key facts
- Root: project uses Unity with Ink (see `Assets/Ink_Framework/`)
- Main narrative code: `Assets/Scripts/Basic_Narrative_Scripts/`
- Important assets:
  - Ink stories: `Assets/Dialogue_Exemples/Ink_Dialogue/` (e.g. `Story.ink`)
  - Images: `Assets/Dialogue_Exemples/images` (referenced by `NarrativePlayer.imagesPath`)

Big-picture architecture (what to know first)
- NarrativePlayer.cs (Assets/Scripts/Basic_Narrative_Scripts/NarrativePlayer.cs)
  - Core driver: holds an Ink `Story` (assigned via `inkJSONAsset`) and advances the story, renders text, creates choice buttons.
  - Handles Ink tags to change visuals/animations and to introduce waits.
  - Loads images/animations from disk using `imagesPath` / `animationsPath` + `File.ReadAllBytes` -> `Texture2D.LoadImage`.
- InkSceneLoader.cs
  - Polls the current Ink story tags for `scene:` tags and calls `SceneManager.LoadScene(sceneName)`.
- GameSession.cs
  - Simple singleton (`DontDestroyOnLoad`) that stores persistent state (e.g. `stressLevel`).
- StressTracker.cs and StressImageIndicator.cs
  - `StressTracker` polls `story.variablesState["stress"]` and writes to `GameSession.Instance.stressLevel`.
  - `StressImageIndicator` is a persistent UI overlay that lerps alpha based on `GameSession.Instance.stressLevel` and reparents to a Canvas after scene loads.

Patterns & conventions (concrete, searchable examples)
- Tags read by `NarrativePlayer.HandleTags(List<string> tags)`:
  - `background:NAME` / `background_instant:NAME`
  - `character:NAME` / `character_instant:NAME`
  - `anim:NAME` / `anim_instant:NAME`
  - `wait:SECONDS` (causes a coroutine to pause continuation)
  - `scene:SceneName` (handled by `InkSceneLoader`)
  - Example tag lines in Ink: `# background:forest` or `background:forest` on a story line — search `HandleTags` to see exact parsing
- File loading uses project-relative paths (Windows-style backslashes in `imagesPath`), e.g. `Dialogue_Exemples\images\<name>.png`.
  - Note: images are loaded via System.IO at runtime; ensure the referenced files exist at that path in the editor. (This is a discoverable fact from the code.)
- UI wiring:
  - `NarrativePlayer` expects these inspector references: `passageText`, `choiceButtonPrefab`, `choiceButtonContainer`, `storyImage`, `storyBackground`, `storyImageAnimator`.
  - Choice buttons are instantiated from `choiceButtonPrefab` and must contain a `TextMeshProUGUI` child.

Developer workflows (what you'll actually do)
- Run in Editor: open the scene that hosts NarrativePlayer and press Play.
- Ink compilation: handled by the included Ink Unity Integration (see `Assets/Ink_Framework/README.md`). Edited `.ink` files auto-compile to JSON next to the `.ink` file by default.
  - Manual recompile: use `Assets > Recompile Ink` or the inspector play button provided by the Ink package.
- When adding assets referenced by ink tags, place them under `Assets/Dialogue_Exemples/images` (or update `NarrativePlayer.imagesPath` and inspector references).

Integration points & dependencies
- Ink Unity Integration (local package at `Assets/Ink_Framework/`) — responsible for auto-compiling `.ink` -> JSON and provides runtime API (`Ink.Runtime.Story`).
- TextMeshPro (`TMPro`) and Unity UI (`Image`, `Canvas`, `Animator`, `Button`) are used across UI scripts.

Troubleshooting (discoverable from code)
- If `inkJSONAsset` is null, `NarrativePlayer.Start()` logs an error and returns — ensure a compiled JSON TextAsset is assigned.
- If images are missing, `LoadAndDisplayImage*` falls back to `cultists1` and logs a warning.
- Duplicate singletons: `GameSession` and `StressImageIndicator` use `DontDestroyOnLoad`; when reloading scenes in editor be careful to avoid creating duplicate instances.

Where to look (quick paths)
- Narrative player & tags: `Assets/Scripts/Basic_Narrative_Scripts/NarrativePlayer.cs`
- Scene routing: `Assets/Scripts/Basic_Narrative_Scripts/InkSceneLoader.cs`
- Persistent state: `Assets/Scripts/Basic_Narrative_Scripts/GameSession.cs`
- Stress sync & UI: `Assets/Scripts/Basic_Narrative_Scripts/StressTracker.cs`, `Assets/Scripts/UI/StressImageIndicator.cs`
- Ink integration docs: `Assets/Ink_Framework/README.md`
- Example story: `Assets/Dialogue_Exemples/Ink_Dialogue/Story.ink`

If anything here is missing or unclear, tell me what parts you want expanded (e.g., build steps for Windows build, how images should be packaged for builds, or a list of common scene names). I'll iterate.