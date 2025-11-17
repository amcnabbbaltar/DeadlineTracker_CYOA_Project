import sys
path = r"c:\Users\mcnabbba\Documents\GitHub\DeadlineTracker_CYOA_Project\Assets\Dialogue_Exemples\Ink_Dialogue\Story.ink"
with open(path, 'r', encoding='utf-8') as f:
    lines = f.read().splitlines()
stack = []
for i, line in enumerate(lines, 1):
    for c in line:
        if c == '{':
            stack.append((i, line.strip()))
        elif c == '}':
            if stack:
                stack.pop()
            else:
                print('Extra closing brace at', i)
print('Remaining opens:', len(stack))
for ln, txt in stack:
    print('Open at', ln, ':', txt)
