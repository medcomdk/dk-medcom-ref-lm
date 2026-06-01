Her er et detaljeret flowdiagram over et FHIR messaging-baseret henvisningsflow med den scenarie, du beskriver — inkl. statusskift og nøgleskift på centrale ressourcer.Du kan klikke på enhver boks for at få uddybning. Her er en forklaring af de centrale dele af flowet:

**Fase 1 — Afsendelse**
Afsender opretter en `ServiceRequest` (status: *draft*) og en `Task` (status: *draft*), pakker dem i et FHIR `Bundle` af typen `message` med en `MessageHeader` der angiver event-kode (f.eks. `referral-request`). Ved afsendelse skifter `ServiceRequest` til *active* og `Task` til *requested*.

**Fase 2 — Modtagelse og kvittering**
Modtager validerer bundtet mod det rette endpoint, parser og gemmer ressourcerne. En synkron eller asynkron ACK-besked (en `MessageHeader` med `response`-element) sendes retur. Modtagers lokale `Task` oprettes med status *received*.

**Fase 3 — Efterspørgsel af supplerende oplysninger**
Modtager vurderer at der mangler klinisk information (f.eks. laboratoriesvar, billeddiagnostik, tidligere epikriser). En ny bundle sendes retur med event `referral-info-request` og en `Communication`-ressource der præciserer hvad der ønskes. Modtagers `Task` sættes til *on-hold* med en statusreason der angiver `info-needed`.

**Fase 4 — Afsender supplerer**
Afsender svarer med en ny bundle indeholdende en `Communication` (svar), og evt. nye `DocumentReference`-ressourcer med de ønskede dokumenter. Event-koden er `referral-info-response`. Modtagers `Task` skifter til *in-progress* når oplysningerne behandles.

**Fase 5 — Endelig accept**
Modtager accepterer endeligt og sender en bundle med event `referral-accept`. `Task` hos modtager sættes til *accepted* (eller *completed* afhængigt af implementering). Afsenders lokale `Task` opdateres tilsvarende, og patienten kan notificeres.

**Særlige ressourcer at bemærke:**
`Communication` er den centrale ressource til den strukturerede dialog i fase 3-4 — den linkes til den originale `ServiceRequest` via `Communication.basedOn`. `MessageHeader.event` bærer semantikken for hvilken handling bundtet repræsenterer, og `Task` er den sporbarheds-ressource der holder det samlede procesforløb.