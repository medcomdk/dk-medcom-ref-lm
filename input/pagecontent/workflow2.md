## ServiceRequest som versioneret entitet

FHIR R4 understøtter nativt at én ressource-instans **bevarer sin logiske identifikator** (`ServiceRequest.identifier`) gennem hele livscyklussen, mens indholdet opdateres og dokumenteres via versionering og statusskift.

Det sker på to niveauer:

**Logisk identifikator** — `ServiceRequest.identifier` er stabil og uforanderlig. Den er hvad afsender, modtager og eventuelle tredjeparter (f.eks. rekvirent-system, journalsystem) refererer til på tværs af alle opdateringer.

**Teknisk version** — `ServiceRequest.meta.versionId` inkrementeres automatisk af FHIR-serveren ved hver opdatering. Kombineret med `meta.lastUpdated` giver det et fuldt revisionsspor.

---

## Konkret mønster i en henvisningskontekst

```
ServiceRequest.identifier = "REF-2024-00487"   ← uforandret hele vejen

Version 1:  status: draft    → oprettet af afsender
Version 2:  status: active   → afsendt i Bundle
Version 3:  status: on-hold  → modtager efterspørger info
            + note tilføjet: "Mangler: seneste HbA1c"
Version 4:  status: active   → supplerende info modtaget
            + supportingInfo: [ny DocumentReference]
Version 5:  status: active   → accepteret
            intent: order     ← skifter fra proposal til order
```

Alle versioner er tilgængelige via FHIR's history-mekanisme:
`GET /ServiceRequest/[id]/_history`

---

## Task som komplementær sporingsressource

Det er vigtigt at skelne: **ServiceRequest** dokumenterer *hvad* der anmodes om og i hvilken tilstand, mens **Task** dokumenterer *processen* med at håndtere anmodningen. De to ressourcer uddyber hinanden:

| Dimension | ServiceRequest | Task |
|---|---|---|
| Identifikator | Klinisk stabil (REF-nr.) | Administrativ opgave-ID |
| Statusmodel | Klinisk tilstand | Procesforløb |
| Versionering | Indholdsmæssige ændringer | Handlingsspor |
| Hvem ejer | Fælles / neutral | Én per aktør |

---

## Provenance som eksplicit revisionslog

Ønsker man et **eksplicit og signeret revisionslog** ud over `_history`, kan man supplere med `Provenance`-ressourcen, der for hver ændring angiver:

- `Provenance.target` → reference til den specifikke version (`ServiceRequest/[id]/_history/3`)
- `Provenance.recorded` → tidspunkt
- `Provenance.agent` → hvem foretog ændringen (Practitioner, Organization)
- `Provenance.reason` → årsagskode (f.eks. *info-received*, *clinical-update*)

Det giver et revisionsspor der kan auditteres uafhængigt af selve ressourcen.

---

## En praktisk overvejelse

I en **messaging-kontekst** (EHMI/Bundle) er der en subtil men vigtig pointe: selve bundtet er uforanderligt efter afsendelse — det er et forseglet snapshot. Det er *ikke* bundtet der opdateres, men den underliggende ServiceRequest-instans på FHIR-serveren. Nye bundter (f.eks. `referral-info-response`) bærer en opdateret kopi af ServiceRequest med ny versionId, og modtager-systemet anvender `ServiceRequest.identifier` til at matche og erstatte sin lokale instans.

Identifikatoren fungerer altså som **den røde tråd** der binder alle meddelelses-udvekslinger sammen til ét sammenhængende forløb.

