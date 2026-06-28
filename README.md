cat > README.md << 'EOF'
# AI Business Analyst iOS

A SwiftUI iOS app that consumes the AI Business Analyst backend API.

The app allows users to ask business questions and displays the answer, identified metric, and confidence score returned by the backend.

## Related Project

Backend repository:

https://github.com/RodrigoFFLima/ai-business-analyst

## Current Version

This first version connects to a local FastAPI backend running on:

~~~text
http://127.0.0.1:8000
~~~

It sends questions to:

~~~http
POST /api/ask
~~~

And displays:

- Answer
- Identified metric
- Confidence score

## Tech Stack

- Swift
- SwiftUI
- Async/Await
- URLSession
- MVVM

## Project Structure

~~~text
AIBusinessAnalyst/
  Models/
    AskRequest.swift
    AskResponse.swift
  Services/
    BusinessAnalystService.swift
  ViewModels/
    AskViewModel.swift
  Views/
    AskView.swift
  AIBusinessAnalystApp.swift
~~~

## Features

- Ask business questions from an iOS interface
- Consume a Python/FastAPI backend
- Decode JSON responses using Codable
- Display semantic layer result
- Display confidence score
- Handle loading and error states

## Example Questions

~~~text
Qual foi a receita total?
Quantos pedidos tivemos?
Qual foi o ticket médio?
Qual foi o produto mais vendido?
~~~

## Example Response

~~~json
{
  "question": "Qual foi a receita total?",
  "metric": "revenue",
  "confidence_score": 0.83,
  "answer": "A receita total foi de R$ 128.450,75."
}
~~~

## How to Run

### 1. Start the backend

In the backend repository:

~~~bash
cd ~/Projetos/ai-business-analyst
source .venv/bin/activate
uvicorn app.main:app --reload
~~~

Backend docs:

~~~text
http://localhost:8000/docs
~~~

### 2. Run the iOS app

Open the project in Xcode:

~~~bash
open AIBusinessAnalyst.xcodeproj
~~~

Select an iPhone simulator and run the app.

## Roadmap

- [x] Create SwiftUI app
- [x] Connect to FastAPI backend
- [x] Display answer, metric, and confidence score
- [ ] Add question history
- [ ] Add predefined question suggestions
- [ ] Improve UI styling
- [ ] Add environment-based API configuration
- [ ] Support physical iPhone testing
- [ ] Add screenshots to README

## Learning Goals

This project is part of a personal study plan focused on combining:

- SwiftUI mobile development
- Python backend development
- Semantic Layer concepts
- AI Engineering
- Future LLM observability with Langfuse
EOF