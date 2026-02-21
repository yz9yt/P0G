#!/usr/bin/env bash
set -euo pipefail

# P0G Installer — Sets up P0G in the current directory
#
# Quick install (into current project):
#   curl -sSL https://raw.githubusercontent.com/yz9yt/P0G/main/install.sh | bash
#
# Install globally (p0g-init command available everywhere):
#   curl -sSL https://raw.githubusercontent.com/yz9yt/P0G/main/install.sh | bash -s -- --global
#
# Then from any project: p0g-init

P0G_REPO="https://github.com/yz9yt/P0G.git"
P0G_TMP="/tmp/p0g-install-$$"
GLOBAL_INSTALL=false

# Parse args
for arg in "$@"; do
  case "$arg" in
    --global|-g) GLOBAL_INSTALL=true ;;
  esac
done

# Colors (works on macOS and Linux)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

header() {
  echo ""
  echo -e "${CYAN}${BOLD}"
  echo "  ╔═══════════════════════════════════════╗"
  echo "  ║       P0G — Project 0 Gravity         ║"
  echo "  ║          Installer v1.2                ║"
  echo "  ╚═══════════════════════════════════════╝"
  echo -e "${NC}"
}

info()    { echo -e "  ${GREEN}✓${NC} $1"; }
warn()    { echo -e "  ${YELLOW}!${NC} $1"; }
fail()    { echo -e "  ${RED}✗${NC} $1"; exit 1; }
step()    { echo -e "\n  ${BOLD}$1${NC}"; }

cleanup() { rm -rf "$P0G_TMP"; }
trap cleanup EXIT

# ─────────────────────────────────────────────
# Global install: put p0g-init in PATH
# ─────────────────────────────────────────────

if [ "$GLOBAL_INSTALL" = true ]; then
  header
  step "Installing p0g-init globally..."

  command -v git >/dev/null 2>&1 || fail "git is required."

  # Determine install directory
  if [ -d "$HOME/.local/bin" ]; then
    INSTALL_DIR="$HOME/.local/bin"
  elif [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
  else
    mkdir -p "$HOME/.local/bin"
    INSTALL_DIR="$HOME/.local/bin"
  fi

  # Create the p0g-init wrapper script
  cat > "$INSTALL_DIR/p0g-init" <<'WRAPPER'
#!/usr/bin/env bash
# p0g-init — Set up P0G in the current directory
# Installed by P0G global installer
curl -sSL https://raw.githubusercontent.com/yz9yt/P0G/main/install.sh | bash
WRAPPER

  chmod +x "$INSTALL_DIR/p0g-init"
  info "p0g-init installed to $INSTALL_DIR/p0g-init"

  # Check if directory is in PATH
  if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
    warn "$INSTALL_DIR is not in your PATH."
    echo ""

    # Detect shell config file
    SHELL_NAME="$(basename "${SHELL:-/bin/bash}")"
    case "$SHELL_NAME" in
      zsh)  SHELL_RC="$HOME/.zshrc" ;;
      bash)
        if [ -f "$HOME/.bash_profile" ]; then
          SHELL_RC="$HOME/.bash_profile"
        else
          SHELL_RC="$HOME/.bashrc"
        fi
        ;;
      *)    SHELL_RC="$HOME/.profile" ;;
    esac

    echo -e "  Add this to ${BOLD}${SHELL_RC}${NC}:"
    echo ""
    echo -e "    ${CYAN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    echo ""
    echo -e "  Then run: ${BOLD}source ${SHELL_RC}${NC}"
  fi

  echo ""
  echo -e "  ${GREEN}${BOLD}Done!${NC} Now go to any project and run: ${BOLD}p0g-init${NC}"
  echo ""
  exit 0
fi

# ─────────────────────────────────────────────
# Local install: set up P0G in current directory
# ─────────────────────────────────────────────

header

step "Checking requirements..."

command -v git >/dev/null 2>&1 || fail "git is required. Install it and try again."
info "git found"

# Check we're not inside the P0G repo itself
if [ -f "install.sh" ] && grep -q "P0G Installer" install.sh 2>/dev/null; then
  fail "You're inside the P0G repo. Run this from YOUR project directory instead."
fi

# Check if P0G is already installed
if [ -d ".agent/workflows" ] && ls .agent/workflows/p0g-*.md >/dev/null 2>&1; then
  warn "P0G workflows already detected in this directory."
  echo ""
  read -rp "  Overwrite existing P0G files? [y/N] " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "\n  Aborted. No changes made."
    exit 0
  fi
fi

# --- Clone ---

step "Downloading P0G..."

git clone --quiet --depth 1 "$P0G_REPO" "$P0G_TMP" || fail "Failed to clone P0G repository."
info "Downloaded from github.com/yz9yt/P0G"

# --- Copy files ---

step "Installing into $(pwd)..."

# Create directory structure
mkdir -p .agent/workflows
mkdir -p agents/p0g/prompts
mkdir -p agents/p0g/skills
mkdir -p .p0g/backups
mkdir -p .p0g/snapshots
mkdir -p .p0g/checkpoints

# Copy workflows
cp "$P0G_TMP"/.agent/workflows/p0g-*.md .agent/workflows/
WF_COUNT=$(ls .agent/workflows/p0g-*.md 2>/dev/null | wc -l | tr -d ' ')
info "$WF_COUNT workflows → .agent/workflows/"

# Copy agent prompts
cp "$P0G_TMP"/agents/p0g/prompts/*.md agents/p0g/prompts/
PROMPT_COUNT=$(ls agents/p0g/prompts/*.md 2>/dev/null | wc -l | tr -d ' ')
info "$PROMPT_COUNT agent prompts → agents/p0g/prompts/"

# Copy skills
cp "$P0G_TMP"/agents/p0g/skills/*.md agents/p0g/skills/
info "Safety skill → agents/p0g/skills/"

# Copy .p0g README files
for dir in backups snapshots checkpoints; do
  if [ -f "$P0G_TMP/.p0g/$dir/README.md" ]; then
    cp "$P0G_TMP/.p0g/$dir/README.md" ".p0g/$dir/README.md"
  fi
done
info "Backup infrastructure → .p0g/"

# Copy root files (skip if they already exist)
if [ ! -f "AGENTS.md" ]; then
  cp "$P0G_TMP/AGENTS.md" .
  info "AGENTS.md created"
else
  warn "AGENTS.md exists — kept yours"
fi

if [ ! -f "progress.txt" ]; then
  cp "$P0G_TMP/progress.txt" .
  info "progress.txt created"
else
  warn "progress.txt exists — kept yours"
fi

# --- .gitignore ---

P0G_GITIGNORE_ENTRIES="# P0G internal state
.p0g/backups/*.tar.gz
.p0g/snapshots/*.tar.gz
.p0g/checkpoints/*.tar.gz
.p0g/state.json
.p0g/surgery.json
.p0g/surgery_completed_*.json"

if [ -f ".gitignore" ]; then
  if ! grep -q ".p0g/backups/" .gitignore 2>/dev/null; then
    printf "\n%s\n" "$P0G_GITIGNORE_ENTRIES" >> .gitignore
    info "P0G entries added to .gitignore"
  else
    warn ".gitignore already has P0G entries"
  fi
else
  printf "%s\n" "$P0G_GITIGNORE_ENTRIES" > .gitignore
  info ".gitignore created"
fi

# --- Done ---

echo ""
echo -e "  ${GREEN}${BOLD}P0G installed successfully!${NC}"
echo ""
echo -e "  ${BOLD}Next steps:${NC}"
echo ""
echo -e "  ${CYAN}1.${NC} Open this folder in ${BOLD}Antigravity${NC}"
echo -e "  ${CYAN}2.${NC} Type ${BOLD}/p0g-np${NC} to start your project"
echo -e "  ${CYAN}3.${NC} Follow the flow: /p0g-np → /p0g-plan → /p0g-tasks → /p0g-loop"
echo ""
echo -e "  ${BOLD}Commands:${NC}"
echo -e "    /p0g-np        Discovery — what are we building?"
echo -e "    /p0g-plan      Architecture — how do we build it?"
echo -e "    /p0g-tasks     Tasks — what to do first?"
echo -e "    /p0g-loop      Execute — build it autonomously"
echo -e "    /p0g-surgeon   Fix — decompose bugs into micro-fixes"
echo ""
echo -e "  ${BOLD}Models:${NC}"
echo -e "    /p0g-np        Gemini 3.1 Pro · Medium"
echo -e "    /p0g-plan      Gemini 3.1 Pro · High"
echo -e "    /p0g-tasks     Gemini 3.1 Pro · Medium"
echo -e "    /p0g-loop      Gemini 3 Flash"
echo -e "    /p0g-surgeon   Gemini 3.1 Pro · High → Medium"
echo ""
