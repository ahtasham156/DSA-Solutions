#!/bin/bash

# ============================================
# 🚀 TUF+ DSA Solution - Auto Push Script
# Sirf 2 cheez: Link + Code. Bas!
# Usage: ./solve.sh
# ============================================

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}🚀 TUF+ Solution Pusher${NC}"
echo "========================"
echo ""

# Step 1: Sirf link paste karo
read -p "🔗 TUF+ link paste karo: " LINK

if [[ -z "$LINK" ]]; then
    echo "❌ Link dena zaroori hai!"
    exit 1
fi

# URL se automatically sab extract karo
# Example: https://takeuforward.org/plus/dsa/problems/trie-implementation-and-operations?category=tries
PROBLEM_SLUG=$(echo "$LINK" | grep -oE 'problems/[^?]+' | sed 's|problems/||')
TOPIC_SLUG=$(echo "$LINK" | tr '&?' '\n' | grep '^category=' | sed 's|category=||' | head -1)

# Slug se readable name banao (hyphens -> spaces -> Title Case)
PROBLEM_NAME=$(echo "$PROBLEM_SLUG" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')
FILE_NAME="$PROBLEM_SLUG"

# Topic mapping
case "$TOPIC_SLUG" in
    arrays|array) TOPIC="Arrays" ;;
    strings|string) TOPIC="Strings" ;;
    linked-list|linkedlist) TOPIC="LinkedList" ;;
    stack*) TOPIC="Stack" ;;
    queue*) TOPIC="Queue" ;;
    trees|binary-trees|bst) TOPIC="Trees" ;;
    tries*) TOPIC="Tries" ;;
    graphs|graph) TOPIC="Graphs" ;;
    binary-search) TOPIC="BinarySearch" ;;
    dp|dynamic-programming) TOPIC="DP" ;;
    recursion) TOPIC="Recursion" ;;
    backtracking) TOPIC="Backtracking" ;;
    heaps|heap|priority-queue) TOPIC="Heaps" ;;
    sliding-window) TOPIC="SlidingWindow" ;;
    two-pointer*) TOPIC="TwoPointer" ;;
    greedy*) TOPIC="GreedyAlgorithms" ;;
    *) TOPIC=$(echo "$TOPIC_SLUG" | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | tr -d ' ') ;;
esac

echo ""
echo -e "  📂 Topic: ${GREEN}$TOPIC${NC}"
echo -e "  📝 Problem: ${GREEN}$PROBLEM_NAME${NC}"
echo ""

# Step 2: Sirf code paste karo
echo -e "${YELLOW}📄 Code paste karo, phir nayi line pe EOF likh ke Enter dabaao:${NC}"
echo ""

CODE=""
while IFS= read -r line; do
    [[ "$line" == "EOF" ]] && break
    CODE+="$line"$'\n'
done

# File banao
mkdir -p "$TOPIC"
FILE_PATH="$TOPIC/${FILE_NAME}.cpp"

cat > "$FILE_PATH" << FILEEND
// Problem: $PROBLEM_NAME
// Topic: $TOPIC
// Platform: TUF+ (takeUforward)
// Link: $LINK

$CODE
FILEEND

# Git push
git add .
git commit -q -m "Solved: $PROBLEM_NAME - $TOPIC"
git push -q origin main 2>/dev/null || git push -q origin master 2>/dev/null

echo ""
echo -e "${GREEN}🟢 Push ho gaya! Aaj ka green box done! 🔥${NC}"
echo ""
