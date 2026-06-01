Her er et konkret eksempel på en `Communication`-ressource udtrykt som en logisk model — visuel og med fuld kontekst.Klik på de farvede bokse for at udforske de enkelte ressourcer. Her er de centrale designvalg i eksemplet:

**`status: in-progress`** er bevidst valgt frem for `completed`. En forespørgsel er ikke afsluttet, blot fordi den er sendt — den skifter til `completed` først når afsender har kvitteret med svar. Det afspejler at `Communication` modellerer en *dialog*, ikke blot en envejs-besked.

**To `payload`-entries** viser det dobbelte formål: `payload[0]` er den menneskelæsbare instruktion i fritekst, mens `payload[1]` er en struktureret reference til en `DocumentReference` der specificerer hvilken dokumenttype der efterspørges (HbA1c, LOINC-kodet). Det giver modtagersystemet mulighed for at håndtere forespørgslen maskinelt.

**`DocumentReference.status: requested`** er en lokal konvention for at signalere at dokumentet endnu ikke er vedlagt — det er et placeholder der erstattes når afsender responderer med `referral-info-response`.

**Rolleomvendingen** er værd at bemærke: i selve forespørgselsmeddelelsen er `sender` kardiologisk afdeling (den oprindelige *modtager* af henvisningen) og `recipient` er lægepraksis (den oprindelige *afsender*). `basedOn`-referencen til `ServiceRequest` er det der binder de to retninger sammen til ét sammenhængende forløb.