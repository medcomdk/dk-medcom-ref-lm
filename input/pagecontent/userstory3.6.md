<!--
### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

> **User story:** Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, <br/>når jeg opdager en fejl i en modtaget henvisning, <br/>så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

<p style="display: block;">
<img src="UC-3-6-Korrektionsaftale.svg" alt="UC-3-6" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende opdatering af `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Communication`, `ServiceRequest` (korrektion) |
| **Triggerhændelse:** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(fejl opdaget, korrektionsdiolog indledes)* |
| **Næste trin:** | → [1.3 Ændre en afsendt henvisning](#user-story-12-ændre-en-afsendt-henvisning) *(henviser retter og sender)* · <br/>→ [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage efter korrektion)* |
{: .grid}

-->