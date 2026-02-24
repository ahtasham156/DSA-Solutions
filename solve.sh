#!/bin/bash

# ============================================
# 🚀 TUF+ DSA Solution - Auto Push Script
# Rozana bas ye ek command chalao: ./solve.sh
# ============================================

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${GREEN}🚀 TUF+ DSA Solution Pusher${NC}"
echo "=================================="
echo ""

# Step 1: Topic select karo
echo -e "${CYAN}📂 Topic choose karo (number daalo):${NC}"
echo ""
TOPICS=("Arrays" "Strings" "LinkedList" "Stack" "Queue" "Trees" "Tries" "Graphs" "BinarySearch" "DP" "Recursion" "Backtracking" "Heaps" "SlidingWindow" "TwoPointer" "GreedyAlgorithms")

for i in "${!TOPICS[@]}"; do
    printf "  %2d) %s\n" $((i+1)) "${TOPICS[$i]}"
done

echo ""
read -p "👉 Number daalo: " topic_num

if [[ $topic_num -lt 1 || $topic_num -gt ${#TOPICS[@]} ]]; then
    echo "❌ Galat number! Dobara try karo."
    exit 1
fi

TOPIC="${TOPICS[$((topic_num-1))]}"
echo -e "✅ Topic: ${GREEN}$TOPIC${NC}"
echo ""

# Step 2: Problem name
read -p "📝 Problem ka naam likho (e.g., Two Sum): " PROBLEM_NAME

if [[ -z "$PROBLEM_NAME" ]]; then
    echo "❌ Problem name dena zaroori hai!"
    exit 1
fi

# File name banao (spaces ko hyphen se replace)
FILE_NAME=$(echo "$PROBLEM_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
FILE_PATH="$TOPIC/${FILE_NAME}.cpp"

echo ""

# Step 3: TUF+ link
read -p "🔗 TUF+ problem ka link paste karo: " PROBLEM_LINK
echo ""

# Step 4: Difficulty
echo -e "${CYAN}⚡ Difficulty:${NC}"
echo "  1) Easy"
echo "  2) Medium"
echo "  3) Hard"
read -p "👉 Number daalo: " diff_num

case $diff_num in
    1) DIFFICULTY="Easy" ;;
    2) DIFFICULTY="Medium" ;;
    3) DIFFICULTY="Hard" ;;
    *) DIFFICULTY="Medium" ;;
esac
echo ""

# Step 5: Summary
read -p "📋 Problem ka 1-line summary (apne words mein): " SUMMARY
echo ""

# Step 6: Approach
read -p "💡 Approach kya use ki (e.g., HashMap, Two Pointer, DFS): " APPROACH
echo ""

# Step 7: Code paste karo
echo -e "${YELLOW}📄 Ab apna solution code paste karo.${NC}"
echo -e "${YELLOW}   Paste karne ke baad ek nayi line pe EOF likho aur Enter dabaao:${NC}"
echo ""

CODE=""
while IFS= read -r line; do
    [[ "$line" == "EOF" ]] && break
    CODE+="$line"$'\n'
done

# File create karo
mkdir -p "$TOPIC"

cat > "$FILE_PATH" << FILEEND
// ===========================================
// Problem: $PROBLEM_NAME
// Topic: $TOPIC
// Difficulty: $DIFFICULTY
// Platform: TUF+ (takeUforward)
// Link: $PROBLEM_LINK
// ===========================================

// Summary: $SUMMARY

// Approach: $APPROACH

$CODE
FILEEND

echo ""
echo -e "✅ File created: ${GREEN}$FILE_PATH${NC}"

# Step 8: Git push
git add .
git commit -m "Solved: $PROBLEM_NAME - $TOPIC ($DIFFICULTY)"
git push origin main 2>/dev/null || git push origin master 2>/dev/null

echo ""
echo -e "${GREEN}🟢 Done! GitHub pe push ho gaya!${NC}"
echo -e "${GREEN}🔥 Aaj ka contribution count ho gaya!${NC}"
echo ""
