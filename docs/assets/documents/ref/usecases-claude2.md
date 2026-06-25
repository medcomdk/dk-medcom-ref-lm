# Usecases Claude 2 - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Usecases Claude 2**

## Usecases Claude 2

Her er oversigten. Klik på en use case for at få den uddybet.

**Strukturen i oversigten:**

**Henviser (venstre)** har use cases der handler om at skabe, vedligeholde og følge op på egne henvisninger — fra oprettelse og tilknytning af klinisk dokumentation til at modtage afgørelser tilbage.

**Visitator (højre)** har use cases centreret om modtagelse, vurdering og afgørelse — herunder triage, accept/afvisning, videresendelse og prioritetsændring.

**Udvekslingsdialogen (midten)** dækker de situationer der kun giver mening som en frem-og-tilbage udveksling: supplement-anmodninger, faglig afklaring, statusnotifikationer og korrektionsaftaler.

**FHIR-ressourcerne** der primært er i spil er `ServiceRequest` (selve henvisningen), `Task` (workflow-styring og triage-udfald), `Communication` / `CommunicationRequest` (dialogmeddelelser) og `SubscriptionNotification` (push-notifikationer ved statusskift).

