# AI Business Analyst iOS

A SwiftUI iOS app that consumes the AI Business Analyst backend API.

The app allows users to ask business questions and displays the answer, identified metric, and confidence score returned by the backend.

## Related Project

Backend repository:

https://github.com/RodrigoFFLima/ai-business-analyst

## Current Version

This version connects to a local FastAPI backend running on:

```text
http://127.0.0.1:8000
```

It sends questions to:

```http
POST /api/ask
```

And displays:

* Answer
* Identified metric
* Confidence score
* Suggested questions
* Session history

## Tech Stack

* Swift
* SwiftUI
* Async/Await
* URLSession
* Codable
* MVVM
* TabView

## Project Structure

```text
AIBusinessAnalyst/
  Models/
    AskRequest.swift
    AskResponse.swift
    QuestionHistoryItem.swift

  Services/
    BusinessAnalystService.swift

  ViewModels/
    AskViewModel.swift

  Views/
    MainTabView.swift
    AskView.swift
    HistoryView.swift

  AIBusinessAnalystApp.swift
```

## Features

* Ask business questions from an iOS interface
* Consume a Python/FastAPI backend
* Decode JSON responses using Codable
* Display semantic layer result
* Display confidence score
* Show suggested questions
* Store session history in memory
* Navigate between Home and History using a bottom tab bar
* Handle loading and error states
* Disable the ask button when the input is invalid

## Screens

### Home

The Home screen allows the user to:

* Type a business question
* Tap suggested questions
* Send the question to the backend
* View the latest answer
* View the identified metric
* View the confidence score

### History

The History screen allows the user to:

* View previous questions asked during the current session
* See the answer, metric, and confidence score for each item
* Clear the session history

## Example Questions

```text
Qual foi a receita total?
Quantos pedidos tivemos?
Qual foi o ticket médio?
Qual foi o produto mais vendido?
```

## Example Response

```json
{
  "question": "Qual foi a receita total?",
  "metric": "revenue",
  "confidence_score": 0.83,
  "answer": "A receita total foi de R$ 128.450,75."
}
```

## How to Run

### 1. Start the backend

In the backend repository:

```bash
cd ~/Projetos/ai-business-analyst
source .venv/bin/activate
uvicorn app.main:app --reload
```

Backend docs:

```text
http://localhost:8000/docs
```

### 2. Run the iOS app

Open the project in Xcode:

```bash
cd ~/Projetos/ai-business-analyst-ios
open AIBusinessAnalyst.xcodeproj
```

Select an iPhone simulator and run the app.

## Local API Configuration

The app currently uses:

```text
http://127.0.0.1:8000
```

This works for the iOS Simulator when the backend is running locally on the Mac.

For testing on a physical iPhone, the backend should be exposed using the Mac local network IP and Uvicorn should run with:

```bash
uvicorn app.main:app --host 0.0.0.0 --reload
```

## Roadmap

* [x] Create SwiftUI app
* [x] Connect to FastAPI backend
* [x] Display answer, metric, and confidence score
* [x] Add suggested questions
* [x] Add session history
* [x] Move history to bottom tab navigation
* [x] Improve button validation
* [ ] Improve UI styling
* [ ] Add persistent local history
* [ ] Add environment-based API configuration
* [ ] Support physical iPhone testing
* [ ] Add screenshots to README

## Learning Goals

This project is part of a personal study plan focused on combining:

* SwiftUI mobile development
* Python backend development
* Semantic Layer concepts
* AI Engineering
* Future LLM observability with Langfuse

The goal is to build a small but realistic client/server application that connects mobile development with AI/Data backend concepts.
