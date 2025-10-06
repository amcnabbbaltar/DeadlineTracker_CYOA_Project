VAR stress = 0

-> start

=== start ===
You wake up to the sound of your alarm. It's 8:30 AM — your class starts at 9:00.

+ [Snooze the alarm and sleep a bit longer.]
    ~ stress += 2
    You sleep for another 15 minutes. When you wake up again, your heart races.
    -> after_alarm

+ [Get up immediately and start getting ready.]
    ~ stress -= 1
    You push yourself out of bed and start moving.
    -> after_alarm

+ [Check your phone first.]
    ~ stress += 1
    You scroll through messages and see a few unread emails from your teacher.
    -> after_alarm

=== after_alarm ===
You grab your bag and head for the door.

+ [Skip breakfast to save time.]
    ~ stress += 1
    You leave quickly, stomach empty.
    -> arrive_school

+ [Make a quick coffee.]
    You brew a quick cup and take it with you.
    -> arrive_school

+ [Sit down and have a full breakfast anyway.]
    ~ stress -= 1
    You eat calmly before heading out.
    -> arrive_school

=== arrive_school ===
By the time you reach school, you reflect on your morning.

{stress <= 0:
    You feel grounded and ready for the day.
- else:
    {stress <= 2:
        You’re a little on edge, but focused.
    - else:
        You feel tense and distracted — it's going to be a tough day.
    }
}

-> END
