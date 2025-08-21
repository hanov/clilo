#!/usr/bin/env python3

import json
import sys
import warnings
warnings.filterwarnings("ignore")
import requests

def main():
    if len(sys.argv) < 2:
        print("Usage: clilo <query>", file=sys.stderr)
        sys.exit(1)
    
    user_content = " ".join(sys.argv[1:])
    system_prompt = "You are expert in Linux commands and providing example commands. Return only one command without other comments. Do not quote the code."
    
    payload = {
        "model": "gemma3:4b",
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_content}
        ],
        "options": {
            "temperature": 0.22
        },
        "stream": False
    }
    
    try:
        response = requests.post(
            "http://localhost:11434/api/chat",
            headers={"Content-Type": "application/json"},
            json=payload
        )
        response.raise_for_status()
        
        result = response.json()
        print(result["message"]["content"], end="")
        
    except:
        pass

if __name__ == "__main__":
    main()
