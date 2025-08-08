#!/bin/bash

# AI Development Tools Configuration Installer
echo "🚀 Installing AI Development Tools Configuration..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if .claude directory exists in this repo
if [ ! -d "$SCRIPT_DIR/.claude" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "Make sure you're running this script from the ai-dev-tools-config repository root."
    exit 1
fi

# Check if ~/.claude already exists
if [ -e "$HOME/.claude" ]; then
    echo "⚠️  Warning: ~/.claude already exists."
    echo "Would you like to:"
    echo "1) Backup existing ~/.claude and continue (recommended)"
    echo "2) Remove existing ~/.claude and continue"
    echo "3) Cancel installation"
    read -p "Choose option (1/2/3): " choice
    
    case $choice in
        1)
            backup_name="$HOME/.claude.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$HOME/.claude" "$backup_name"
            echo "✅ Existing configuration backed up to $backup_name"
            ;;
        2)
            rm -rf "$HOME/.claude"
            echo "✅ Existing configuration removed"
            ;;
        3)
            echo "❌ Installation cancelled"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice. Installation cancelled."
            exit 1
            ;;
    esac
fi

# Create the symlink
ln -sf "$SCRIPT_DIR/.claude" "$HOME/.claude"

# Verify the symlink was created successfully
if [ -L "$HOME/.claude" ] && [ -e "$HOME/.claude" ]; then
    echo "✅ Successfully installed AI Development Tools Configuration!"
    echo "📁 ~/.claude now points to $SCRIPT_DIR/.claude"
    echo ""
    echo "🎉 Installation complete! Your Claude Code configuration is now active."
    echo ""
    echo "Next steps:"
    echo "• Make sure you have 'jq' installed (see README.md for instructions)"
    echo "• Restart Claude Code to see the new statusline"
    echo "• Check out the pre-configured agents in ~/.claude/agents/"
else
    echo "❌ Failed to create symlink. Please check permissions and try again."
    exit 1
fi