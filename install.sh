#!/bin/sh

# Determine the shell profile file
if [ -n "$ZSH_VERSION" ]; then
    PROFILE_FILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    PROFILE_FILE="$HOME/.bashrc"
elif [ -f "$HOME/.profile" ]; then
    PROFILE_FILE="$HOME/.profile"
else
    echo "Unsupported shell. Please add the alias manually to your shell profile."
    exit 1
fi

# Prompt user for confirmation
echo "This script will add the alias 'git st' to expand to 'git status' in your shell profile ($PROFILE_FILE)."
echo "Do you want to proceed? (y/n)"
read -r RESPONSE

if [ "$RESPONSE" != "y" ] && [ "$RESPONSE" != "Y" ]; then
    echo "Installation aborted by user."
    exit 0
fi


# Define the alias
ALIAS_CMD="alias gitst='git status'"

# Check if the alias already exists
if grep -q "$ALIAS_CMD" "$PROFILE_FILE"; then
    echo "Alias already exists in $PROFILE_FILE"
else
    # Add the alias to the profile file
    echo "$ALIAS_CMD" >> "$PROFILE_FILE"
    echo "Alias added to $PROFILE_FILE"
fi

# Apply the changes
if [ -n "$ZSH_VERSION" ]; then
    source "$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    source "$HOME/.bashrc"
elif [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

echo "Installation complete. You can now use 'git st' to run 'git status'."
