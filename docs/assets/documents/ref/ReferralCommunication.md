# Referral Communication - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Referral Communication**

## Referral Communication

Her er `Communication`-ressourcen udtrykt som FSH (FHIR Shorthand) — både selve profilen, en instans og et valueset til category-koden.Filen indeholder fire sammenhængende FSH-artefakter:

**`MedComReferralCommunicationCategoryCS`** — et CodeSystem med tre koder: `referral-info-request`, `referral-info-response` og `referral-administrative`. Disse er de koder der giver `Communication.category` sin faglige semantik i et EHMI-flow.

**`MedComReferralCommunicationCategoryVS`** — et ValueSet der binder de tre koder og bruges som `required` binding på profilen, så ingen andre kategorier kan benyttes.

**`DkReferralInfoRequestCommunication`** — selve profilen. De vigtigste constraints:

* `status` låses til `#completed` med forklaring om at livscyklus styres via `Task`, ikke `Communication`
* `basedOn` er `1..1 MS` og kun tillader `ServiceRequest` — den er obligatorisk og er det der binder alt sammen
* `payload` er slicet i to: `textContent` (1..1, `contentString`) sikrer at der altid er en menneskelig fritekstbegrundelse, og `docReference` (0..*, `contentReference`) tillader strukturerede dokumentreferencer

**`ReferralInfoRequestExample`** — en komplet instans for en diabetisk retinopati-henvisning, inkl. den konkrete forespørgselstekst og reference til en `Questionnaire`. Støtte-instanserne (`Patient`, `Organization`, `ServiceRequest`, `Task`, `Questionnaire`) giver en kontekst der kan kompileres med SUSHI uden fejl.

Filen er klar til at indgå i en SUSHI-baseret FHIR IG med en `sushi-config.yaml` der peger på FSH-mappen.

